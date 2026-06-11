# Lab 12 — Timed Exam Drills

## What this lab teaches you

These drills help you practice Terraform reasoning under time pressure.

Earlier labs explain concepts slowly. This lab expects you to recognize patterns quickly:

- backend initialization failures
- unstable identity
- dynamic block reasoning
- module refactors
- imports
- drift
- locks
- provider constraints
- dependency cycles

## How to use these drills

For each drill:

1. set a timer
2. read only the drill README
3. predict the failure or plan
4. run the minimum commands needed
5. stop before destructive applies
6. write down the root cause

## Drill order

1. `drill-01-backend-init-fail`
2. `drill-02-count-to-for_each-no-recreate`
3. `drill-03-for_each-key-stability`
4. `drill-04-dynamic-optional`
5. `drill-05-module-refactor-moved`
6. `drill-06-import-and-converge`
7. `drill-07-drift-reconcile`
8. `drill-08-stale-lock-recovery`
9. `drill-09-provider-version-conflict`
10. `drill-10-dependency-cycle`

## Azure edition note

The Azure course is `miniblue`-first. Backend drills are concept-first because the fully local `backend "azurerm"` flow is not currently part of the proven emulator path.

## Success criteria

You are done when you can:

- explain the root cause without guessing
- identify whether the issue is config, state, backend, graph, or reality
- avoid unsafe applies
- restore or describe the path to a clean plan
