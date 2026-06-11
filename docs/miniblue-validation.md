# miniblue Validation Notes

**Validated on:** 2026-06-10
**miniblue version:** 0.7.0
**Terraform version:** 1.15.5
**Provider version tested:** `hashicorp/azurerm` 3.117.1

## Goal

Validate whether `miniblue` is strong enough to support:

- `00-bootstrap`
- `01-local-basics`
- `02-language-basics`
- `03-for-each-patterns`
- `04-dynamic-patterns`
- `05-backend-bootstrap`
- `06-state-migration`

with a local-first Azure course and no Azure account.

## Sources checked

- miniblue Terraform guide
- miniblue API parity matrix
- miniblue storage account and blob storage docs
- Terraform `azurerm` backend docs

## Live validation summary

### Works well enough for early labs

The official `azurerm` provider works against `miniblue` once the local TLS cert is trusted.

These resources were successfully created during live testing:

- resource group
- virtual network
- subnet
- network security group

This is enough confidence to proceed with:

- `00-bootstrap`
- `01-local-basics`
- `02-language-basics`
- `03-for-each-patterns`
- `04-dynamic-patterns`

provided we choose resource types carefully.

### Partially works, but breaks on standard Azure storage endpoints

`azurerm_storage_account` reaches `miniblue` for ARM create and key lookup, but the provider later tries to read storage service properties from the standard Azure blob hostname:

- `https://<account>.blob.core.windows.net/?comp=properties&restype=service`

In local testing, that failed with DNS resolution because `miniblue` serves blob storage on local emulator endpoints rather than on real `blob.core.windows.net` DNS names.

Impact:

- `azurerm_storage_account` is not yet reliable as a lab resource if the provider needs blob service follow-up calls
- `azurerm_storage_container` is not a safe default lab resource yet
- any lab that depends on Azure Storage data-plane behavior through the standard provider path is risky

### `azurerm` backend is not currently viable against `miniblue`

Terraform backend initialization failed with:

- `lookup <account>.blob.core.windows.net: no such host`

That means the standard `backend "azurerm"` flow is not presently a drop-in fit for `miniblue`, even though storage account ARM resources exist in the emulator.

Impact:

- `05-backend-bootstrap` cannot currently be taught as a true `azurerm` remote backend lab on `miniblue` alone
- `06-state-migration` cannot currently be taught as a real local-to-`azurerm` migration on `miniblue` alone

### Key Vault management-plane Terraform resource is not ready

`miniblue` documents secret CRUD for Key Vault data-plane behavior, but live Terraform testing of `azurerm_key_vault` failed during management-plane creation.

Impact:

- avoid `azurerm_key_vault` and `azurerm_key_vault_secret` in the first wave of labs
- if we want a local secret-management example, use `azlocal` or direct API demonstrations separately from Terraform resource creation

## Recommended course boundary

## Safe for first wave

Use `miniblue` as the default platform for:

- `00-bootstrap`
- `01-local-basics`
- `02-language-basics`
- `03-for-each-patterns`
- `04-dynamic-patterns`

Recommended Terraform resource families for this wave:

- `azurerm_resource_group`
- `azurerm_virtual_network`
- `azurerm_subnet`
- `azurerm_network_security_group`
- optionally `azurerm_public_ip`, `azurerm_dns_zone`, or `azurerm_container_registry` after a focused check

## Not safe to promise yet

Do not anchor the first course cut on these until we have a workaround or upstream support:

- `backend "azurerm"`
- `azurerm_storage_container`
- storage-account-heavy labs that require standard Azure blob endpoints
- `azurerm_key_vault`

## Recommendation for Labs 05 and 06

Choose one of these paths explicitly:

1. Keep the course fully local for Labs `00`-`04`, then use a documented fallback for Labs `05` and `06`.
2. Change Labs `05` and `06` to concept labs using emulator storage APIs and explain why the real Terraform backend path differs.
3. Use a different backend for the state labs in the Azure edition, while clearly noting that this is a teaching substitute rather than Azure parity.

My recommendation:

- build Labs `00`-`04` now on `miniblue`
- do **not** promise a fully local `azurerm` backend lab yet
- decide separately whether Labs `05` and `06` should use real Azure Storage, an alternate backend, or a concept-only walkthrough

## Validation harness

Reusable local validation configs live under:

- `validation/miniblue/provider-smoke`
- `validation/miniblue/backend-bootstrap`
- `validation/miniblue/backend-consumer`
