# Lab 01 — Terraform Local State Basics (Resource Group + miniblue)

## What this lab teaches you

This lab introduces the core Terraform workflow using:

- local state
- a single Azure resource
- `miniblue` as a safe Azure emulator

By completing this lab, you will understand:

- what Terraform state is and why it matters
- how `init`, `plan`, `apply`, and `destroy` work together
- how Terraform maps configuration to real infrastructure
- how outputs expose values from Terraform

## Infrastructure created by this lab

This configuration creates one Azure resource group:

```hcl
resource "azurerm_resource_group" "demo" {
  name     = "tf-course-local-demo-rg"
  location = "East US"
}
```

Terraform will:

- create the resource group in `miniblue`
- record it in a local state file (`terraform.tfstate`)
- track it for future changes or destruction

## Understanding Terraform outputs

```hcl
output "resource_group_name" {
  value       = azurerm_resource_group.demo.name
  description = "Name of the resource group created by this Terraform configuration"
}
```

Outputs are named values Terraform exposes after apply.

Outputs are used to:

- show useful values to humans
- pass values between modules
- provide inputs to later automation

## Before you begin

Make sure:

- `miniblue` is running
- the local cert is trusted, or `SSL_CERT_FILE` is exported

If you need a reminder, go back to `00-bootstrap`.

## Terraform workflow

### 1. Format the configuration

```bash
terraform fmt
```

### 2. Initialize Terraform

```bash
terraform init
```

Expected:

```text
Terraform has been successfully initialized!
```

### 3. Validate the configuration

```bash
terraform validate
```

Expected:

```text
Success! The configuration is valid.
```

### 4. Create a plan

```bash
terraform plan -out tfplan
```

Expected:

```text
Plan: 1 to add, 0 to change, 0 to destroy.
```

### 5. Apply the plan

```bash
terraform apply -auto-approve
```

Expected:

```text
Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
```

## Viewing outputs

```bash
terraform output
```

Expected:

```text
resource_group_name = "tf-course-local-demo-rg"
```

## Verifying with azlocal

```bash
azlocal group show --name tf-course-local-demo-rg
```

This confirms the resource group exists in `miniblue`.

## Cleanup

```bash
terraform destroy -auto-approve
```

## Key takeaways

- Terraform state tracks real infrastructure
- outputs expose useful values from state
- `miniblue` allows safe local experimentation
- the Terraform workflow stays consistent across providers
