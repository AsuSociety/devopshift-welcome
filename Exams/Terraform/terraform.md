# Terraform Exam Q&A

## Section 1: Q&A (20 Questions)

### Terraform Fundamentals (5 Questions)

#### What is Terraform and how does it differ from other IaC tools?

**Answer:** Terraform is an open-source tool written by HashiCorp for provisioning, managing, and deploying infrastructure resources. It allows you to manage infrastructure across multiple cloud providers (AWS, Azure, GCP) with a single tool. Unlike other IaC tools, Terraform uses a declarative approach, where you define the desired end state of your infrastructure, and it automatically handles the process of reaching that state.

#### Explain Terraform's declarative nature and state management.

**Answer:** Terraform’s declarative nature means you define the desired end state of your infrastructure, and it manages the steps to reach that state. Its state management tracks the current setup in a state file, allowing Terraform to apply changes to match the desired configuration.

#### What is the purpose of the Terraform provider?

**Answer:** A Terraform provider is responsible for managing the interactions between Terraform and cloud services or APIs. It allows Terraform to create, read, update, and delete resources from different platforms like AWS, Azure, or GCP.

#### How does Terraform handle dependency resolution?

**Answer:** Terraform manages dependencies using implicit and explicit declarations. Implicit dependencies come from resource references, while explicit ones use the `depends_on` meta argument.

#### What are the key components of a Terraform configuration file?

**Answer:** The key components of a Terraform configuration file are:

- **Providers** (cloud service integrations)
- **Resources** (infrastructure elements)
- **Variables** (input values)
- **Outputs** (exported values)
- **Modules** (reusable configurations)

---

### State Management & Backend Configuration (3 Questions)

#### Explain the difference between `terraform refresh`, `terraform plan`, and `terraform apply`.

**Answer:**

- `terraform refresh` updates the state file to match the actual infrastructure.
- `terraform plan` shows the changes Terraform will make without applying them.
- `terraform apply` executes the changes to match the desired configuration.

#### What is the difference between local and remote backends?

**Answer:** A local backend stores the Terraform state file on the local machine, while a remote backend saves it on a remote service like AWS S3 or Terraform Cloud. Remote backends enable collaboration and state locking, preventing conflicts in team environments.

#### How can you prevent state corruption when multiple engineers work on the same infrastructure?

**Answer:** Use a remote backend with state locking, like AWS S3 with DynamoDB or Terraform Cloud, to prevent conflicts. This ensures only one engineer can modify the state at a time, avoiding corruption.

---

### Terraform Modules & Reusability (4 Questions)

#### What are the benefits of using Terraform modules?

**Answer:** Terraform modules make configurations reusable, organized, and easier to manage. They help reduce duplication, improve scalability, and simplify complex infrastructure deployments.

#### Explain how to pass variables to a Terraform module.

**Answer:** Variables can be passed to a Terraform module using:

- `variables.tf` files
- Command-line flags (`-var`)
- Environment variables
- `.tfvars` files

These methods allow dynamic configuration without modifying the module's code.

#### What is the difference between `count` and `for_each`?

**Answer:**

- `count` is used for creating multiple identical resources based on a number.
- `for_each` is used for creating resources from a set, map, or list, allowing unique properties for each resource.

#### How do you source a module from a Git repository?

**Answer:** You can source a Terraform module from a Git repository using the `source` argument in the module block, for example:

```hcl
source = "git::https://github.com/AsuSociety/devopshift-welcome/tree/workshop/terraform/Exams"
```

---

### Terraform with AWS (4 Questions)

#### How do you create an EC2 instance with Terraform?

**Answer:** Define an `aws_instance` resource in the configuration file, specifying parameters like `ami`, `instance_type`, and `key_name`. Then, run `terraform apply` to create the instance.

#### What are the required fields for defining a VPC in Terraform?

**Answer:** To define a VPC in Terraform, you need to specify at least the `cidr_block`. Optional fields include `enable_dns_support`, `enable_dns_hostnames`, and tags for additional customization.

#### Explain how Terraform manages IAM policies in AWS.

**Answer:** AWS IAM policies in Terraform are defined in configuration files, ensuring security and organization. Terraform manages these policies as code, making access control repeatable and scalable.

#### How do you use Terraform to provision and attach an Elastic Load Balancer?

**Answer:** Use the `aws_lb` resource to create an Elastic Load Balancer and the `aws_lb_target_group` to define where traffic is routed. Then, attach instances using `aws_lb_target_group_attachment` and configure listeners with `aws_lb_listener`.

---

### Debugging & Error Handling (4 Questions)

#### What does the `terraform validate` command do?

**Answer:** The `terraform validate` command checks the syntax and structure of configuration files, ensuring attributes and values are correctly used. It verifies the core Terraform syntax and validates provider configurations.

#### How can you debug Terraform errors effectively?

**Answer:** Enable detailed logs using `TF_LOG="DEBUG"` and check the Terraform state file for issues. Use `terraform plan` to preview changes and `terraform apply -auto-approve` carefully to test fixes.

#### What is Terraform’s `ignore_changes` lifecycle policy used for?

**Answer:** The `ignore_changes` feature prevents updates to specific attributes that may change over time but shouldn’t affect the resource after creation. This helps maintain stability in dynamic environments.

#### How do you import existing AWS infrastructure into Terraform?

**Answer:** Use the `terraform import` command with the resource type and AWS resource ID to bring existing infrastructure into Terraform. Then, define the resource in your configuration to match the imported state.
