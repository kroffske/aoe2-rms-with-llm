# Close Workflow (Epic / Research)

Use after validation (see `@.claude/skills/validation/SKILL.md`).

## Close Epic (GH-backed)

Prereqs:
- All tasks in `epic.md` are `[x]`
- Epic lives in `tasks/GH<N>-slug/`

Steps:
1. Identify files for THIS task (do not stage unrelated changes).
2. Create branch: `git checkout -b feat/GH<N>-<slug>`.
3. Stage task files + epic folder.
4. Move epic to done: `git mv tasks/GH<N>-slug/ tasks/done/`.
5. Commit with `Closes #<N>` and Claude signature.
6. Push and create PR (base default branch).
7. Return to default branch.

```bash
git checkout -b feat/GH<N>-<slug>
git add <task_files> tasks/GH<N>-slug/
git mv tasks/GH<N>-slug/ tasks/done/
git commit -m "feat: <description> - Closes #<N>"
git push -u origin feat/GH<N>-<slug>
gh pr create --base <default-branch> --title "..." --body "Closes #<N>"
git checkout <default-branch>
```

Default branch lookup:
```bash
gh repo view --json defaultBranchRef --jq '.defaultBranchRef.name'
```

Rules:
- Do not `git commit --amend`
- Do not stage everything (`git add .`)
- Use `Closes #N` only when ready to close

## Close Epic (Local LC)

No PR, no `Closes #N`:
```bash
git add <task_files> tasks/LC<N>-slug/
git mv tasks/LC<N>-slug/ tasks/done/
git commit -m "feat: <description>"
git push
```

## Commit Research (no epic)

Prereqs:
- `EXECUTIVE_SUMMARY.md` or `INDEX.md` exists
- Verdict stated (DO / DON'T / PARTIAL) with confidence

```bash
git add docs/research/YYYY-MM-DD_slug/
git commit -m "docs(research): topic - verdict (85% confidence)"
git push
```

## Partial Close (defer tasks)

Allowed only if core scope is complete and tests pass. Required actions:
- Add `## Deferred to Next Epic` with remaining `[ ]` tasks + rationale
- Update Success/DoD to match what is done
- Add follow-up reference (TODO.md or new epic)

## Anti-Patterns (short)

- Close without validation
- Stage unrelated changes
- Use amend
- Close with unfinished core scope
