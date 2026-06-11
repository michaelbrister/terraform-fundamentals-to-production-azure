# Lab 10 — Break/Fix: Debug Terraform Safely

## What this lab teaches you

This lab teaches how to stay calm, reason clearly, and recover safely when Terraform breaks.

Every scenario is about aligning three things:

- configuration: what your code says should exist
- state: what Terraform believes exists
- reality: what exists in `miniblue`

## Troubleshooting checklist

Use this in every scenario:

1. What does the configuration say?
2. What does Terraform state say?
3. What exists in reality?
4. Which of those three is wrong?
5. What is the smallest safe action that restores alignment?

## Scenarios

- `scenario-01-parse-error`: configuration fails before planning
- `scenario-02-identity-instability`: `count` and list order create unstable identity
- `scenario-03-drift`: reality changes outside Terraform
- `scenario-04-locks-and-partial-ops`: lock and interruption recovery mindset
- `scenario-05-import-vs-recreate`: import existing infrastructure instead of recreating it

## Rules

- Read errors and plans before acting
- Do not apply unexpected destroy or replace plans
- Do not delete state files
- Prefer the smallest safe action

## Success criteria

You are done when you can explain:

- why each scenario broke
- whether the mismatch was configuration, state, or reality
- why the fix was safe
