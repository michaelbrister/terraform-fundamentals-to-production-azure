# Event Contract

## Event Summary

- Event type:
- Version:
- Producer:
- Consumer:
- Topic:

## Routing

- Subject pattern:
- Filters:
- Expected subscription owner:

## Schema

Required fields:

| Field | Type | Description |
| --- | --- | --- |
| `id` | string | Unique event id |
| `eventType` | string | Event type and version |
| `subject` | string | Routing subject |
| `eventTime` | string | Event timestamp |
| `data` | object | Event payload |

Payload fields:

| Field | Type | Required? | Description |
| --- | --- | --- | --- |
|  |  |  |  |

## Idempotency

- Idempotency key:
- Duplicate handling:
- Safe retry behavior:

## Failure Handling

- Malformed event:
- Downstream unavailable:
- Poison event:
- Human alert threshold:

## Example Event

```json
{
  "id": "example-id",
  "eventType": "workitem.submitted.v1",
  "subject": "workitems/example",
  "eventTime": "2026-06-13T00:00:00Z",
  "data": {
    "workItemId": "example"
  }
}
```
