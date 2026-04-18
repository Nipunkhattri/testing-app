# Azure App Service Deployment with Terraform

This Terraform configuration creates an Azure App Service with a new App Service Plan for hosting a Node.js application in the Central India region.

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) >= 1.0
- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli) >= 2.0
- An active Azure subscription (ID: a66db4d1-4b92-4c2d-830b-341a8c0b5482)
- Existing resource group: `Deployment-Testing-RG` in Central India region

## Resources Created

This configuration will create the following resources:

1. **App Service Plan** (`deployment-testing-plan`)
   - Location: Central India (centralindia)
   - OS Type: Linux
   - SKU: B1 (Basic tier)

2. **Linux Web App** (`deployment-testing-app`)
   - Location: Central India (centralindia)
   - Runtime: Node.js 18 LTS
   - Always On: Disabled (for cost optimization)

## Authentication

### Option 1: Azure CLI (Recommended)

```bash
# Login to Azure
az login

# Set the subscription
az account set --subscription a66db4d1-4b92-4c2d-830b-341a8c0b5482

# Verify the subscription
az account show
```

### Option 2: Service Principal

Set the following environment variables:

```bash
export ARM_CLIENT_ID="<service-principal-client-id>"
export ARM_CLIENT_SECRET="<service-principal-client-secret>"
export ARM_SUBSCRIPTION_ID="a66db4d1-4b92-4c2d-830b-341a8c0b5482"
export ARM_TENANT_ID="<tenant-id>"
```

### Option 3: Managed Identity

If running from an Azure VM or Azure DevOps pipeline with managed identity enabled, authentication will happen automatically.

## Usage

### Initialize Terraform

```bash
terraform init
```

This command downloads the required Azure provider plugins.

### Validate Configuration

```bash
terraform validate
```

Ensures the configuration syntax is correct.

### Plan Deployment

```bash
terraform plan
```

Review the resources that will be created. Expected output should show:
- 1 resource group to be read (data source)
- 1 App Service Plan to be created
- 1 Linux Web App to be created

### Apply Configuration

```bash
terraform apply
```

Type `yes` when prompted to confirm the deployment.

### Verify Deployment

After successful deployment, verify the resources:

```bash
# Check App Service Plan
az appservice plan show --name deployment-testing-plan --resource-group Deployment-Testing-RG

# Check App Service
az webapp show --name deployment-testing-app --resource-group Deployment-Testing-RG
```

### View Outputs

```bash
terraform output
```

### Destroy Resources

To remove all created resources:

```bash
terraform destroy
```

Type `yes` when prompted to confirm the destruction.

## Configuration Details

### Variables

All variables have default values set in `variables.tf`. You can override them by:

1. Creating a `terraform.tfvars` file:
```hcl
location = "centralindia"
app_service_name = "deployment-testing-app"
```

2. Using command-line flags:
```bash
terraform apply -var="location=centralindia"
```

3. Using environment variables:
```bash
export TF_VAR_location="centralindia"
```

### Key Configuration Points

- **Region**: All resources are created in Central India (centralindia) to match the resource group location
- **App Service Plan**: New plan named `deployment-testing-plan` with B1 SKU
- **Runtime**: Node.js 18 LTS
- **Always On**: Disabled to reduce costs on Basic tier
- **OS Type**: Linux

## Troubleshooting

### Authentication Issues

If you encounter authentication errors:
```bash
az account clear
az login
az account set --subscription a66db4d1-4b92-4c2d-830b-341a8c0b5482
```

### Resource Group Not Found

Ensure the resource group exists:
```bash
az group show --name Deployment-Testing-RG
```

### App Service Name Conflict

App Service names must be globally unique. If `deployment-testing-app` is taken, modify the `app_service_name` variable.

### Region Mismatch

Ensure all resources are created in `centralindia` to match the resource group location.

## Cost Considerations

- **B1 SKU**: Basic tier with 1 core, 1.75 GB RAM
- **Always On**: Disabled to reduce costs (suitable for development/testing)
- Estimated monthly cost: ~$13-15 USD (subject to Azure pricing changes)

## Security Best Practices

1. Use Azure Key Vault for storing sensitive configuration
2. Enable HTTPS only in production
3. Configure custom domains with SSL certificates
4. Implement network restrictions using IP whitelisting or VNet integration
5. Enable diagnostic logging and monitoring

## Next Steps

After deployment:

1. Configure deployment slots for staging environments
2. Set up continuous deployment from GitHub/Azure DevOps
3. Configure application settings and connection strings
4. Enable Application Insights for monitoring
5. Set up custom domains and SSL certificates

## Support

For issues related to:
- Terraform: [Terraform Documentation](https://www.terraform.io/docs)
- Azure Provider: [Azure Provider Documentation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
- Azure App Service: [Azure App Service Documentation](https://docs.microsoft.com/en-us/azure/app-service/)