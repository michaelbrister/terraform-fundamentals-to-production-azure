# Policy Remediation Guide

Use this guide when a policy check fails.

## Missing Required Tag

Example failure:

```text
azurerm_resource_group.app is missing required tag "Name"
```

Fix:

- Add the missing tag to the resource or module tag map.
- Prefer module-level tag defaults when many resources need the same tag.
- Confirm the next plan shows an in-place tag update, not replacement.

## Invalid Environment Tag

Example failure:

```text
azurerm_resource_group.app has invalid Environment tag "sandbox"
```

Fix:

- Use one of the approved values: `dev`, `stage`, `prod`.
- If a new environment is legitimate, update the policy through review before using it.

## Wildcard Inbound Source

Example failure:

```text
azurerm_network_security_group.app allows inbound traffic from wildcard source in rule "allow-admin"
```

Fix:

- Replace `source_address_prefix = "*"` with a narrower CIDR range.
- For real Azure, prefer approved corporate, private, or service-specific ranges.
- If public ingress is intentional, document the exception and require security review.

## Wildcard Inbound Port

Example failure:

```text
azurerm_network_security_group.app allows inbound traffic to all ports in rule "allow-everything"
```

Fix:

- Replace `destination_port_range = "*"` with the specific required port.
- Use separate rules for separate protocols or ports when that makes review clearer.

## Exception Process

An exception should include:

- resource address
- business reason
- expiration date
- compensating control
- approver

Avoid permanent exceptions unless the policy is wrong for the platform.

