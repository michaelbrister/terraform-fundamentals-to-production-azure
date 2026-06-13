# Lab 21 - Incident Recovery

## What this lab teaches you

This lab teaches how to recover when Terraform is in an uncertain state.

You will learn:

- how to slow down during an incident
- how to inspect configuration, state, and reality separately
- when `force-unlock` is safe
- how to handle drift and partial operations
- how to write a clear incident report
- how to prevent the same Terraform incident from happening again

## Scenario

A Terraform run was interrupted during a change window.

The team is not sure whether the environment changed, whether state is current, or whether another run is still active. Your job is not to "fix it fast." Your job is to restore safe operation.

In this local-first Azure course, you will use existing labs to practice the recovery mindset without requiring real Azure or a remote backend.

## Incident rule

Use this rule before touching state:

> Do not mutate state until you know which system is wrong: configuration, state, or reality.

Terraform incidents usually involve one or more of these:

- configuration changed unexpectedly
- state is stale or locked
- real infrastructure drifted
- a run was interrupted
- someone imported or removed state incorrectly
- policy or CI blocked a risky change

## Recovery model

Use this order:

1. Stop new changes.
2. Identify the active owner of the incident.
3. Preserve evidence.
4. Inspect configuration.
5. Inspect state.
6. Inspect reality.
7. Decide whether to revert, adopt, import, move, or apply.
8. Make the smallest safe change.
9. Confirm a clean plan.
10. Write the incident report.

## Exercise 1 - Drift Recovery

Use:

```bash
10-breakfix/scenario-03-drift
```

Practice:

- create baseline resources
- introduce drift with `azlocal`
- inspect the plan
- decide whether Terraform or manual reality should win
- restore a clean plan

Answer:

- Was the drift acceptable?
- Did you revert drift or adopt it?
- What evidence did you use?

## Exercise 2 - Lock And Partial Operation Mindset

Use:

```bash
10-breakfix/scenario-04-locks-and-partial-ops
```

This scenario is intentionally more conceptual in the local preview because the fully local Azure remote backend path is not proven yet.

Practice explaining:

- what a state lock protects
- why deleting lock files or state files is dangerous
- when `terraform force-unlock` is appropriate
- what evidence proves no other run is active

## Exercise 3 - State Inspection Recovery

Use:

```bash
13-state-subcommands
```

Practice:

```bash
terraform state list
terraform state show <address>
terraform state pull
```

Answer:

- Which resources does Terraform manage?
- Which addresses map to which remote IDs?
- Which state commands are read-only?
- Which commands can mutate state?

## Exercise 4 - Import-Based Recovery

Use:

```bash
17-import-and-adopt
```

Practice:

- create a resource out of band
- import it into state
- converge configuration
- confirm a clean plan

Answer:

- Why was import safer than recreate?
- What did import add to state?
- What did import not do for you?

## Exercise 5 - Write The Incident Report

Use `INCIDENT_REPORT.template.md`.

Your report should include:

- impact
- timeline
- root cause
- detection method
- recovery steps
- validation steps
- prevention actions

## Common Recovery Actions

| Symptom | First inspection | Safe recovery options |
| --- | --- | --- |
| Plan wants unexpected destroy | `terraform plan`, recent diff | stop, review config, use moved/import/state mv if appropriate |
| Resource changed outside Terraform | plan + provider/CLI inspection | revert drift or update config intentionally |
| Resource exists but state does not know it | `terraform state list`, CLI show | import, then converge config |
| State address is wrong after refactor | `terraform state list` | `moved` block or `terraform state mv` |
| Lock blocks run | backend/run history | confirm no active run, then force-unlock only if safe |
| CI policy blocks change | policy output | fix config or document approved exception |

## What Not To Do

Do not:

- delete `terraform.tfstate` to "start fresh"
- run `apply` just to see what happens
- force-unlock while another run may be active
- import resources without matching configuration
- bypass policy without documenting why
- hide an incident because the fix seemed small

## Deliverable

Create a recovery packet with:

- one completed incident report
- one recovery checklist
- one command log
- final clean plan evidence
- prevention recommendations

## Success criteria

You are done when you can explain:

- how to determine whether config, state, or reality is wrong
- why state mutation commands require extra caution
- when import, state move, or config change is the right recovery path
- why `force-unlock` is not a generic fix button
- how to communicate Terraform incidents clearly to a team

