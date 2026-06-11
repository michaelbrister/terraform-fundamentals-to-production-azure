# Scenario 02 — Identity Instability

## Goal

See why `count` with list order can create dangerous replacement plans.

## What is intentionally risky

The config uses:

```hcl
count = length(var.names)
```

Terraform identities become numeric addresses:

```text
azurerm_resource_group.bad[0]
azurerm_resource_group.bad[1]
azurerm_resource_group.bad[2]
```

## Actions

Create the baseline:

```bash
terraform init
terraform apply -auto-approve
```

Then reorder `var.names`:

```hcl
names = ["shared", "data", "app"]
```

Run:

```bash
terraform plan
```

Do not apply a replacement plan.

## Fix rubric

Switch to `for_each` with stable keys:

```hcl
resource "azurerm_resource_group" "good" {
  for_each = toset(var.names)

  name     = "tf-course-count-${each.key}-rg"
  location = "East US"
}
```

Then use `terraform state mv` deliberately to map old numeric addresses to new key-based addresses.

## Success checkpoint

Reordering names should not cause replacement once identity is key-based.
