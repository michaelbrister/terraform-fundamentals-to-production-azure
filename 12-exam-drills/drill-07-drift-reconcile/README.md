# Drill 07 — Drift Reconciliation

**Timebox:** 12 minutes

## Prompt

Terraform says a tag changed outside configuration.

## Tasks

1. Identify whether configuration, state, or reality changed.
2. Decide whether to accept drift or revert drift.
3. Name the command or code change for each option.

## Success answer

To revert drift, apply Terraform's desired configuration. To accept drift, update configuration to match reality and then plan again.
