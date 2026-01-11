# Check: <layers> section (Recommended)

## What it checks

AGENTS.md should contain `<layers>` section defining architectural layers.

**Status:** Recommended (not required)

## How to check

```
grep -q "<layers>" AGENTS.md
```

## Template to add

```xml
<layers>
  - Domain models → models/
  - Config → config/
  - Core logic → core/
  - Providers → providers/ (external integrations)
  - CLI → cli/
</layers>
```

## Questions to ask user

- Do you have distinct architectural layers?
- What are your main modules and their responsibilities?
