# Drill 06 — Import and Converge

**Timebox:** 15 minutes

## Prompt

A resource group exists in `miniblue`, but Terraform does not track it.

Resource name:

```text
tf-course-drill-import-rg
```

## Tasks

1. Create the resource out of band with `azlocal`.
2. Write the matching Terraform resource block.
3. Import the resource.
4. Run `terraform plan`.
5. Explain any convergence changes.

## Import command

```bash
terraform import \
  azurerm_resource_group.import_me \
  /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/tf-course-drill-import-rg
```

## Success answer

Import changes state only. A clean plan after convergence proves config, state, and reality agree.
