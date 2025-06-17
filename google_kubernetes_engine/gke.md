# Google Kubernetes Engine (GKE)

This document provides an overview of the Terraform configuration for setting up a Google Kubernetes Engine cluster.

## Prerequisites

Before you begin, ensure you have the following installed and configured:

- **Google Cloud SDK (`gcloud`):** Make sure it's authenticated to your GCP account.
- **Terraform:** Version 1.0.0 or later is recommended.
- **GCP Project:** A Google Cloud Platform project with billing enabled.
- **Permissions:** Ensure your GCP user or service account has the necessary permissions to create and manage GKE clusters and related resources (e.g., `roles/container.admin`, `roles/compute.networkAdmin` if managing VPCs).

## Configuration

1.  **Clone the repository (if applicable):**
    If this configuration is part of a Git repository, clone it to your local machine:
    ```bash
    git clone <your-repository-url>
    cd <path-to-this-directory>
    ```

2.  **Authenticate with GCP:**
    The recommended way to authenticate Terraform with GCP is by using Application Default Credentials (ADC). Run the following command:
    ```bash
    gcloud auth application-default login
    ```
    Alternatively, you can use a service account key by setting the `GOOGLE_APPLICATION_CREDENTIALS` environment variable.

3.  **Customize Variables:**
    Create a `terraform.tfvars` file in this directory to override default variable values. Refer to `variables.tf` for available options.
    Example `terraform.tfvars`:
    ```terraform
    project_id     = "your-gcp-project-id"
    region         = "us-central1"
    cluster_name   = "my-awesome-gke-cluster"
    # Add other variable overrides as needed
    ```

## Usage

1.  **Initialize Terraform:**
    Navigate to the directory containing these Terraform files and run:
    ```bash
    terraform init
    ```

2.  **Plan the Deployment:**
    Review the infrastructure changes that Terraform will make:
    ```bash
    terraform plan
    ```

3.  **Apply the Configuration:**
    Create the GKE cluster and associated resources:
    ```bash
    terraform apply
    ```
    Type `yes` when prompted to confirm.

4.  **Destroy the Infrastructure:**
    When you no longer need the resources, you can remove them by running:
    ```bash
    terraform destroy
    ```
    Type `yes` when prompted to confirm.