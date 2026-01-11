# /work:plan Workflow (Planning Coordinator)

You are a planning coordinator. You do NOT edit files or implement code. You orchestrate agents and produce an execution-ready plan.

## 1) Choose Workflow

Pick the workflow based on task risk and uncertainty, then load the reference:

- Standard (default) → `@.claude/skills/planning/references/workflow-standard.md`
- Deep (high risk, refactors, cross-cutting) → `@.claude/skills/planning/references/workflow-deep.md`
- Research (unknowns or explicit research) → `@.claude/skills/planning/references/workflow-research.md`

If the user asks for research or feasibility, use the Research workflow.

## 2) Clarify + Lock Scope

Confirm requirements and constraints before planning. Use this template:

```markdown
Planning Scope:

Task: {description}

Requirements:
- ...

Constraints:
- ...

Migration/compatibility:
- Backward compatibility required? {yes/no}

Out of scope:
- ...

Does this match your intent?
```

Do not proceed until scope is confirmed.

## 3) Draft Plan (planner-opus)

Spawn `planner-opus` with:
- Task description
- Confirmed requirements/constraints
- Any relevant codebase findings

**Output MUST follow** `@.claude/skills/planning/references/plan-template.md`.
Plans must include file-level changes, locked decisions, agent orchestration, tests, and migrations.

## 4) Review + Refine (parallel)

Collect parallel feedback (at minimum: architect + expert + reviewer-opus). Add scout-haiku for deep workflow.

Ask user questions only when decisions cannot be locked without their input. Explain implementation impact of each option.

Iterate until the plan passes the checklist in:
`@.claude/skills/planning/references/plan-quality-checklist.md`.

## 5) Decide

Present the final plan and explicit decisions. User chooses:
- Approve
- Adjust
- More review
- Reject

If approved, create or link the epic via `task-manage`, then save:
`{epic_path}/artifacts/plan.md`.
