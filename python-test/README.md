# **Cloud Setup Automation**

This project automates the setup of AWS infrastructure using Terraform and validates the created resources using `boto3`. The setup includes:

- Creating an EC2 instance
- Setting up an Application Load Balancer (ALB)
- Configuring associated resources

## **Features**

✅ Generates a Terraform template based on user inputs  
✅ Deploys AWS resources using Terraform  
✅ Validates the deployed resources using `boto3`  
✅ Saves validation results to a JSON file

## **Prerequisites**

- **Python** 3.6+
- **Terraform** installed and added to your `PATH`
- **AWS CLI** configured with appropriate credentials
- Required Python packages: `boto3`, `jinja2`, `python-terraform` (listed in `requirements.txt`)

## **Installation**

1. **Clone the repository:**

   ```bash
   git clone https://github.com/AsuSociety/devopshift-welcome.git
   cd devopshift-welcome/python/python-test
   ```

2. **Install dependencies:**

   ```bash
   pip install -r requirements.txt
   ```

3. **Ensure Terraform is installed and available in your `PATH`.**

## **Usage**

1. **Run the script:**

   ```bash
   python cloud_setup.py
   ```

2. **Follow the prompts and provide the required inputs:**

   - Choose an AMI (`ubuntu` or `amazon`)
   - Select an instance size (`small` or `medium`)
   - Specify the AWS region (e.g., `us-east-1`)
   - Enter a name for the load balancer (max **8 characters**, as a unique timestamp is appended)

3. **The script will:**
   - Generate a Terraform configuration based on your inputs
   - Deploy AWS resources using Terraform
   - Validate the created resources with `boto3`
   - Save validation results to `aws_validation.json`

## **Example Run**

```bash
Hey, let's set up a cloud thing!
Pick an AMI (ubuntu or amazon): ubuntu
Pick size (small or medium): small
Which region? (like us-east-1): us-east-1
What's the name for your load balancer? OmerAlb

Terraform file is ready! Now let's run it...

Validating AWS resources...

Validation Results:
EC2 Instance State: running
EC2 Public IP: 3.92.102.45
Load Balancer DNS: OmerAlb-123456.elb.amazonaws.com

Validation data saved to aws_validation.json
```

---

## **Note**

Sometimes, there may be an issue with the subnet configuration. If this happens, you may need to manually modify the following line in the Terraform script:

```hcl
cidr_block = "172.31.${96 + count.index}.0/24"
```

For example, if the default value (`96`) doesn't work, try replacing it with `86`.
