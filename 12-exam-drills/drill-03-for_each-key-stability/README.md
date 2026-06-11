# Drill 03 — Stable for_each Keys

**Timebox:** 10 minutes

## Prompt

The config shows two flattened subnet key strategies.

## Tasks

1. Run `terraform console`.
2. Evaluate `local.unstable_subnets` and `local.stable_subnets`.
3. Insert `"metrics"` between `"web"` and `"api"`.
4. Predict which keys change.

## Success answer

Index-based keys change when list positions change. Composite keys like `app|api` stay stable when new items are inserted.
