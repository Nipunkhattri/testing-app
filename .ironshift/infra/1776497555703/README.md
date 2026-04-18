# Azure App Service Terraform Deployment

This Terraform configuration deploys an Azure App Service for Node.js applications in the East US region.

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) >= 1.0
- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli) >= 2.0
- An active Azure subscription (ID: a66db4d1-4b92-4c2d-830b-341a8c0b5482)
- Existing resource group: `Deployment-Testing-RG`

## Resources Created

- **App Service Plan**: `testing-app-plan` (Linux, B1 SKU)
- **Linux Web App**: `testing-app` (Node.js 18 LTS runtime)

## Authentication

### Option 1: Azure CLI (Recommended for local development)

```bash
az login
az account set --subscription a66db4d1-4b92-4c2d-830b-341a8c0b5482
```

### Option 2: Service Principal

Set the following environment variables:

```bash
export ARM_CLIENT_ID="<service-principal-client-id>"
export ARM_CLIENT_SECRET="<service-principal-client-secret>"
export ARM_TENANT_ID="<azure-tenant-id>"
export ARM_SUBSCRIPTION_ID="a66db4d1-4b92-4c2d-830b-341a8c0b5482"
```

### Option 3: Managed Identity

When running on Azure resources (VM, Azure DevOps, etc.), managed identity authentication is automatic.

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

### Auto-approve (for CI/CD pipelines)

```bash
terraform apply -auto-approve
```

### Destroy Resources

```bash
terraform destroy
```

When prompted, type `yes` to confirm the destruction.

## Configuration

All configurable parameters are defined in `variables.tf` with default values. To override defaults, you can:

### Option 1: Command-line flags

```bash
terraform apply -var="app_service_name=my-custom-app"
```

### Option 2: terraform.tfvars file

Create a `terraform.tfvars` file:

```hcl
app_service_name = "my-custom-app"
location = "West US"
```

### Option 3: Environment variables

```bash
export TF_VAR_app_service_name="my-custom-app"
terraform apply
```

## Outputs

After successful deployment, you can view outputs:

```bash
terraform output
```

## App Service Configuration

- **Name**: testing-app
- **Location**: East US
- **OS**: Linux
- **Runtime**: Node.js 18 LTS
- **SKU**: B1 (Basic)
- **Always On**: Disabled (cost optimization)

## Cost Optimization

The B1 SKU is suitable for development and testing workloads. The `always_on` setting is disabled to reduce costs when the app is not in use.

## Troubleshooting

### App Service name already exists

App Service names must be globally unique. If you encounter a naming conflict, modify the `app_service_name` variable.

### Resource group not found

Ensure the resource group `Deployment-Testing-RG` exists in your subscription:

```bash
az group show --name Deployment-Testing-RG --subscription a66db4d1-4b92-4c2d-830b-341a8c0b5482
```

### Authentication errors

Verify your Azure CLI authentication:

```bash
az account show
```

## Additional Resources

- [Azure App Service Documentation](https://docs.microsoft.com/en-us/azure/app-service/)
- [Terraform Azure Provider Documentation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
- [Node.js on Azure App Service](https://docs.microsoft.com/en-us/azure/app-service/quickstart-nodejs)