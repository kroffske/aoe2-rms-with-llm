# Rules Checklist

Detailed checklist for creating quality rules in Claude Code.

## Structure

```
.claude/rules/
├── python.md          # Scoped to Python files
├── testing.md         # Scoped to test files
└── architecture.md    # Scoped to specific paths
```

## Critical: paths: is Required!

**A rule without `paths:` loads ALWAYS into EVERY context.**

This bloats context unnecessarily. Always scope rules to relevant files.

## Frontmatter Checklist

### Required Field

- [ ] `paths` present in frontmatter
- [ ] `paths` contains relevant glob patterns
- [ ] Exclusion patterns prefixed with `!`

**Good example:**
```yaml
---
paths:
  - src/**/*.py
  - scripts/**/*.py
  - "!tests/**"
  - "!**/migrations/**"
---
```

**Bad example (NO paths = always loaded!):**
```yaml
---
# No paths specified!
---
```

## Glob Patterns

| Pattern | Matches |
|---------|---------|
| `src/**/*.py` | All .py files under src/ |
| `*.md` | Markdown files in root |
| `tests/unit/**` | Everything under tests/unit/ |
| `!tests/**` | Exclude tests directory |
| `"!**/node_modules/**"` | Exclude node_modules anywhere |

**Note:** Exclusion patterns need quotes in YAML.

## Body Checklist

### Content

- [ ] Focused on ONE topic/domain
- [ ] Actionable guidelines (not philosophy)
- [ ] Code examples for patterns
- [ ] Anti-patterns with fixes
- [ ] Single language (EN or RU)

### Size

- [ ] Keep rules concise (~100-300 lines)
- [ ] Split large rules into multiple files
- [ ] Each file scoped to its domain

## When to Create a Rule

| Scenario | Create Rule? |
|----------|--------------|
| Code style for Python files | Yes, scope to `**/*.py` |
| Testing conventions | Yes, scope to `tests/**` |
| Architecture for all code | Yes, scope to `src/**` |
| One-time instruction | No, use CLAUDE.md or skill |
| User preference for session | No, just tell Claude |

## Rule vs CLAUDE.md vs Skill

| Use Rule When | Use CLAUDE.md When | Use Skill When |
|---------------|--------------------| ----------------|
| Path-specific standards | Always-relevant conventions | On-demand knowledge |
| Auto-loads on file match | Always loaded | Triggered by description |
| Coding style, patterns | Project overview | Procedures, workflows |

## Common Scoping Patterns

### Language-specific
```yaml
paths:
  - "**/*.py"           # Python
  - "**/*.ts"           # TypeScript
  - "**/*.go"           # Go
```

### Directory-specific
```yaml
paths:
  - src/api/**          # API code
  - lib/database/**     # Database layer
  - services/**         # Services
```

### File-type specific
```yaml
paths:
  - "**/test_*.py"      # Test files
  - "**/*_test.go"      # Go test files
  - "**/*.spec.ts"      # TypeScript specs
```

### Exclusions
```yaml
paths:
  - src/**/*.py
  - "!src/generated/**"     # Exclude generated
  - "!src/**/migrations/**" # Exclude migrations
  - "!**/__pycache__/**"    # Exclude cache
```

## Final Verification

- [ ] `paths:` frontmatter present
- [ ] Patterns match intended files (test with glob)
- [ ] Exclusions prevent unwanted loading
- [ ] Content is actionable, not philosophical
- [ ] Examples show correct patterns
- [ ] Anti-patterns show what to avoid
- [ ] Rule doesn't duplicate CLAUDE.md content
