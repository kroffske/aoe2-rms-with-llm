# Check: <project> section

## What it checks

AGENTS.md must contain `<project>` section with:
- `<name>` — project name
- `<description>` — what the project does
- `<language>` — primary language (python, typescript, etc.)
- `<stack>` — key technologies (optional but recommended)

## How to check

```
grep -q "<project>" AGENTS.md
```

## Template to add

```xml
<project>
  <name>{{project_name}}</name>
  <description>{{description}}</description>
  <language>{{language}}</language>
  <stack>{{stack}}</stack>
</project>
```

## Questions to ask user

- Project name?
- Brief description (1-2 sentences)?
- Primary language?
- Key stack components? (e.g., FastAPI, React, PostgreSQL)
