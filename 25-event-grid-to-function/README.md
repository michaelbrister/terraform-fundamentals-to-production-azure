# Lab 25 - Event Grid To Function

## What this lab teaches you

This lab teaches the event-driven architecture pattern that connects Event Grid to a Function App.

You will learn:

- what an Event Grid topic represents
- how publishers, topics, subscriptions, and handlers relate
- how Terraform can create a local Event Grid topic with `miniblue`
- where local validation stops before end-to-end event delivery
- how to design a Function handler contract before wiring production events

## Scenario

Your team has an HTTP API design from Lab `23` and an auth model from Lab `24`.

Now the application needs asynchronous processing. Instead of making every caller wait for downstream work, the system should publish an event and let a Function App handle it later.

In real Azure, the flow would look like:

1. An application publishes an event to Event Grid.
2. Event Grid receives the event on a topic.
3. An event subscription filters and routes the event.
4. A Function App receives the event.
5. The function validates, processes, logs, and retries safely.

In this local-first course, the Event Grid topic path is Terraform-validated. The Function App control-plane path is `azlocal`-validated. The event subscription and delivery path is not yet proven locally, so this lab is mixed: hands-on for topic creation, design-first for delivery.

## Lab mode

This is a **mixed** lab.

You will:

- run the Terraform-validated Event Grid topic root
- inspect the topic outputs
- design the event contract and Function handler behavior
- document what remains before this can become an end-to-end local lab

## Prerequisites

Complete:

- `23-http-api-and-function-app`
- `24-entra-auth`

You should have:

- Terraform available
- `miniblue` installed
- local `miniblue` running
- the validation root at `validation/miniblue/services/eventgrid-topic`

## Local validation boundary

Validated locally:

- `azlocal eventgrid topic create/list`
- `azurerm_eventgrid_topic` `init`, `validate`, `apply`, and `destroy`
- Function App create/list through `azlocal`

Not yet validated locally:

- `azurerm_eventgrid_event_subscription`
- delivery from Event Grid to Function App
- Function trigger execution
- retry and dead-letter behavior
- managed identity or authenticated delivery

This lab teaches the architecture without pretending the local emulator proves the whole production path.

## Step 1 - Start miniblue

Start the emulator:

```bash
miniblue
```

In another terminal, verify health:

```bash
curl -s http://localhost:4566/health
```

## Step 2 - Run The Event Grid Topic Root

From the repo root, initialize and validate the focused root:

```bash
terraform -chdir=validation/miniblue/services/eventgrid-topic init -backend=false
terraform -chdir=validation/miniblue/services/eventgrid-topic validate
```

Apply the topic:

```bash
terraform -chdir=validation/miniblue/services/eventgrid-topic apply -auto-approve
```

Record:

- topic name
- topic endpoint
- resource group name
- tags

## Step 3 - Inspect The Terraform Shape

Open:

```bash
validation/miniblue/services/eventgrid-topic/main.tf
validation/miniblue/services/eventgrid-topic/outputs.tf
```

Answer:

- Which resource creates the topic?
- Which resource owns the location?
- Which outputs would a publisher need?
- Which values should not be casually printed in a real environment?
- What would need to change before promoting this into a reusable module?

## Step 4 - Design The Event Contract

Use `EVENT_CONTRACT.template.md`.

Define:

- event type
- event subject
- schema version
- required fields
- optional fields
- idempotency key
- failure handling expectations

Keep the event small and specific. A vague event such as `thing.changed` is harder to route, test, and govern than a precise event such as `workitem.submitted.v1`.

## Step 5 - Design The Function Handler

Use `FUNCTION_HANDLER_DESIGN.template.md`.

Define:

- trigger type
- expected event schema
- validation rules
- retry behavior
- logging fields
- secret and identity needs
- downstream side effects

Answer:

- What should the handler do if the event is malformed?
- What should happen if processing fails?
- Which operations must be idempotent?
- Which failures should alert a human?

## Step 6 - Sketch The Event Subscription

Write a Terraform design note. Do not apply it locally yet.

In real Azure, you might expect:

- `azurerm_eventgrid_topic`
- `azurerm_linux_function_app`
- `azurerm_eventgrid_event_subscription`
- retry policy
- subject filters or advanced filters
- dead-letter destination
- identity or endpoint authentication

Answer:

- Which resource owns the topic?
- Which resource owns the subscription?
- Which team owns the handler?
- Which filters prevent unwanted events?
- What evidence would prove delivery works?

## Step 7 - Destroy The Topic

Destroy the validation resources:

```bash
terraform -chdir=validation/miniblue/services/eventgrid-topic destroy -auto-approve
```

Record the cleanup result in `VALIDATION_LOG.template.md`.

## Deliverable

Create an event-driven design packet with:

- completed `EVENT_CONTRACT.template.md`
- completed `FUNCTION_HANDLER_DESIGN.template.md`
- completed `VALIDATION_LOG.template.md`
- Terraform event subscription sketch
- a paragraph explaining the local validation boundary
- a real-Azure appendix for production delivery validation

## Success criteria

You are done when you can explain:

- the difference between an Event Grid topic and an event subscription
- which part of this lab is Terraform hands-on
- why delivery to Function App is still a validation checkpoint
- what an event contract protects
- how retries, idempotency, logging, and dead-lettering reduce production risk
