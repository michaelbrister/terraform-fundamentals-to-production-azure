# Example Architecture Brief

## Summary

This capstone uses `modules/app_stack` to create Azure-style network foundations for `dev`, `stage`, and `prod` in local `miniblue`.

## Module

`modules/app_stack` owns:

- resource groups
- virtual networks
- subnets
- optional network security groups
- common tags

## Environments

`live/dev`:

- smallest app stack
- used first for validation

`live/stage`:

- similar to prod shape
- includes an additional health ingress rule

`live/prod`:

- app stack
- shared stack
- strongest approval expectations

## Governance

Policy checks require:

- `Environment`
- `ManagedBy`
- `Name`
- `Stack`
- approved environment names
- no wildcard inbound NSG sources
- no wildcard inbound all-port rules

## Promotion

Promotion order:

1. dev
2. stage
3. prod

Production changes require:

- clean CI
- plan review
- policy pass
- documented rollback

## Real Azure Differences

Before using real Azure, the team would need:

- real Azure credentials
- remote state backend
- state locking
- Azure RBAC
- production approval gates
- real network/security review

