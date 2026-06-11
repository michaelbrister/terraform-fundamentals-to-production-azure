package main

required_tags := {"Environment", "ManagedBy", "Stack"}

tagged_types := {
  "azurerm_resource_group",
  "azurerm_virtual_network",
  "azurerm_network_security_group",
}

deny contains msg if {
  resource := input.resource_changes[_]
  resource.mode == "managed"
  tagged_types[resource.type]
  action_changes_resource(resource)

  tags := object.get(resource.change.after, "tags", {})
  missing := required_tags[_]
  not tags[missing]

  msg := sprintf("%s is missing required tag %q", [resource.address, missing])
}

deny contains msg if {
  resource := input.resource_changes[_]
  resource.mode == "managed"
  resource.type == "azurerm_network_security_group"
  action_changes_resource(resource)

  rule := object.get(resource.change.after, "security_rule", [])[_]
  lower(rule.direction) == "inbound"
  lower(rule.access) == "allow"
  rule.source_address_prefix == "*"
  rule.destination_port_range == "*"

  msg := sprintf("%s allows inbound traffic from * to all ports in rule %q", [resource.address, rule.name])
}

action_changes_resource(resource) if {
  action := resource.change.actions[_]
  action == "create"
}

action_changes_resource(resource) if {
  action := resource.change.actions[_]
  action == "update"
}
