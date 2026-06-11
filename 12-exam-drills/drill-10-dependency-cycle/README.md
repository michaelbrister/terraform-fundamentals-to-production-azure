# Drill 10 — Dependency Cycle

**Timebox:** 10 minutes

## Prompt

Terraform reports a dependency cycle.

## Tasks

1. Run `terraform validate`.
2. Identify the cycle.
3. Break the cycle by making one local independent.

## Success answer

Terraform builds a graph. If two nodes depend on each other, Terraform cannot choose an evaluation order.
