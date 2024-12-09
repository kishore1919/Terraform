# EC2 Instance Creation with User Data

This project uses Terraform to create an EC2 instance on AWS, provisioning it with a user data script.

## Overview

The Terraform configuration defines an EC2 instance with specific parameters like AMI, instance type, security group, and key pair.  Crucially, it utilizes a user data script (`u_data.sh`) to execute commands on the instance upon startup.  This allows for automated configuration and software installation.

## Prerequisites

* **AWS Account:** An active AWS account is required.
* **AWS Credentials:**  Properly configured AWS credentials are needed for Terraform to interact with your AWS account. This can be done through environment variables, the AWS CLI, or a shared credentials file.
* **Terraform Installed:**  Terraform must be installed on your local machine.

## Usage

1. **Clone the Repository:** Clone this repository to your local machine.
2. **Configure Variables:**  Edit the `variables.tf` file to customize the EC2 instance:
    * `ami`:  Specify the desired Amazon Machine Image (AMI). The default is `ami-087c17d1fe0178315`.
    * `cpu`: Set the instance type. The default is `t2.micro`.
    * `key`:  Provide the name of your existing EC2 key pair. The default is `Key02`.  Ensure this key pair exists in your AWS account and you have the private key file.
3. **Customize User Data:** Modify the `u_data.sh` script to include the commands you want to run on the instance during startup.  For instance, you might install software, configure settings, or download files.
4. **Initialize Terraform:** Run `terraform init` to initialize the project and download the necessary providers.
5. **Plan and Apply:** Execute `terraform plan` to preview the changes, and then `terraform apply` to create the EC2 instance.

## Outputs

After successful deployment, Terraform will output the public IP address of the newly created instance.  This is stored in the `public_ip` output variable.

## Security

The EC2 instance is launched within a specified security group (`sg-090fadce25b37b60d`).  Ensure this security group allows the necessary inbound and outbound traffic for your application.

## Cleanup

To destroy the resources created by this project, run `terraform destroy`.

## Example `u_data.sh`

While the provided example is not shown here, your `u_data.sh` file could contain shell commands like updating the system, installing packages, or starting services.  Remember to make this file executable (e.g., `chmod +x u_data.sh`).

## Note

This project assumes you have a basic understanding of Terraform and AWS.  Adjust the configuration and scripts as needed to fit your specific requirements.
