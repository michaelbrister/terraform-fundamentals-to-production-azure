# Lab 11 — Terratest Integration Testing

## What this lab teaches you

This lab introduces infrastructure testing with Terratest.

You will learn:

- what Terratest verifies
- why "Terraform applied" is not the same as "the stack behaves correctly"
- how tests protect module refactors
- how to assert outputs and deployed resources
- how tests fit into CI/CD

## Mental model

Terraform already checks syntax and provider schemas.

Terratest answers a different question:

> Did the deployed infrastructure produce the behavior and outputs we expected?

For this Azure edition, the tests stay inside the validated `miniblue` resource set:

- resource groups
- virtual networks
- subnets
- network security groups

## Test structure

The tests live in:

```text
11-terratest/test
```

They use the `07-modules` lab as the target because that lab exercises the shared Azure module.

## What the main test checks

The main test:

- copies `07-modules` to a temporary directory
- runs `terraform init`
- runs `terraform apply`
- reads module outputs
- verifies at least one resource group exists via `azlocal`
- runs a post-apply plan and expects no changes
- destroys the resources at the end

## Why the tests are opt-in

These tests create resources in the local emulator, so they only run when explicitly enabled:

```bash
RUN_MINIBLUE_TESTS=1 go test -v -timeout 25m
```

If `RUN_MINIBLUE_TESTS` is not set, the tests compile and skip.

## Before running

Start `miniblue` and make sure Terraform can trust its certificate.

If needed:

```bash
export SSL_CERT_FILE="$HOME/.miniblue/cert.pem"
```

Then run:

```bash
cd 11-terratest/test
go test -v -timeout 25m
```

To run the real integration path:

```bash
RUN_MINIBLUE_TESTS=1 go test -v -timeout 25m
```

## Predict before running

Before enabling the integration test, answer:

1. Which Terraform outputs should be non-empty?
2. What would a clean post-apply plan prove?
3. What kind of module change would make this test fail?

## Common mistakes

- testing every attribute instead of important behavior
- sharing state between tests
- forgetting to destroy test resources
- treating skipped integration tests as proof that infrastructure works

## Key takeaways

- Terratest protects module behavior
- output assertions are a practical first test layer
- post-apply clean plans protect refactors
- integration tests should be explicit because they create resources
