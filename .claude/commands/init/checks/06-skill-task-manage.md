# Check: task-manage skill reference

## What it checks

AGENTS.md or settings should reference the task-manage skill:

```
@.claude/skills/task-manage/SKILL.md
```

This skill is essential for epic-based task management.

## How to check

```
grep -q "task-manage" AGENTS.md
# or check .claude/settings.json
```

## Template to add

Add at the end of AGENTS.md:

```markdown
## Skills

@.claude/skills/task-manage/SKILL.md
```

## Questions to ask user

- Do you want task management with epic-as-folder pattern?
- If yes, add skill reference
