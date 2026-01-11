# Template: Reviewer (Validation)

Use when `/validation reviewer` is invoked or when validation requires a code review pass.

## Activation

Start with:
> 🔍 **Reviewer**: провожу код-ревью по чек-листу AGENTS.md

## Goal

Confirm code quality against AGENTS.md rules: architecture, dependencies, Fail-Fast, tests, and maintainability.

## Integration with Validation

- If review is part of validation, do not re-run tests/lint.
- If validation has not been run for non-trivial changes, request validation before finishing.

## When to apply

- Any changes touching logic, public contracts, dependencies, or performance.
- Review-only request before final validation.

## Required Inputs

- epic.md or task scope
- plan.md (if available)
- diff / file list

## Output Format

```markdown
## Review: {PASS | FINDINGS}

Scope: {PR/branch/epic}
Summary: {1-3 sentences}

Findings (High/Medium only):
1. {Category} — {issue} ({file:line})
   Fix: {minimal change}
   Why: {risk or rule}

Notes:
- {nits or non-blockers}
```

## Review Process

1) **Context**
   - Read the task (tasks/*, epic.md) and intended scope.
   - Check AGENTS.md for applicable rules, architectural constraints, and deps.

2) **Diff and structure**
   - Review modified files and placement by decision tree.
   - Check module headers/docs and public interfaces.

3) **Risks and recommendations**
   - Flag architecture risks and suggest minimal fixes.

## Noise Control Policy

- Scope: only changed lines + nearby context.
- No duplicates: avoid re-stating resolved comments.
- Severity: only High/Medium inline; nits only in summary.
- Budget: max 3–5 inline comments with specific fixes.
- Evidence: each inline comment includes file:line, WHY, and HOW TO FIX.

## Stop Criteria

- If there are no High/Medium issues, finish quickly with PASS.
- If issues are already fixed in later commits, do not restate; mention in summary.

## Checklist

- Layers and placement
  - [ ] Files live in correct directories (core/data/scripts/docs).
  - [ ] Contracts (Pydantic) are separated from local structures (dataclass).
  - [ ] Minimal config injection: functions receive needed sub-config only.
- Dependencies
  - [ ] core has no pandas/heavy deps; pyarrow allowed if required.
  - [ ] Network usage only in providers/scripts; no hidden globals.
- Errors / Fail-Fast / NO FALLBACKS
  - [ ] **NO FALLBACKS**: fail loudly, no silent fallback.
  - [ ] No silent stubs; if needed use NotImplementedError with rationale.
  - [ ] No bare except; map errors at I/O boundaries.
  - [ ] CLI: except only for message formatting + Exit(1).
  - [ ] No getattr/hasattr defaults for required fields.
  - [ ] No mutation of validated Pydantic config.
  - [ ] Do not suppress exception context (`raise ... from None`).
  - [ ] No isinstance branching by provider type; use polymorphism/config.
- Code style
  - [ ] Line length ≤120 (hard limit 150).
  - [ ] CLI args: typer.Option in one line when ≤100 chars.
  - [ ] No duplication; extract shared options/helpers.
  - [ ] Dead code removed (no commented leftovers).
- Performance
  - [ ] No try/except or heavy ops in hot paths.
  - [ ] Algorithms/data structures fit the scope.
- Observability
  - [ ] Spans/timers present for key stages.
  - [ ] Logs contain no secrets/API keys.
- Tests and docs
  - [ ] Targeted tests added for changed code; network mocked.
  - [ ] Docs/examples updated; paths correct.
  - [ ] Examples are offline-first.
- TODO discipline
  - [ ] TODOs link to tasks/... or removed.

## Definition of Review Done

- Changes comply with AGENTS.md; no critical violations.
- Tests/lint are covered by validation (or noted if missing).
- Docs/examples updated where needed.

## Decision

Approve or Request Changes with a short actionable list.

## Tooling Notes

- Use `gh pr diff` to extract diff context.
- Use `gh pr view --json reviewComments,reviewThreads` to avoid duplicates.
- Align suggestions with `standards-lint`.
- Any review artifacts belong in `docs/reviews/` with a dated name.
