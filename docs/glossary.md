# Glossary

This glossary uses Azure-flavored examples, but the Terraform concepts are portable.

- **Apply**: The Terraform command that performs the changes shown in a plan.
- **Backend**: The place Terraform stores state. In Azure, a common remote backend is Azure Blob Storage through `backend "azurerm"`.
- **Configuration**: The `.tf` files that describe desired infrastructure.
- **Drift**: A difference between Terraform state and real infrastructure, usually caused by an out-of-band change.
- **Dynamic block**: A Terraform language feature for generating repeatable nested blocks, such as optional network security group rules.
- **Emulator**: A local service that imitates cloud APIs. This course uses `miniblue` so learners can practice Azure-style Terraform without starting with an Azure account.
- **Import**: The process of bringing an existing resource under Terraform management.
- **Local state**: State stored on the learner's machine, commonly in `terraform.tfstate`.
- **Locking**: A safety mechanism that prevents multiple Terraform runs from modifying the same state at the same time.
- **Module**: A reusable Terraform package with inputs, resources, and outputs.
- **Moved block**: A Terraform configuration block that records a resource address change so Terraform can preserve the existing object.
- **Plan**: Terraform's preview of proposed creates, updates, replacements, and destroys.
- **Provider**: A Terraform plugin that knows how to talk to an API, such as `azurerm`.
- **Resource**: A managed object, such as an Azure resource group, virtual network, subnet, or network security group.
- **Resource address**: Terraform's identifier for a resource instance in state, such as `azurerm_resource_group.this`.
- **State**: Terraform's record of the objects it manages and the attributes it knows about them.
- **Variable**: A configurable input to a Terraform root module or child module.

