# Cloud Setup Automation

This project automates the setup of AWS infrastructure using Terraform and validates the resources using boto3.
The setup includes creating an EC2 instance, an Application Load Balancer (ALB), and associated resources.

## Features

- Generates a Terraform template based on user inputs
- Applies the Terraform configuration to create AWS resources
- Validates the created resources using boto3
- Saves validation results to a JSON file

## Prerequisites

- Python 3.6+
- Terraform
- AWS CLI configured with appropriate credentials
- Required Python packages: `boto3`, `jinja2`, `python-terraform`, there is requirements file

## Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/yourusername/cloud-setup-automation.git
   cd cloud-setup-automation
   ```

2. Install the required Python packages:

   ```bash
   pip install -r requirements.txt
   ```

3. Ensure Terraform is installed and available in your PATH.

## Usage

1. Run the script:

   ```bash
   python cloud_setup.py
   ```

2. Follow the prompts to provide the necessary inputs:

   - Pick an AMI (ubuntu or amazon)
   - Pick an instance size (small or medium)
   - Specify the region (e.g., us-east-1)
   - Provide a name for your load balancer. The name should be a maximum of 8 characters because a unique timestamp is added to the name.

3. The script will:
   - Generate a Terraform template based on your inputs
   - Apply the Terraform configuration to create the AWS resources
   - Validate the created resources using boto3
   - Save the validation results to `aws_validation.json`

## Example

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
