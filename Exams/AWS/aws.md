# Section 1: Multiple Choice Questions (MCQs)

## 1. AWS Core Services

**Which AWS service is used to store objects such as images, videos, and backups?**  
C) S3

**What is the purpose of an AWS Availability Zone?**  
A) It ensures high availability by distributing resources across multiple locations.

**What is the default storage class for an S3 bucket when you create it?**  
C) S3 Standard

## 2. IAM & Security

**What is the purpose of an IAM role?**  
A) It is used to assign permissions to AWS services and users.

**In AWS IAM, what is the best practice for securing your root account?**  
B) Use it only for creating IAM users and enable Multi-Factor Authentication (MFA).

## 3. Networking and Connectivity

**What is the purpose of an Internet Gateway in AWS?**  
B) To provide internet access to resources in a private subnet.

**What is the main difference between a Security Group and a Network ACL?**  
A) Security Groups operate at the instance level, while NACLs operate at the subnet level.

## 4. Storage & Databases

**Which AWS service provides a managed relational database service?**  
B) RDS

**What happens if you delete an S3 bucket with objects inside it?**  
B) The bucket is deleted, and all objects inside it are permanently removed.

## 5. AWS Billing & Pricing

**Which AWS pricing model allows you to pay only for the computing resources you use?**  
C) Pay-as-you-go

**What tool in AWS helps users monitor their spending and set budget alerts?**  
A) AWS Cost Explorer

# Section 2: Research-based AWS Questions (Using Google Only)

**What are AWS Landing Zones, and how do they help with multi-account governance?**  
A landing zone is a pre-configured, multi-account AWS setup that serves as a starting point for deploying workloads and apps.  
It provides a foundation for managing accounts, security, network design, and logging.

**Explain how AWS WAF protects web applications from common attacks.**  
AWS WAF protects web apps by monitoring HTTP/S requests to block attacks like SQL injection and XSS.  
It uses features like Access Control Lists, Rules, and Rule Groups for comprehensive security.

**What is AWS Snowball, and when should it be used?**  
AWS Snowball is a service offering secure, rugged devices that bring AWS computing and storage to edge environments.  
These devices help transfer data into and out of AWS, commonly known as Snowball or Snowball Edge.

**What are the key differences between AWS Backup and manual snapshot backups?**  
An AWS snapshot is a point-in-time copy of an EBS volume with limited storage and recovery options.  
An EC2 backup is a more flexible, comprehensive backup of cloud workloads, ensuring reliable protection and fast recovery.

**How does AWS Shield help mitigate DDoS attacks?**  
AWS Shield automatically mitigates DDoS attacks by creating and deploying custom AWS WAF rules.  
It also provides AWS WAF access at no extra cost for application layer DDoS protection with CloudFront or Application Load Balancer.

**Explain the differences between AWS Transit Gateway and VPC Peering.**  
AWS Transit Gateway simplifies large-scale network management by connecting multiple VPCs and on-premises networks, reducing overhead.  
In contrast, VPC Peering directly links two VPCs but becomes complex and harder to scale in larger environments.

**What is AWS Step Functions, and how does it help with workflow automation?**  
AWS Step Functions is a visual workflow service that helps developers automate processes, manage microservices,  
and build distributed applications, including data and machine learning (ML) pipelines using AWS services.

**How does AWS Control Tower assist organizations in managing multiple AWS accounts?**  
AWS Control Tower simplifies setting up a multi-account environment and landing zone for easier migration.  
It leverages services like Organizations, Service Catalog, and Config to govern the environment.

**What is the significance of AWS Outposts in hybrid cloud solutions?**  
AWS Outposts bring AWS infrastructure and services to on-premises environments, offering a consistent hybrid cloud experience.  
It allows organizations to run AWS services locally and integrate seamlessly with the AWS cloud for unified management.

**Explain the key use cases for AWS Elastic File System (EFS) compared to S3 and EBS.**  
AWS Elastic File System (EFS) is designed for shared file systems where multiple EC2 instances access the same data.  
Unlike S3 and EBS, EFS offers scalable file storage with NFS support for concurrent reads and writes across multiple instances.
