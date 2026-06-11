# Lab 05 — Backend Bootstrap (Concept-First on miniblue)

## What this lab teaches you

This lab teaches one of the most important Terraform concepts:

> Terraform state is just data, and it has to live somewhere.

You will learn:

- what a Terraform backend is
- why remote state matters for teams
- why backend infrastructure is treated differently from normal application infrastructure
- how Azure remote state is normally bootstrapped
- why this Azure edition teaches the concept first before a fully hands-on `azurerm` backend lab

## Why this lab is concept-first

The AWS course can teach remote backend bootstrapping fully locally because its emulator supports the backend path cleanly.

For this Azure edition, `miniblue` is strong enough for the early ARM-style resource labs, but Terraform's real `azurerm` backend flow currently expects standard blob endpoints like:

```text
https://<account>.blob.core.windows.net/
```

That does not line up cleanly with the emulator's local endpoint shape today.

So this lab teaches the exact backend design and workflow, while being explicit that the fully local backend path is not yet part of the proven `miniblue` flow.

## Mental model

Terraform has:

- configuration
- state
- a plan

State is Terraform's memory.

A backend is the place where Terraform stores and locks that memory.

If you lose state, you do not lose infrastructure.
You lose Terraform's memory of that infrastructure.

## Local state vs remote state

### Local state

- state file lives on one machine
- good for learning and solo experimentation
- weak for team workflows

Problems:

- no shared source of truth
- easy to overwrite
- awkward for CI/CD

### Remote state in Azure

The normal Azure pattern is:

- one resource group for backend resources
- one storage account
- one blob container
- the `azurerm` backend for Terraform

Unlike the AWS course:

- there is no DynamoDB-style lock table
- Azure Storage uses blob leases for locking

## What bootstrapping means

Terraform cannot use remote state until the backend exists.

But the backend itself often gets created by Terraform.

That creates the classic bootstrap problem:

1. Terraform needs a backend
2. the backend does not exist yet
3. you create backend infrastructure first
4. only then do you switch Terraform to the remote backend

That is the same learning goal as the AWS course, even though the provider details differ.

## The normal Azure backend shape

If this were running against real Azure, the backend resources would look conceptually like:

```hcl
resource "azurerm_resource_group" "backend" {
  name     = "tf-course-backend-rg"
  location = "East US"
}

resource "azurerm_storage_account" "backend" {
  name                     = "tfcoursebackend001"
  resource_group_name      = azurerm_resource_group.backend.name
  location                 = azurerm_resource_group.backend.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.backend.name
  container_access_type = "private"
}
```

Important:

- the backend block does not create these resources
- normal resource blocks create them
- the backend block only tells Terraform where state should live

## Predict the design

Before moving on, answer:

1. Which resources store the state itself?
2. Which part provides locking behavior?
3. Why should backend resources change rarely?
4. Why should backend bootstrap happen separately from day-to-day application changes?

## Suggested walkthrough on miniblue

Even though we are not treating this as a normal hands-on `terraform apply` lab, you can still inspect the backend shape conceptually:

```bash
azlocal health
```

Review:

- `docs/miniblue-validation.md`
- `validation/miniblue/backend-bootstrap`

Those files show the exact validation harness used to test whether this could become a fully local hands-on lab later.

## What you should understand by the end

You should be able to explain:

- why remote state matters
- why Azure uses Storage + blob leases instead of S3 + DynamoDB
- why backend bootstrap is a separate concern
- why this course is deferring the full `azurerm` backend implementation for now

## Key takeaways

- backend infrastructure is infrastructure for Terraform itself
- the backend block configures Terraform, but does not create cloud resources
- Azure remote state normally lives in Storage and uses blob leases for locking
- the concept is part of the course now, even though the fully local implementation is deferred
