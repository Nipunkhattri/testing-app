# Azure App Service Deployment with Terraform

This Terraform configuration deploys an Azure App Service for a Node.js application using an existing App Service Plan.

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) >= 1.0
- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli) >= 2.0
- An active Azure subscription (ID: `a66db4d1-4b92-4c2d-830b-341a8c0b5482`)
- Existing resource group: `Deployment-Testing-RG`
- Existing App Service Plan: `testing-app-plan` in the same resource group

## Authentication

### Option 1: Azure CLI (Recommended)

1. Login to Azure:
```bash
az login
```

2. Set the subscription:
```bash
az account set --subscription a66db4d1-4b92-4c2d-830b-341a8c0b5482
```

3. Verify the subscription:
```bash
az account show
```

### Option 2: Service Principal

Set the following environment variables:

```bash
export ARM_CLIENT_ID="<service-principal-app-id>"
export ARM_CLIENT_SECRET="<service-principal-password>"
export ARM_SUBSCRIPTION_ID="a66db4d1-4b92-4c2d-830b-341a8c0b5482"
export ARM_TENANT_ID="<tenant-id>"
```

### Option 3: Managed Identity

If running from an Azure VM or Azure DevOps pipeline with managed identity enabled, authentication will happen automatically.

## Configuration

The configuration creates the following resources:

- **App Service**: `deployment-testing-app`
  - Location: Central India
  - Resource Group: Deployment-Testing-RG
  - Runtime: Node.js 18 LTS on Linux
  - Always On: Disabled (cost optimization)
  - Uses existing App Service Plan: `testing-app-plan`

## Usage

### Initialize Terraform

```bash
terraform init
```

### Validate Configuration

```bash
terraform validate
```

### Plan Deployment

```bash
terraform plan
```

### Apply Configuration

```bash
terraform apply
```

When prompted, type `yes` to confirm the deployment.

### Auto-approve (for CI/CD)

```bash
terraform apply -auto-approve
```

### Destroy Resources

To remove all resources created by this configuration:

```bash
terraform destroy
```

When prompted, type `yes` to confirm the destruction.

## Outputs

After successful deployment, you can view the App Service details:

```bash
terraform output
```

## Customization

To customize the deployment, modify the default values in `variables.tf` or create a `terraform.tfvars` file:

```hcl
app_service_name = "my-custom-app-name"
runtime_version  = "18-lts"
always_on        = false
```

Then apply with:

```bash
terraform apply -var-file="terraform.tfvars"
```

## Verification

After deployment, verify the App Service:

```bash
az webapp show --name deployment-testing-app --resource-group Deployment-Testing-RG
```

Check the App Service URL:

```bash
az webapp show --name deployment-testing-app --resource-group Deployment-Testing-RG --query defaultHostName -o tsv
```

## Troubleshooting

### Authentication Issues

If you encounter authentication errors:
- Ensure you're logged in: `az login`
- Verify subscription access: `az account show`
- Check RBAC permissions on the resource group

### Resource Already Exists

If the App Service name is already taken:
- App Service names must be globally unique
- Modify the `app_service_name` variable to use a different name

### App Service Plan Not Found

If the existing App Service Plan is not found:
- Verify the plan exists: `az appservice plan show --name testing-app-plan --resource-group Deployment-Testing-RG`
- Ensure the plan name and resource group are correct in the configuration

## Important Notes

- This configuration uses an **existing** App Service Plan (`testing-app-plan`)
- The App Service Plan must exist before running this Terraform configuration
- Always On is disabled to optimize costs for non-production environments
- The App Service runs on Linux with Node.js 18 LTS runtime

## Support

For issues or questions:
- Review Terraform logs: `TF_LOG=DEBUG terraform apply`
- Check Azure Activity Log in the Azure Portal
- Verify resource quotas and limits in your subscription