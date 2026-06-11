# Drill 08 — Stale Lock Recovery

**Timebox:** 10 minutes

## Prompt

A Terraform run reports that state is locked.

## Tasks

1. Decide whether another run is active.
2. Identify the lock ID.
3. Explain when `terraform force-unlock` is appropriate.

## Success answer

Only force-unlock when you are certain no operation is active. A lock is a safety mechanism, not an inconvenience to bypass casually.
