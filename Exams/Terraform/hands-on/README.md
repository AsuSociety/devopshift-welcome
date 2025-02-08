# Terraform Hands-on Exam

This directory (Exams/Terraform/Hands-on/) contains Terraform configurations and modules for the hands-on part in the exam. It contains a solution to each of the task in this part of the exam, I did not split it up for each task because everything depends on each other and I wanted to keep it complete and more readable.

## Directory Structure

- `alb.tf`: Defines an Application Load Balancer (ALB) using a module.
- `ec2.tf`: Defines an EC2 instance using a module.
- `mock/`: Contains mock files for testing purposes.
  - `mock_variables.tf`: Mock variables used for testing.
  - `terraform.tfstate`: Mock Terraform state file.
- `modules/`: Contains reusable Terraform modules.
  - `alb/`: Module for creating an Application Load Balancer (ALB).
    - `main.tf`: Defines the ALB resources.
    - `output.tf`: Defines output variables for the ALB module, such as the ALB's DNS name and security group ID.
    - `variables.tf`: Defines input variables for the ALB module, such as `vm_name`, `vpc_id`, and more.
  - `ec2/`: Module for creating an EC2 instance.
    - `main.tf`: Defines the EC2 instance resource.
    - `output.tf`: Defines output variables for the EC2 module.
    - `variables.tf`: Defines input variables for the EC2 module, such as `ami`, `instance_type`, and more.
  - `vpc/`: Module for creating a Virtual Private Cloud (VPC).
    - `main.tf`: Defines the VPC resources, including subnets, internet gateway, and route tables.
    - `output.tf`: Defines output variables for the VPC module, such as `vpc_id`, `public_subnet_ids`, `private_subnet_ids`, and more.
    - `variables.tf`: Defines input variables for the VPC module, such as `vpc_cidr`, `public_subnet`, and more.
- `output.tf`: Defines output variables for the entire infrastructure, such as the VPC ID, subnet IDs, and ALB DNS name.
- `global.tf`: Defines input variables for the main configuration, such as `ami`, `instance_type`, `vm_name`, and more.
- `alb.tf`: Configures an Application Load Balancer (ALB) using the `alb` module.
- `ec2.tf`: Deploys an EC2 instance using the `ec2` module.
- `vpc.tf`: Sets up a Virtual Private Cloud (VPC) using the `vpc` module.

## Modules

As requested in the third part of the test, I used modules, and this is also to make it more readable, more understandable, and to save code duplication. The modules are located in the modules/ directory. Here is a brief overview of each module:

- **vpc Module**: Creates a VPC with public and private subnets, an internet gateway, and route tables. It takes variables such as `vpc_cidr`, `public_subnet`, `private_subnet`, and more. Outputs include IDs and CIDR blocks for VPC components.
- **ec2 Module**: Deploys an EC2 instance within the VPC. It uses variables like `ami`, `instance_type`, `vm_name`, `public_ip`, and `openports` to configure the instance. It creates a security group and allows configuration of open ports.
- **alb Module**: Provisions an Application Load Balancer (ALB) to distribute traffic to EC2 instances. It requires variables such as `vm_name`, `vpc_id`, `subnet_ids`, and more. It sets up the ALB, target group, and listener.

## Key Files

- **alb.tf, ec2.tf, vpc.tf**: These are the primary configuration files. They call the modules to create the VPC, EC2 instance, and ALB. They also define the provider (AWS) and any necessary configurations.
- **global.tf**: This file defines all the input variables used in the configuration. These variables allow you to customize the deployment without modifying the code.
- **output.tf**: This file defines the output values that Terraform will display after the deployment. These outputs can include the VPC ID, subnet IDs, ALB DNS name, and other useful information.

## Workflow

1.  **Initialization**: Run `terraform init` to initialize the working directory and download the necessary providers and modules.
2.  **Planning**: Run `terraform plan` to see the changes that Terraform will make to your infrastructure.
3.  **Deployment**: Run `terraform apply` to apply the changes and create the infrastructure.
4.  **Outputs**: After the deployment, Terraform will display the output values defined in `output.tf`.
5.  When you are done, you can run `terraform destroy` to remove all the resources created by Terraform.
    **Note**: Make sure to set up your AWS credentials and region before running Terraform commands.

## Customization

When you plan and apply, it will ask for the `vm_instance`. You can provide, for example, `"t2.micro"`. You can also customize the deployment by modifying the variables in `variables.tf` or by passing them through the command line using the `-var` flag. For example:

```bash
terraform apply -var="vm_name=[YOUR_NAME]"
```

here is some of the output that i get and you shuld get after running the terraform apply command:
