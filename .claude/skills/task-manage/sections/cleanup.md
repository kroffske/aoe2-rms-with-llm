# Cleanup (Delete Tasks/Epics)

Start response with: `Удаляю таски: <criteria>`.

## Rules

- Print the start line before any commands to show the skill is active.
- Search both local `tasks/` and GitHub Issues.
- Only delete folders inside `tasks/`.
- If the request is ambiguous, list candidate folders and ask for confirmation.
- Deletion implies closing GH issues for `GH<N>-*` tasks unless the user says to keep them open.
- If a GH issue exists and local `epic.md` is present, sync the issue body from `epic.md` before closing.
- GitHub close reasons are limited to `completed` or `not planned`. Use `not planned` for cancellations and add a comment like "Canceled: <reason>".

## Suggested steps

1. Check GH issues first:
   - by search terms → `gh issue list --label "type:task" --search "<term> in:title" --state all`
2. Identify candidate folders locally by name or pattern.
3. Link GH issues from local `GH<N>-*` folders → `gh issue view <N>`.
4. If mismatched (GH issue without local folder or vice versa), list and confirm.
5. Confirm delete + close list and close reason.
6. Sync issue bodies from `epic.md` (if present), then close issues with reason + comment.
7. Remove folders with `rm -rf`.
8. Report what was deleted and which issues were closed (with reason).

## Handy commands

```bash
gh issue list --label "type:task" --search "test in:title" --state all
ls -1 tasks | rg -i 'test|demo|tmp'
git status --short --untracked-files=all | rg '^\\?\\? tasks/'
gh issue view 123 --json number,state,title,url
gh issue close 123 --reason "not planned" --comment "Canceled: test/demo cleanup."
```
