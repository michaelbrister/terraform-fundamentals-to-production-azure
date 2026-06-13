# Lab 18 - Module Versioning And Environment Promotion

## What this lab teaches you

This lab teaches how teams promote Terraform module changes safely from dev to stage to prod.

You will learn:

- why reusable modules need release discipline
- why live environments should not consume surprise module changes
- how to classify module changes as patch, minor, or major
- how to promote changes through environments
- how to write upgrade notes that reviewers can actually use

## Scenario

Your team uses `modules/app_stack` from three environment roots:

- `live/dev`
- `live/stage`
- `live/prod`

The module is currently referenced by local path because this course is local-first:

```hcl
module "stack" {
  source = "../../modules/app_stack"
}
```

In a production repository, teams often publish modules through a registry or pin a Git source ref. This lab teaches the same workflow without requiring a private registry.

## Why this matters

An unversioned shared module can surprise every environment at once.

That is fine for a tiny tutorial. It is risky for teams.

Safe teams separate:

- module development
- module release
- dev adoption
- stage adoption
- prod adoption

The goal is not to slow everyone down. The goal is to make infrastructure changes boring, reviewable, and reversible.

## Versioning model

Use semantic versioning language:

| Version type | Meaning | Example Terraform impact |
| --- | --- | --- |
| Patch | Bug fix, no interface change | Fix output description or safe default |
| Minor | Backward-compatible feature | Add optional variable or optional tag |
| Major | Breaking change | Rename variable, change resource address, require new input |

For Terraform modules, breaking changes are not just API changes. A change is risky if it can:

- replace resources
- rename resource addresses
- remove outputs callers use
- change defaults in production-impacting ways
- require state moves or imports

## Exercise 1 - Inventory The Current Module Contract

Open:

```bash
modules/app_stack/variables.tf
modules/app_stack/outputs.tf
live/dev/main.tf
live/stage/main.tf
live/prod/main.tf
```

Answer:

- Which variables are required by the module?
- Which variables have defaults?
- Which outputs do live environments consume?
- Which tags are applied by the module automatically?
- Which settings vary by environment?

## Exercise 2 - Plan A Release

Pretend the current module is release `v0.1.0`.

Create a release note using `18-module-versioning-and-promotion/RELEASE_NOTES.example.md` as the model.

Your release note should include:

- version number
- change type: patch, minor, or major
- expected Terraform plan shape
- upgrade steps
- rollback notes

## Exercise 3 - Design A Safe Change

Pick one hypothetical module change:

- add an optional `owner` tag
- add an optional `cost_center` tag
- add a new output for resource group IDs
- add validation to a variable

Classify the change:

- Is it patch, minor, or major?
- Does it affect resource addresses?
- Should it replace resources?
- Does it need a state move?
- Which environment should adopt it first?

## Exercise 4 - Promote Dev To Stage To Prod

Use `PROMOTION_CHECKLIST.md` to write the promotion plan.

Promotion order:

1. update `live/dev`
2. run `terraform plan`
3. review expected changes
4. apply or record why apply is deferred
5. repeat for `live/stage`
6. repeat for `live/prod` only after review

In this tutorial repo, `live/*` uses a local module source. For a real Git-pinned module, the source might look like:

```hcl
module "stack" {
  source = "git::https://github.com/example/terraform-azure-app-stack.git?ref=v0.2.0"
}
```

Do not switch this repo to that source unless you have actually published the module somewhere.

## Exercise 5 - Predict The Plan

Before running a plan, answer:

- Which resources should change?
- Which resources should not change?
- Should any address change?
- Would production reviewers understand this plan from the release note?

Then run, from each environment as appropriate:

```bash
terraform init -backend=false
terraform plan
```

## Deliverable

Write a promotion packet with:

- module contract summary
- release notes
- dev plan summary
- stage plan summary
- prod approval notes
- rollback plan

## Success criteria

You are done when you can explain:

- why module consumers should pin versions in production workflows
- why dev should adopt before stage and prod
- how to tell whether a module change is breaking
- how release notes reduce review risk
- why local-path modules are convenient for learning but insufficient as a production promotion model

