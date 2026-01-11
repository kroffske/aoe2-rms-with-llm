---
name: planning
description: Detailed implementation planning and multi-agent plan review. Use when asked to create or refine a work plan, plan.md, or the /work:plan workflow; when scope and critical decisions must be locked before execution; or when a plan must include file-level changes, tests, and migration steps. Triggers: "plan", "planning", "work plan", "work:plan", "implementation plan", "plan.md".
---

# planning

## Purpose

Create execution-ready plans with locked decisions and explicit file-level changes that can be handed to implementers without ambiguity.

## Non-negotiables

- Lock scope and requirements before planning.
- Resolve critical decisions during planning; do not defer to implementers.
- Describe HOW changes will be implemented, not just WHAT.
- Provide explicit file-level changes (create/update/delete) and test coverage.
- Call out migrations, cutovers, and rollback strategy when relevant.
- Avoid unnecessary backward compatibility; default to full cutover unless explicitly required.
- Specify agent orchestration: sequencing, ownership (batch vs task), and parallelism.

## Workflow Selection

Choose the workflow that matches task risk and uncertainty:

- Standard: default for well-scoped tasks.
- Deep: refactors, cross-cutting changes, high risk, or multi-team impact.
- Research: unknowns or explicit research needs; produce a research artifact first.

Load the corresponding reference and follow it end-to-end.

## Output Rules

- Plan artifact: `{epic_path}/artifacts/plan.md`
- Research workflow: produce research output per `@.claude/skills/research/SKILL.md`, then link it in the plan.
- If no epic context, request task creation via task-manage; do not create folders manually.

## Integration

- Use `task-manage` for epic/task creation and lifecycle.
- Follow `handoff` protocol for artifacts and coordinator summaries.

## Sections

- [@sections/work-plan.md] - /work:plan command body

## References

- [@references/plan-template.md] - Required plan structure with file-level changes.
- [@references/plan-quality-checklist.md] - Completeness checks before approval.
- [@references/workflow-standard.md] - Default planning workflow.
- [@references/workflow-deep.md] - Deep planning workflow for high risk.
- [@references/workflow-research.md] - Planning with research artifact.
