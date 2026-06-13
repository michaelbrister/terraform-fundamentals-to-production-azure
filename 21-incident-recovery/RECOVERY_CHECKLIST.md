# Recovery Checklist

Use this checklist during a Terraform incident.

## Stabilize

- [ ] Pause new Terraform changes.
- [ ] Identify incident owner.
- [ ] Confirm environment and root module.
- [ ] Save relevant logs and plan output.
- [ ] Confirm whether any run is currently active.

## Inspect

- [ ] Review recent Git changes.
- [ ] Run or inspect `terraform plan`.
- [ ] Run `terraform state list`.
- [ ] Inspect relevant state entries with `terraform state show`.
- [ ] Inspect real resources with provider CLI or console.
- [ ] Check CI and policy output.

## Decide

- [ ] Is configuration wrong?
- [ ] Is state wrong?
- [ ] Is reality wrong?
- [ ] Is the safest fix config change, import, state move, apply, or manual rollback?
- [ ] Does the fix need approval?

## Recover

- [ ] Make the smallest safe change.
- [ ] Avoid deleting state.
- [ ] Avoid force-unlock unless no active run exists.
- [ ] Run `terraform plan`.
- [ ] Confirm no unexpected destroy or replacement.
- [ ] Apply only after review if apply is required.

## Close

- [ ] Confirm clean plan.
- [ ] Write incident report.
- [ ] Document prevention work.
- [ ] Open follow-up issues.

