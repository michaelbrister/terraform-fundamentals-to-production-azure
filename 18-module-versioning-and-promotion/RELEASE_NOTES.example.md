# Example Module Release Notes

## Module

`modules/app_stack`

## Version

`v0.2.0`

## Change type

Minor.

## Summary

Adds an optional owner tag to every taggable resource created by the module.

## Expected Terraform plan

Expected:

- in-place tag updates to resource groups
- in-place tag updates to virtual networks
- in-place tag updates to network security groups

Not expected:

- resource replacement
- resource address changes
- state moves
- subnet replacement

## Upgrade steps

1. Update `live/dev` first.
2. Run `terraform plan`.
3. Confirm only tag updates are shown.
4. Apply dev after review.
5. Repeat for `live/stage`.
6. Repeat for `live/prod` after approval.

## Rollback

If the change only updates tags, rollback is low risk:

1. Revert the module source ref or module change.
2. Run `terraform plan`.
3. Confirm Terraform proposes removing or restoring only the affected tags.
4. Apply after review.

## Reviewer notes

This release does not change resource names, addresses, or network ranges.

