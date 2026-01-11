# Coverage Map Template

Use this to prove each planned item is covered by evidence.
Attach one row per epic/plan item.

| Plan item | Evidence type | Evidence reference | Status | Severity | Fix (if gap) | Notes |
| --- | --- | --- | --- | --- | --- | --- |
| {task or acceptance criteria} | {code/test/doc/behavior} | {file:line, test name, or description} | {covered (good/done) / partial / missing} | {low/med/high or "-"} | {fix: a; b; c} | {risk or gap} |

## How to fill

1. List each plan or acceptance item as written.
2. Add concrete evidence (file:line, test name, or behavior).
3. If status is partial or missing, set severity and list fixes as short steps: fix: a; b; c.
4. If covered (good/done), set severity and fix to "-".

## Quick checklist

- Every epic/plan item appears in the table.
- "Partial" or "missing" items become FINDINGS.
- Evidence references point to concrete files/tests, not general claims.
