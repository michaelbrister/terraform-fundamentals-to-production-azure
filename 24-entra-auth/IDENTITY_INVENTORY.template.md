# Identity Inventory

## System

- Application:
- Environment:
- Owner:
- Date:

## Identities

| Identity | Human or workload? | Purpose | Credential location | Owner | Rotation/access review |
| --- | --- | --- | --- | --- | --- |
| Developer | Human | Open pull requests and run local plans | Local login or local emulator credentials |  |  |
| CI runner | Workload | Run validation and plans | GitHub Actions secrets or OIDC |  |  |
| Terraform deployer | Workload | Apply approved infrastructure changes | Secret store or federated identity |  |  |
| Function App runtime | Workload | Access application dependencies | Managed identity where possible |  |  |
| API caller | Human or workload | Call protected routes | Entra-issued token |  |  |
| Break-glass operator | Human | Emergency production recovery | Privileged access workflow |  |  |

## Local Versus Real Azure

Local-only identities:

- 

Real-Azure-only identities:

- 

Identities shared across both workflows:

- 

## Notes

- 
