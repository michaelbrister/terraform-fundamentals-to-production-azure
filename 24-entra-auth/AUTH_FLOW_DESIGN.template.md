# Auth Flow Design

## API

- API name:
- Protected route:
- Caller type:
- Environment:

## Authentication Flow

1. Caller requests a token from:
2. Token audience:
3. Token issuer:
4. Token presented to:
5. Application validates:

## Authorization Decision

Required claim, group, scope, or role:

- 

Routes and access:

| Route | Required access | Failure response |
| --- | --- | --- |
| `GET /health` |  |  |
| `POST /api/work` |  |  |

## Terraform And Platform Responsibilities

Terraform should manage:

- 

Platform or identity team should manage:

- 

Application code should enforce:

- 

## Local Development Behavior

Local substitute:

- 

What this does not prove:

- 

## Production Behavior

Production requirement:

- 

Audit evidence:

- 
