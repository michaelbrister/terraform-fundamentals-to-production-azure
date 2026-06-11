# Lab 06 — State Migration (Concept-First on miniblue)

## What this lab teaches you

This lab teaches one of Terraform's most sensitive operations:

> changing where Terraform stores its state without changing the infrastructure itself

You will learn:

- what state migration actually means
- what `terraform init -migrate-state` does
- why migration is about Terraform's memory, not the resources
- how the Azure remote-state story maps to the same mental model as the AWS course

## Why this lab is concept-first

In the AWS course, learners can run a full local migration from local state to remote state because the backend path is fully emulated.

In this Azure edition, the validated `miniblue` path stops short of a fully working `backend "azurerm"` flow. Terraform eventually resolves standard Azure blob hosts, which breaks the drop-in local backend experience.

So this lab focuses on state migration reasoning and the exact workflow you would use in real Azure, while being transparent about why this is not yet a normal local apply-and-migrate lab.

## The single most important idea

Terraform does not move infrastructure during state migration.

It migrates:

- the state file
- Terraform's memory of what exists

It does not:

- recreate resources
- rename infrastructure
- move resources between regions

If you understand this, migration becomes much less scary.

## Typical Azure migration path

The normal Azure flow would look like this:

1. start with local state
2. create backend resources separately
3. add a backend block
4. run:

```bash
terraform init -migrate-state
```

5. confirm the migration
6. run `terraform plan` and expect no infrastructure changes

## Example backend block

In real Azure, the backend configuration would look conceptually like:

```hcl
terraform {
  backend "azurerm" {
    resource_group_name  = "tf-course-backend-rg"
    storage_account_name = "tfcoursebackend001"
    container_name       = "tfstate"
    key                  = "dev/terraform.tfstate"
  }
}
```

This does not create backend resources.

It tells Terraform where state should live after the backend already exists.

## Predict the migration

Before you imagine running the migration, answer:

1. Where is state stored before the migration?
2. Where is state stored after the migration?
3. Should any infrastructure be recreated?
4. What would a healthy post-migration plan show?

## Healthy migration checklist

The safety pattern is the same as in the AWS course:

1. start from a clean plan
2. change only the backend configuration
3. run `terraform init -migrate-state`
4. verify the migration succeeded
5. run `terraform plan`
6. expect:

```text
No changes. Infrastructure is up-to-date.
```

That clean post-migration plan is the main safety signal.

## What can go wrong

### Pending infrastructure changes

Do not mix backend migration with normal infrastructure changes.

### Wrong backend settings

If the backend points at the wrong storage account, container, or key, Terraform may appear to "lose" resources because it is reading the wrong state location.

### Panic about state

Losing or mispointing state is recoverable.

The correct response is:

- pause
- inspect
- verify

Not:

- apply random changes
- delete state files
- assume infrastructure was destroyed

## How this maps to the current Azure course

This Azure edition currently teaches:

- the same migration mental model as the AWS course
- the same operator safety rules
- the same clean-plan-before and clean-plan-after discipline

What is different is only the current emulator limitation around the live local `azurerm` backend path.

## Suggested supporting material

Review:

- `docs/miniblue-validation.md`
- `05-backend-bootstrap/README.md`
- `validation/miniblue/backend-consumer`

## Key takeaways

- state migration moves Terraform's memory, not infrastructure
- backend configuration changes should be isolated from normal changes
- a clean plan before and after migration is the main safety check
- this concept is essential, even before the fully local Azure backend path is resolved
