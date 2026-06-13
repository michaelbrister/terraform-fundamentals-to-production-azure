# Promotion Checklist

Use this checklist when promoting a module release across environments.

## Release

- Module:
- From version:
- To version:
- Change type: patch / minor / major
- Reviewer:
- Date:

## Preflight

- [ ] Release notes exist.
- [ ] Change type is understood.
- [ ] Expected plan shape is documented.
- [ ] Rollback approach is documented.
- [ ] Any state move or import requirement is called out.

## Dev

- [ ] Update dev module source or local module change.
- [ ] Run `terraform init -backend=false`.
- [ ] Run `terraform plan`.
- [ ] Confirm no unexpected replacement.
- [ ] Apply or record why apply is deferred.
- [ ] Capture plan/apply summary.

## Stage

- [ ] Promote only after dev review.
- [ ] Run `terraform init -backend=false`.
- [ ] Run `terraform plan`.
- [ ] Compare with dev result.
- [ ] Apply or record why apply is deferred.
- [ ] Capture plan/apply summary.

## Prod

- [ ] Promote only after stage review.
- [ ] Confirm reviewer approval.
- [ ] Run `terraform init -backend=false`.
- [ ] Run `terraform plan`.
- [ ] Confirm production plan matches expected release notes.
- [ ] Apply only after approval.
- [ ] Capture final result and rollback notes.

