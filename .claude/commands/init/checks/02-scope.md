# Check: <scope> section

## What it checks

AGENTS.md must contain `<scope>` section defining:
- What parts of the repo this applies to
- Canonical folder structure
- Task location pattern

## How to check

```
grep -q "<scope>" AGENTS.md
```

## Template to add

```xml
<scope>
  - Applies to the whole repo.
  - Canonical layout:
    - docs/ — documentation
    - src/ — source code
    - tests/ — tests
  - Tasks: `tasks/GH<N>-<slug>/epic.md` (epic-as-folder).
</scope>
```

## Questions to ask user

- Does this apply to whole repo or specific folders?
- What is your folder structure? (src/, lib/, app/?)
- Do you use epic-as-folder for tasks?
