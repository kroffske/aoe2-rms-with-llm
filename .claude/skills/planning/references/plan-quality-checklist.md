# Plan Quality Checklist

Use before final approval.

## Completeness
- Scope lock confirmed by user.
- No critical decisions left as TBD.
- File-level changes listed (create/update/delete).
- Each batch includes "how" details, not just goals.
- Tests and validation commands listed.
- Migration/cutover and rollback included when applicable.
- Risks and mitigations documented.
- Open questions are resolved or explicitly escalated.
- No unnecessary backward-compatibility layers unless required.
- Agent orchestration defined: sequence, ownership, and parallelism.

## Execution Readiness
- Plan can be handed to implementers without additional design choices.
- Dependencies and ordering between batches are clear.
- Acceptance criteria are measurable.
- Research artifacts linked when research workflow is used.
