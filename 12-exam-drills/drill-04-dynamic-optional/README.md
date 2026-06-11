# Drill 04 — Dynamic Optional Blocks

**Timebox:** 10 minutes

## Prompt

Only enabled rules should render as nested `security_rule` blocks.

## Tasks

1. Predict how many `security_rule` blocks Terraform will render.
2. Enable the `debug` rule and predict the plan.
3. Explain why `dynamic` is appropriate here.

## Success answer

Use `dynamic` for repeated nested blocks. Use resource-level `for_each` for repeated resources.
