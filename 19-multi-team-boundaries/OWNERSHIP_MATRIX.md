# Ownership Matrix

Use this matrix as a starting point for Lab 19.

| Area | Primary owner | Reviewers | Approval required? | Notes |
| --- | --- | --- | --- | --- |
| `modules/app_stack` interface | Platform team | App team, security team | yes | Changes can affect every environment |
| `live/dev` | App team | Platform team | maybe | Lower risk, still reviewed |
| `live/stage` | App team | Platform team | yes | Should match prod shape closely |
| `live/prod` | Platform team | App team, security team | yes | Strongest review and apply gate |
| `policy/` | Security team | Platform team | yes | Policy changes affect all teams |
| Provider versions | Platform team | App team | yes | Provider upgrades can change plans |
| Backend configuration | Platform team | Security team | yes | State storage and locks are critical |

## Questions

- Who can approve a production apply?
- Who owns emergency exceptions?
- Who can change required tags?
- Who can change module outputs?
- Who rotates real Azure credentials?

