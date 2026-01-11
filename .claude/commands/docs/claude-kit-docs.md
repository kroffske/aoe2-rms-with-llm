---
description: Create or sync Technical Solution documentation (component-based).
argument-hint: <free-form prompt text>
---

# /docs:claude-kit — Claude Kit Documentation

Create or update component-based Technical Solution docs using the claude-kit-docs skill.

@.claude/skills/claude-kit-docs/SKILL.md

## Notes

- `$ARGUMENTS` is passed as plain text; do not parse it.
- Follow the skill exactly; it defines structure, templates, and rules.

## Process

1) Read the skill and select a template:
   - `TechnicalSolution.full` / `Simple` / `Research`
   - English by default; use Russian if requested.
2) If critical details are missing, ask one short clarification (e.g., component name, scope, template, language). Avoid trivial questions.
3) Inventory `docs/` and map existing docs to components.
4) Enforce flat structure: `docs/<component>/README.md` + `docs/<component>/references/*.md`.
5) Ensure a top-level system component exists and links to subcomponents.
6) Keep `README.md` diagrams 2–4; move deep diagrams/workflows to `references/`. Label all arrows.
7) Update headers (code reference + date) and note any UNCONFIRMED mappings.

## Planning with Opus

For large or ambiguous scopes, run `/work:plan` with multiple Opus agents to align on scope and steps before editing. Use `/work:team` only if execution needs parallelization.

## Deliverables

- `docs/<component>/README.md` for each component
- `docs/<component>/references/*.md` for detailed diagrams, workflows, interfaces, configs, and decisions
- Research notes in `docs/<component>/references/` unless specified otherwise
