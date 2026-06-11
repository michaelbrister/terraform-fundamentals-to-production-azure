# live/ environments

These directories show how the shared Azure module can be called for multiple environments.

Current environments:

- `dev`
- `stage`
- `prod`

## Current backend note

These examples intentionally use local state for now.

The Azure edition is `miniblue`-first, and the fully local `backend "azurerm"` flow is not yet part of the proven emulator path. Labs `05` and `06` explain the real Azure backend model conceptually.

## Apply an environment

Start `miniblue`, then run:

```bash
cd live/dev
terraform init
terraform validate
terraform plan
```

Use `apply` only when you are ready to create the local emulator resources:

```bash
terraform apply -auto-approve
```

## Destroy

```bash
terraform destroy -auto-approve
```

## What to compare

Compare `dev`, `stage`, and `prod` to see how the same module is reused with different:

- `env` values
- network address ranges
- subnet sets
- NSG rules
