---
name: validation
description: Validate completed work against epic/plan and risk. Use after implementation, before closing. Triggers: validate, validation, check work, ready to close, acceptance check.
---

# Validation

Validate implemented work against scope and risk. Tests/lint are supporting evidence, not the definition of validation.

## Outcomes

- ACCEPTED: scope covered, risks mitigated, evidence clean.
- FINDINGS: blocking gaps or unmitigated risks.

## Required inputs

- epic.md (goal, scope, definition of done)
- plan.md or explicit plan in epic (required for non-trivial work)
- implementation diff / file list
- original request or issue statement (if not in epic)

## Workflow

1. Preconditions
   - Implementation is complete or explicitly marked ready.
   - If plan is missing or outdated for non-trivial work, return FINDINGS.

2. Plan integrity and scope coverage (required)
   - Confirm plan exists and matches the implementation intent.
   - Extract tasks/acceptance criteria from epic/plan.
   - Map each item to evidence: file(s), behavior, test, or doc.
   - Any unmapped, partial, or plan/implementation mismatch => FINDINGS.
   - Use references/coverage-map.md to record mapping.

3. Request alignment and completeness (required)
   - Compare implementation behavior to the original request and acceptance criteria.
   - If request is a replacement/refactor, require full cutover and removal of old paths unless explicitly required.
   - Partial solutions or dual-format support without requirement => FINDINGS.

4. Risk scan: "What can go wrong?" (required)
   - Do this before tests to avoid bias.
   - Identify likely failure modes for this change.
   - For each high-risk item, confirm mitigation and evidence or add FINDINGS.
   - Use prompts in references/risk-prompts.md; report the top risks and mitigations.

5. Behavioral verification
   - Walk critical flows and negative paths (manual or by reasoning/tests).
   - Verify docs/config/migrations needed for real use.

6. Supporting evidence (after implementation)
   - Run existing tests/lint if available.
   - Failures => FINDINGS.
   - Missing tests are not automatic failure, but note as risk if coverage is thin.
   - Do not treat passing tests/lint as a substitute for scope or risk checks.

7. Review (if required)
   - If changes touch logic/contracts/perf, run `/validation reviewer`.
   - Use @.claude/skills/validation/references/reviewer-template.md.
   - Treat High/Medium review issues as FINDINGS.
   - Record review status in evidence.

8. Verdict
   - Produce ACCEPTED or FINDINGS output.

## Risk prompts

See references/risk-prompts.md for the full checklist and risk scan template.

## Output format

### ACCEPTED

```markdown
## Validation: ACCEPTED

Epic: {epic_path}
Scope coverage: {N}/{N} items covered
Request alignment: {met}
Risk scan: {brief summary of top risks and mitigations}
Evidence:
- Tests: {result or "not run"}
- Lint: {result or "not run"}
- Manual/behavioral checks: {what was verified}
- Review: {passed or "not run"}

Notes: {limits/assumptions if any}
Next: /task:close (after review if required)
```

### FINDINGS

```markdown
## Validation: FINDINGS

Epic: {epic_path}
Verdict: NEEDS REWORK

Blocking issues:
1. {Category} - {issue} ({file:line if applicable})
   Fix: {what to change}
   Why: {why it matters or what breaks if left}

Non-blocking:
1. {Category} - {issue} ({file:line if applicable})

Scope gaps:
- {planned item not covered}

Request alignment:
- {mismatch or partial solution}

Risk scan:
- Unmitigated risk: {risk} -> {why it matters}

Evidence:
- Tests: {failures or "not run"}
- Lint: {errors or "not run"}
- Manual/behavioral checks: {what is missing}
- Review: {issues or "not run"}

Next: Fix blocking issues, update plan if needed, re-validate.
```

## Templates

### /validation reviewer

Run a focused code review using the reviewer template:
@.claude/skills/validation/references/reviewer-template.md

## Guardrails

- Do not accept with failing tests/lint if they exist and were run.
- Do not accept with missing or mismatched plan for non-trivial work.
- Do not accept partial refactors or dual-path compatibility unless explicitly required.
- If review is required, do not close until `/validation reviewer` is run.
- If validation cannot be completed (missing env/data), call it out in FINDINGS.

## References

- references/risk-prompts.md
- references/coverage-map.md
- references/reviewer-template.md
