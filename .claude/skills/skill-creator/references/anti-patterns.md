# Anti-Patterns

Common mistakes when creating skills, commands, and rules — with fixes.

## Universal Anti-Patterns

### Usage Section in Body

**Problem:** Skill/command body contains usage examples.

```markdown
## Usage

/my-skill arg1 arg2
/my-skill --flag value
```

**Why it's wrong:** The skill/command is ALREADY invoked when body loads. Usage examples are pointless.

**Fix:** Remove usage section. Start with instructions for WHAT TO DO.

---

### "When to Use" in Body

**Problem:** Body contains triggering guidance.

```markdown
## When to Use This Skill

Use this skill when you need to:
- Create a new feature
- Refactor code
```

**Why it's wrong:** Body loads AFTER triggering. This info comes too late.

**Fix:** Move to frontmatter `description`. That's what Claude uses for triggering.

---

### "Triggers" Section

**Problem:** Explicit triggers list in skill.

```markdown
## Triggers

- "create skill"
- "new skill"
- "skill creator"
```

**Why it's wrong:** Skills don't have explicit triggers. Description IS the trigger mechanism.

**Fix:** Include trigger terms naturally in `description` field.

---

### Mixed Languages

**Problem:** Content mixes EN and RU.

```markdown
# Skill Creator

Создаёт skills для Claude Code.

## Process

1. First step — первый шаг
2. Second step — второй шаг
```

**Why it's wrong:** Inconsistent, harder to read, confusing.

**Fix:** Pick ONE language and stick to it. EN for broader compatibility, RU if team prefers.

---

### Auxiliary Documentation Files

**Problem:** Skill folder contains extra docs.

```
my-skill/
├── SKILL.md
├── README.md           # Wrong!
├── CHANGELOG.md        # Wrong!
├── INSTALLATION.md     # Wrong!
└── QUICK_REFERENCE.md  # Wrong!
```

**Why it's wrong:** These are for humans, not Claude. They add clutter and confusion.

**Fix:** Only include files Claude needs: SKILL.md, references/, assets/, scripts/.

---

### Deeply Nested References

**Problem:** References reference other references.

```
SKILL.md → references/main.md → references/sub/detail.md → ...
```

**Why it's wrong:** Hard to navigate, Claude may miss content.

**Fix:** Keep references one level deep. All reference files link directly from SKILL.md.

---

## Skill-Specific Anti-Patterns

### Vague Description

**Problem:**
```yaml
description: Helps with code stuff.
```

**Why it's wrong:** Claude can't match this to user requests.

**Fix:**
```yaml
description: |
  Creates and validates Python test files following AAA pattern.
  Use when: writing tests, test structure, pytest fixtures, "create test".
```

---

### Invalid Frontmatter Fields

**Problem:**
```yaml
name: my-skill
description: Does things
version: 1.0.0        # Invalid!
license: MIT          # Invalid!
triggers:             # Invalid!
  - keyword1
```

**Why it's wrong:** Only `name`, `description`, `allowed-tools`, `model` are valid.

**Fix:** Remove invalid fields. They're ignored anyway.

---

### SKILL.md Over 500 Lines

**Problem:** Everything crammed into SKILL.md.

**Why it's wrong:** Bloats context, violates progressive disclosure.

**Fix:** Move details to references/. SKILL.md should be entry point with navigation.

---

## Command-Specific Anti-Patterns

### Arguments Documentation in Body

**Problem:**
```markdown
## Arguments

- `arg1` - First argument
- `arg2` - Second argument
- `--flag` - Optional flag
```

**Why it's wrong:** This repeats frontmatter `argument-hint`. Wastes tokens.

**Fix:** Use `argument-hint` in frontmatter. Body focuses on process.

---

### Examples Showing Invocation

**Problem:**
```markdown
## Examples

/my-command file.py --verbose
/my-command src/ --recursive
```

**Why it's wrong:** Command already invoked. Show the WORK being done.

**Fix:**
```markdown
## Examples

### Analyzing a Python file

[Show actual analysis output, decisions made, etc.]
```

---

## Rule-Specific Anti-Patterns

### Missing paths: Frontmatter

**Problem:**
```yaml
---
# No paths specified
---

# My Rule

Guidelines for code...
```

**Why it's wrong:** Rule loads into EVERY context, bloating all conversations.

**Fix:**
```yaml
---
paths:
  - src/**/*.py
  - "!tests/**"
---
```

---

### Overly Broad Paths

**Problem:**
```yaml
paths:
  - "**/*"
```

**Why it's wrong:** Matches everything. Same as no paths.

**Fix:** Scope to specific file types or directories that actually need the rule.

---

### Philosophical Content

**Problem:**
```markdown
# Code Quality

Good code is like poetry. It should flow naturally and express
intent clearly. When writing code, consider the reader...
```

**Why it's wrong:** Not actionable. Wastes context on philosophy.

**Fix:** Provide concrete patterns, examples, anti-patterns with fixes.

---

## Quick Reference

| Anti-Pattern | Type | Fix |
|--------------|------|-----|
| Usage section | All | Remove, start with instructions |
| "When to Use" in body | Skill | Move to description |
| "Triggers" section | Skill | Put triggers in description |
| Mixed languages | All | Pick one language |
| Extra docs (README, etc.) | All | Delete auxiliary files |
| Nested references | Skill | Flatten to one level |
| Vague description | Skill | Add specific trigger terms |
| Invalid frontmatter | Skill | Use only allowed fields |
| >500 lines SKILL.md | Skill | Split to references/ |
| Args docs in body | Command | Use argument-hint |
| Invocation examples | Command | Show work being done |
| Missing paths: | Rule | Always add paths: |
| Broad paths (**/*) | Rule | Scope to specific patterns |
| Philosophy over action | Rule | Provide concrete patterns |
