# Capstone Evaluation Rubric

## Pass

The learner:

- explains the architecture clearly
- uses the shared module rather than copy/paste infrastructure
- separates dev, stage, and prod concerns
- predicts plans before applying
- keeps policy checks visible
- documents incident recovery thinking
- explains emulator limits honestly

## Strong Pass

The learner also:

- identifies likely production risks
- writes useful release and rollback notes
- explains state boundaries and team ownership
- maps local-first workflows to Terraform Cloud or real Azure
- gives clear remediation steps for policy failures

## Needs More Practice

The learner:

- applies without reading plans
- cannot explain state ownership
- treats policy as an obstacle rather than a guardrail
- skips recovery documentation
- mixes platform and app ownership without explanation
- claims the local emulator proves real Azure behavior without caveats

## Reviewer Questions

Ask:

- What would change if this moved to real Azure?
- Which team owns each part?
- What is the riskiest Terraform change in this design?
- How would you recover from drift?
- What policy failure would you expect if a required tag was removed?
- How would you promote a module change safely?

