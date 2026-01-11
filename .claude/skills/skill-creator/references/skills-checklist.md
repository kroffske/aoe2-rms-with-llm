# Skills Checklist

Detailed checklist for creating quality skills in Claude Code.

## Structure

```
.claude/skills/{skill-name}/
├── SKILL.md              # Required
├── references/           # Optional: docs loaded on-demand
├── assets/               # Optional: templates, images (not loaded to context)
└── scripts/              # Optional: executable code
```

## Frontmatter Checklist

### Required Fields

- [ ] `name` present
- [ ] `name` is lowercase, hyphens and numbers only
- [ ] `name` ≤ 64 characters
- [ ] `name` matches directory name
- [ ] `description` present
- [ ] `description` ≤ 1024 characters
- [ ] `description` has no `<` or `>` characters

### Description Quality

- [ ] Describes WHAT the skill does
- [ ] Describes WHEN to use it
- [ ] Includes trigger terms/keywords
- [ ] Covers common phrasings users might say

**Good example:**
```yaml
description: |
  Guide for creating skills, commands, and rules in Claude Code.
  Use when: creating new skill, command not triggering, rule not loading,
  frontmatter syntax, skill structure, "create skill", "create command".
```

**Bad example:**
```yaml
description: Helps with Claude Code stuff.
```

### Optional Fields

- [ ] `allowed-tools` — only if restricting tools makes sense
- [ ] `model` — only if specific model required

### Forbidden Fields

Do NOT use these — they are not valid:
- `license`
- `version`
- `metadata`
- `triggers`

## Body Checklist

### Content

- [ ] NO usage section (`/skill args` — already invoked!)
- [ ] NO "When to Use" section (belongs in description)
- [ ] NO examples of HOW to invoke
- [ ] Starts with instructions for WHAT TO DO
- [ ] Single language (EN or RU, not mixed)
- [ ] Uses imperative form ("Create...", "Run...", not "You should create...")

### Size

- [ ] SKILL.md < 500 lines
- [ ] Large content moved to references/
- [ ] References are one level deep (no nested folders)

### Structure

- [ ] Clear sections with headers
- [ ] Tables for structured information
- [ ] Code blocks for examples
- [ ] Links to references/ for details

## References Organization

### When to Use references/

- Documentation Claude should reference while working
- Detailed patterns, examples, schemas
- Content that would bloat SKILL.md

### Naming Conventions

| Pattern | Use For |
|---------|---------|
| `{topic}.md` | Single topic (patterns.md, examples.md) |
| `{domain}/` | Domain-specific (finance.md, sales.md) |
| `{variant}.md` | Framework variants (aws.md, gcp.md) |

### Guidelines

- [ ] Include table of contents if >100 lines
- [ ] Reference from SKILL.md with clear "when to read"
- [ ] No deeply nested structures
- [ ] Avoid duplication between SKILL.md and references

## Assets Organization

Assets are files NOT loaded into context, used in output:

- Templates (HTML, PPTX, etc.)
- Images, icons
- Boilerplate code
- Fonts

## Scripts Organization

Scripts for automation:

- [ ] Include shebang (`#!/usr/bin/env python3`)
- [ ] Include docstring with usage
- [ ] Use argparse for CLI
- [ ] Document exit codes
- [ ] Test before including

## Final Verification

- [ ] Skill triggers on expected phrases (test in conversation)
- [ ] Body provides clear actionable instructions
- [ ] No placeholder text remains
- [ ] All referenced files exist
- [ ] No auxiliary files (README, CHANGELOG)
