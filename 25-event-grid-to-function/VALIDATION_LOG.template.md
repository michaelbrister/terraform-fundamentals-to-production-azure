# Validation Log

## Environment

- Date:
- Terraform version:
- miniblue version:
- Shell:

## Commands

```bash
miniblue
curl -s http://localhost:4566/health
terraform -chdir=validation/miniblue/services/eventgrid-topic init -backend=false
terraform -chdir=validation/miniblue/services/eventgrid-topic validate
terraform -chdir=validation/miniblue/services/eventgrid-topic apply -auto-approve
terraform -chdir=validation/miniblue/services/eventgrid-topic destroy -auto-approve
```

## Observed Outputs

- Topic name:
- Topic endpoint:
- Resource group:
- Destroy result:

## What This Proved

- 

## What This Did Not Prove

- 

## Next Validation Target

- 
