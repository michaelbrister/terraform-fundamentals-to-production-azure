# Lab 00 — miniblue Bootstrap

## What this lab does

This lab gets your local Azure emulator ready so the rest of the Azure course can run without a real Azure account.

By the end of this lab, you will have:

- `miniblue` installed
- the local emulator running
- the local TLS certificate trusted
- Terraform ready to talk to the emulator
- `azlocal` available for quick verification

## Why this matters

The AWS edition uses a local emulator so learners can focus on Terraform instead of cloud account setup.

This Azure edition follows the same idea:

- safe local experimentation
- repeatable labs
- no Azure subscription required for the first wave of labs

## Tooling used in this course

- Terraform `1.5+`
- `miniblue`
- optional `azlocal`
- optional Docker

## Install options

### Option A — Homebrew

```bash
brew tap moabukar/tap
brew install miniblue
```

This installs:

- `miniblue` server
- `azlocal` CLI

### Option B — Docker

```bash
docker run -p 4566:4566 -p 4567:4567 moabukar/miniblue:latest
```

Use this if you prefer a containerized emulator.

## Start miniblue

If you installed via Homebrew:

```bash
miniblue
```

If you are using Docker:

```bash
docker run -p 4566:4566 -p 4567:4567 moabukar/miniblue:latest
```

Expected startup messages include:

- HTTP on `http://localhost:4566`
- HTTPS on `https://localhost:4567`

## Trust the TLS certificate

Terraform uses the HTTPS metadata endpoint, so certificate trust matters.

Quick shell-only option:

```bash
export SSL_CERT_FILE="$HOME/.miniblue/cert.pem"
```

On macOS, you can also trust it in your user keychain:

```bash
security add-trusted-cert -d -r trustRoot \
  -k ~/Library/Keychains/login.keychain-db \
  ~/.miniblue/cert.pem
```

If you run `miniblue` with a custom `HOME`, use the cert path from that location instead.

## Verify the emulator

### Health check

```bash
curl -s http://localhost:4566/health
```

Expected:

- `status` is `running`
- services include resource groups, network, storage accounts, and blob

### azlocal check

```bash
azlocal health
```

### Simple resource group check

```bash
azlocal group create --name bootstrap-rg --location eastus
azlocal group show --name bootstrap-rg
azlocal group delete --name bootstrap-rg
```

## Terraform provider pattern used in the next labs

The Azure labs use the official `hashicorp/azurerm` provider configured for `miniblue`:

```hcl
provider "azurerm" {
  features {}

  metadata_host              = "localhost:4567"
  skip_provider_registration = true
  subscription_id            = "00000000-0000-0000-0000-000000000000"
  tenant_id                  = "00000000-0000-0000-0000-000000000001"
  client_id                  = "miniblue"
  client_secret              = "miniblue"
}
```

## What is validated for the first wave of labs

These resource families were validated for local use:

- resource groups
- virtual networks
- subnets
- network security groups

For now, do not assume that Azure Storage remote backend labs are fully local-ready. That is a later design decision in this course.

## Common problems

### `tls: failed to verify certificate`

Trust the `miniblue` cert or export `SSL_CERT_FILE`.

### `connection refused` on `localhost:4567`

`miniblue` is not running, or the HTTPS port is not exposed.

### `provider registration` errors

Make sure `skip_provider_registration = true` is present.

## Completion standard

You are ready for Lab `01` when:

- `miniblue` starts cleanly
- `curl http://localhost:4566/health` works
- Terraform can initialize an `azurerm` configuration without TLS errors
