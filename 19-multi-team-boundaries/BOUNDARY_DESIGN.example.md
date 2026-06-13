# Boundary Design Example

This example shows how to think about stack boundaries in a real Azure deployment.

## Stack: platform-network

Owner:

- Platform team

Owns:

- shared resource group
- shared virtual network
- shared subnets
- baseline tags

Outputs:

- virtual network name
- virtual network resource group name
- approved subnet names
- location

Does not own:

- application-specific settings
- application deployments
- app team secrets

## Stack: app-workload

Owner:

- Application team

Consumes:

- approved subnet name from platform
- location from platform
- naming prefix from platform standards

Owns:

- app-specific resource group
- app-specific network security group rules within policy
- app-specific resources

Does not own:

- platform virtual network
- shared route tables
- production policy exceptions

## Bad dependency

```text
platform-network output -> app-workload input
app-workload output -> platform-network input
```

Why it is bad:

- neither stack can plan independently
- changes require coordinated state reads in both directions
- ownership becomes unclear

## Better dependency

```text
platform-network output -> app-workload input
security policy -> validates both plans
```

Why it is better:

- platform remains foundational
- app consumes a stable contract
- policy validates behavior without owning app resources

