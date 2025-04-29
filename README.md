# 🚀 GCP Serverless Deployment with Terraform & GitHub Actions

This project demonstrates how to deploy a **Google Cloud Function (2nd Gen)** using **Terraform** and **GitHub Actions**, following modern Infrastructure as Code (IaC) and CI/CD practices.

> 📝 This repository contains the **Cloud Function code** and the **Terraform infrastructure**.  
> The CI/CD process uses a **shared workflow** from [alberto7088/workflows](https://github.com/alberto7088/workflows).

---

## 📁 Project Structure

```plaintext
├── infra
│   └── terraform
│       ├── config
│       │   └── dev.tfvars
│       ├── main.tf
│       ├── modules
│       │   ├── bucket
│       │   └── cloud-function
│       ├── outputs.tf
│       └── variables.tf
└── services
    └── src
        └── function-word-counter
            ├── main.py
            └── requirements.txt
```
## ⚙️ Features

- **Modular Terraform infrastructure** for Google Cloud Platform (GCP).
- **Cloud Function 2nd Gen** written in **Python 3.11**.
- **Terraform Plan** automatically triggered on pull requests.
- **Terraform Apply** automatically triggered on push to the `main` branch.
- **Secure GitHub Secrets management** for all credentials and sensitive variables.

---

## 🔐 Secrets Management

All sensitive variables such as GCP credentials, project ID, bucket name, and service account email are securely managed using **GitHub Secrets**.

This approach ensures:
- No hardcoded secrets in the codebase.
- Encrypted, auditable, and rotatable credentials.
- Safer collaboration across teams and contributors.

---

## 🧪 GitHub Actions Workflow

The repository uses `dev.yaml` to trigger a shared Terraform workflow for automated deployments.

Example configuration:

```yaml
on:
  pull_request:
    branches: [ main ]
  push:
    branches: [ main ]

jobs:
  terraform_plan:
    uses: alberto7088/workflows/.github/workflows/terraform-deployment.yaml@main
    with:
      environment: dev
      terraform-action: plan
      terraform-directory: infra/terraform
    secrets:
      GCP_CREDENTIALS: ${{ secrets.GCP_CREDENTIALS_DEV }}
      # Add any additional required secrets here
```
## ✅ How to Use

1. **Create your project in GCP.**

2. **Set up your deployment workflows:**
   - Use the existing `dev.yaml` file to deploy to the development environment.
   - (Optional) Create a `prod.yaml` file for production deployments, following the same structure.

3. **Configure required secrets in your GitHub repository** for each environment.  
   For example, for the `dev` environment, set the following secrets:

```
GCP_CREDENTIALS_DEV
TF_STATE_BUCKET_DEV
GCP_PROJECT_DEV
STATE_SA_EMAIL_DEV
INVOKER_MEMBER_DEV
```