# Capstone Submission Checklist

## Architecture

- [ ] Architecture brief explains the stack.
- [ ] Module responsibilities are clear.
- [ ] Environment responsibilities are clear.
- [ ] Team ownership boundaries are documented.
- [ ] Real Azure differences are called out.

## Terraform

- [ ] `terraform fmt` passes for touched roots.
- [ ] `terraform validate` passes for touched roots.
- [ ] Plans are reviewed before apply.
- [ ] No unexpected destroy or replacement is accepted.
- [ ] State operations, if any, are documented.

## Environments

- [ ] `live/dev` is explained.
- [ ] `live/stage` is explained.
- [ ] `live/prod` is explained.
- [ ] Promotion order is documented.
- [ ] Rollback considerations are documented.

## Policy And CI

- [ ] Policy pass fixture result is recorded.
- [ ] Policy fail fixture results are explained.
- [ ] Hardened policy fixture results are explained.
- [ ] CI or smoke script result is recorded.
- [ ] Remediation guidance is included.

## Professional Scenarios

- [ ] Import/adoption evidence or explanation is included.
- [ ] Module promotion notes are included.
- [ ] Team boundary design is included.
- [ ] Policy hardening rollout is included.
- [ ] Incident recovery report or checklist is included.

## Final Review

- [ ] README or final notes are clear enough for another learner.
- [ ] Assumptions are listed.
- [ ] Known limitations are listed.
- [ ] Completion reflection is included.

