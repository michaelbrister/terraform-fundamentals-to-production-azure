# Command Log

## Environment

- Date:
- Terraform version:
- miniblue version:
- Shell:

## Commands

```bash
miniblue
curl -s http://localhost:4566/health
azlocal group create --name tf-course-lab23-rg --location eastus
azlocal functionapp create --resource-group tf-course-lab23-rg --name tfcourselab23func --location eastus
azlocal functionapp list --resource-group tf-course-lab23-rg
azlocal functionapp delete --resource-group tf-course-lab23-rg --name tfcourselab23func
azlocal group delete --name tf-course-lab23-rg
```

## Observations

- Function App create result:
- Function App list result:
- Cleanup result:

## Validation Boundary

What this proved:

- 

What this did not prove:

- 
