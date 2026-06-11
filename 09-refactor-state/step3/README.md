# Step 3 — Move State to Match the New Address

## Goal

Teach Terraform that the resource kept its real-world identity and only changed Terraform address.

## Command

From the working directory that contains the existing state, run:

```bash
terraform state mv \
  azurerm_resource_group.oldname \
  azurerm_resource_group.newname
```

Then run:

```bash
terraform plan
```

## Expected result

The plan should no longer show destroy/create caused by the rename.

If the only difference is tags, decide deliberately whether that tag update is expected. In production, the important part is that no replacement is proposed.

## What changed

`terraform state mv` changed Terraform state.

It did not change the resource group in `miniblue`.

## Checkpoint

Continue only when:

- state contains the new address
- Terraform no longer wants to destroy the old address
- you understand why infrastructure was untouched
