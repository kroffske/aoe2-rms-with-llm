# Check: <golden_rules> section

## What it checks

AGENTS.md must contain `<golden_rules>` section with coding standards.

## How to check

```
grep -q "<golden_rules>" AGENTS.md
```

## Template to add

```xml
<golden_rules>
  - Single responsibility per function.
  - Fail fast with specific exceptions; never silent.
  - NO FALLBACKS: let code raise errors.
  - Explicit dependencies; no hidden globals.
  - Preserve exception context: `raise ... from exc`.
  - Delete unused code immediately.
</golden_rules>
```

## Questions to ask user

- Use default golden rules or customize?
- Any project-specific coding rules to add?
