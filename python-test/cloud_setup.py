from jinja2 import Template
from python_terraform import Terraform
import os
import shutil
from datetime import datetime
import boto3
import json
import time

class CloudSetup:
    def __init__(self):
        self.ami_options = {
            "ubuntu": "ami-010045ee1d3ea738b",
            "amazon": "ami-0062355a529d6089c"
        }
        self.instance_types = {
            "small": "t3.small",
            "medium": "t3.medium"
        }
        self.region = "us-east-1"
        self.availability_zone = "us-east-1a"
        self.tf = None
        self.ec2 = None
        self.elbv2 = None

    def get_user_input(self):
        """Get and validate user inputs"""
        # AMI choice
        ami_choice = input("Pick an AMI (ubuntu or amazon): ").lower()
        if ami_choice not in self.ami_options:
            print("nah, that’s wrong, Going with ubuntu!")
            ami_choice = "ubuntu"

        # Instance type choice
        instance_type_choice = input("Pick size (small or medium): ").lower()
        if instance_type_choice not in self.instance_types:
            print("nah, that’s wrong, I'll pick small for you.")
            instance_type_choice = "small"

        # Region validation
        region_input = input("Which region? (like us-east-1): ")
        if region_input != self.region:
            print(f"Sorry, only {self.region} works. Using that instead!")

        # Load balancer name
        load_balancer_name = input("What's the name for your load balancer? ")

        return {
            'ami': self.ami_options[ami_choice],
            'instance_type': self.instance_types[instance_type_choice],
            'load_balancer_name': load_balancer_name
        }

    def generate_terraform_template(self, inputs):
        """Generate and save Terraform template"""
        timestamp = datetime.now().strftime("%Y%m%d%H%M%S") # add time stamp for more unique name
        
        terraform_template = """
        provider "aws" {
        region = "{{ region }}"
        }

        data "aws_vpc" "default" {
        default = true
        }

        resource "aws_subnet" "public" {
        count             = 2
        vpc_id            = data.aws_vpc.default.id
        cidr_block        = "172.31.${96 + count.index}.0/24"
        availability_zone = element(["us-east-1a", "us-east-1b"], count.index)
        map_public_ip_on_launch = true
        }

        resource "aws_instance" "web_server" {
        ami           = "{{ ami }}"
        instance_type = "{{ instance_type }}"
        availability_zone = "{{ availability_zone }}"
        security_groups = [aws_security_group.lb_sg.id]
        subnet_id     = aws_subnet.public[0].id
        tags = {
            Name = "WebServer"
        }
        }

        resource "aws_lb" "application_lb" {
        name               = "{{ load_balancer_name }}"
        internal           = false
        load_balancer_type = "application"
        security_groups    = [aws_security_group.lb_sg.id]
        subnets            = aws_subnet.public[*].id
        }

        resource "aws_security_group" "lb_sg" {
        name        = "lb_sg_{{ load_balancer_name }}_{{ timestamp }}"  # Use Jinja2 variables
        description = "Allow HTTP inbound traffic"
        vpc_id      = data.aws_vpc.default.id
        ingress {
            from_port   = 80
            to_port     = 80
            protocol    = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
        }
        
        # Add egress rule to allow all outbound traffic
        egress {
            from_port   = 0
            to_port     = 0
            protocol    = "-1"
            cidr_blocks = ["0.0.0.0/0"]
        }
        }

        resource "aws_lb_listener" "http_listener" {
        load_balancer_arn = aws_lb.application_lb.arn
        port              = 80
        protocol          = "HTTP"
        default_action {
            type             = "forward"
            target_group_arn = aws_lb_target_group.web_target_group.arn
        }
        }

        resource "aws_lb_target_group" "web_target_group" {
        name     = "web-tg-{{ load_balancer_name }}-{{ timestamp }}"  # Added timestamp for uniqueness
        port     = 80
        protocol = "HTTP"
        vpc_id   = data.aws_vpc.default.id
        health_check {
            path                = "/"
            port                = "80"
            protocol            = "HTTP"
            healthy_threshold   = 2
            unhealthy_threshold = 2
            timeout             = 5
            interval            = 10
        }
        }

        resource "aws_lb_target_group_attachment" "web_instance_attachment" {
        target_group_arn = aws_lb_target_group.web_target_group.arn
        target_id        = aws_instance.web_server.id
        }

        output "instance_id" {
        value = aws_instance.web_server.id
        }

        output "lb_dns_name" {
        value = aws_lb.application_lb.dns_name
        }
        """
        # fill in the template with user stuff
        template = Template(terraform_template)
        filled_template = template.render(
            region=self.region,
            ami=inputs['ami'],
            instance_type=inputs['instance_type'],
            availability_zone=self.availability_zone,
            load_balancer_name=inputs['load_balancer_name'],
            timestamp=timestamp
        )
        # write to file 
        with open("my_terraform.tf", "w") as file:
            file.write(filled_template)
        return timestamp

    def cleanup_terraform_files(self):
        """Clean up existing Terraform files"""
        for file in ["terraform.tfstate", "terraform.tfstate.backup", ".terraform.lock.hcl"]:
            if os.path.exists(file):
                os.remove(file)
        if os.path.exists(".terraform"):
            shutil.rmtree(".terraform")

    def initialize_terraform(self):
        """Initialize Terraform"""
        self.tf = Terraform(working_dir=".", terraform_bin_path="terraform")
        init_return_code, _, init_stderr = self.tf.init(capture_output=False)
        if init_return_code != 0:
            raise Exception(f"Terraform init failed: {init_stderr}")

    def apply_terraform(self):
        """Apply Terraform configuration with a plan step"""
        try:
            print("Running terraform apply...")
            apply_return_code, _, apply_stderr = self.tf.apply(auto_approve=True, capture_output=False)
            if apply_return_code != 0:
                if "InvalidSubnet.Conflict" in apply_stderr:
                    raise Exception("Subnet CIDR conflict detected. Please try different CIDR blocks.")
                raise Exception(f"Terraform apply failed: {apply_stderr}")
            
            outputs = self.tf.output()
            return {
                'instance_id': outputs.get("instance_id", {}).get("value"),
                'lb_dns_name': outputs.get("lb_dns_name", {}).get("value")
            }
        except Exception as e:
            print(f"Error during Terraform apply: {str(e)}")
            raise

    def initialize_aws_clients(self):
        """Initialize AWS clients"""
        self.ec2 = boto3.client('ec2', region_name=self.region)
        self.elbv2 = boto3.client('elbv2', region_name=self.region)

    def validate_resources(self, instance_id, load_balancer_name):
        """Validate AWS resources and save results"""
        instance = self.wait_for_instance(instance_id)
        instance_state = instance['State']['Name']
        public_ip = instance.get('PublicIpAddress', 'Not assigned')
        
        lb_response = self.elbv2.describe_load_balancers(Names=[load_balancer_name])
        lb_dns = lb_response['LoadBalancers'][0]['DNSName']
        
        validation_data = {
            "instance_id": instance_id,
            "instance_state": instance_state,
            "public_ip": public_ip,
            "load_balancer_dns": lb_dns
        }
        
        with open('aws_validation.json', 'w') as f:
            json.dump(validation_data, f, indent=4)
        return validation_data

    def wait_for_instance(self, instance_id, max_attempts=10):
        """Wait for instance to be running"""
        for _ in range(max_attempts):
            response = self.ec2.describe_instances(InstanceIds=[instance_id])
            instance = response['Reservations'][0]['Instances'][0]
            if instance['State']['Name'] == 'running':
                return instance
            time.sleep(15)
        raise Exception("Instance failed to reach running state")

def main():
    try:
        setup = CloudSetup()
        print("Hey, let's set up a AWS stuff!")
        
        # Get user inputs
        inputs = setup.get_user_input()
        
        # Generate and save Terraform template
        setup.generate_terraform_template(inputs)
        print("Terraform file is ready! Now let's run it...")
        
        # Initialize and apply Terraform
        setup.cleanup_terraform_files()
        setup.initialize_terraform()
        outputs = setup.apply_terraform()
        
        print("\nValidating AWS resources...")
        setup.initialize_aws_clients()
        validation_results = setup.validate_resources(
            outputs['instance_id'], 
            inputs['load_balancer_name']
        )
        
        # Print the resuilts
        print("\nValidation Results:")
        print(f"EC2 Instance State: {validation_results['instance_state']}")
        print(f"EC2 Public IP: {validation_results['public_ip']}")
        print(f"Load Balancer DNS: {validation_results['load_balancer_dns']}")
        print("\nValidation data saved to aws_validation.json")
        
    except Exception as e:
        print(f"\nError: {str(e)}")
        exit(1)

if __name__ == "__main__":
    main()