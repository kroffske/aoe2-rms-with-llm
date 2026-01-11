---
name: skill-creator
description: |
  Guide for creating skills, commands, and rules in Claude Code.
  Use when: creating new skill, command not triggering, rule not loading,
  frontmatter syntax, skill structure, progressive disclosure, "create skill",
  "create command", "create rule", skill anatomy, command anatomy.
---

# Skill Creator

Guide for creating effective skills, commands, and rules in Claude Code.

## Core Principles

### Concise is Key

The context window is a shared resource. Skills share it with system prompt, conversation history, other skills' metadata, and user requests.

**Default assumption: Claude is already smart.** Only add context Claude doesn't already have.

Challenge each piece: "Does Claude really need this?" and "Does this justify its token cost?"

Prefer concise examples over verbose explanations.

### Set Appropriate Degrees of Freedom

Match specificity to task fragility:

| Freedom | Use When | Format |
|---------|----------|--------|
| **High** | Multiple approaches valid, context-dependent | Text instructions |
| **Medium** | Preferred pattern exists, some variation OK | Pseudocode, scripts with params |
| **Low** | Fragile operations, consistency critical | Specific scripts, few params |

Think of Claude exploring a path: narrow bridge needs guardrails (low freedom), open field allows many routes (high freedom).

### Progressive Disclosure

Three-level loading system:

| Level | When Loaded | Size Target |
|-------|-------------|-------------|
| **Metadata** (name + description) | Always in context | ~100 words |
| **SKILL.md body** | When skill triggers | <5k words, <500 lines |
| **references/** | When Claude needs details | Unlimited |

**Key rule:** Keep SKILL.md body under 500 lines. Split to references/ when approaching limit.

---

## Anatomy

### Skills

```
.claude/skills/{skill-name}/
├── SKILL.md              # Required: entry point
├── references/           # Optional: detailed docs
│   ├── patterns.md
│   └── examples.md
├── assets/               # Optional: templates, images
└── scripts/              # Optional: automation
```

**Frontmatter (YAML):**

| Property | Required | Description |
|----------|----------|-------------|
| `name` | Yes | Lowercase, hyphens, numbers. Max 64 chars. Match directory name. |
| `description` | Yes | What + when to use. Max 1024 chars. **This is how Claude decides to use the skill!** |
| `allowed-tools` | No | Restrict available tools |
| `model` | No | Model override (e.g., `claude-sonnet-4-20250514`) |

**Triggering:** Claude uses `description` for semantic matching. Include trigger terms!

See [skills-checklist.md](references/skills-checklist.md) for detailed checklist.

### Commands

```
.claude/commands/
├── my-command.md              # /my-command
└── category/
    ├── sub1.md                # /category:sub1
    └── sub2.md                # /category:sub2
```

**Frontmatter (YAML):**

| Property | Required | Description |
|----------|----------|-------------|
| `description` | Recommended | Brief description for autocomplete |
| `argument-hint` | No | Hint shown in autocomplete (e.g., `[file] [options]`) |
| `allowed-tools` | No | Restrict available tools |
| `model` | No | Model override |

**Invocation:** Explicit via `/command-name` or `/category:subcommand`.

See [commands-checklist.md](references/commands-checklist.md) for detailed checklist.

### Rules

```
.claude/rules/
├── python.md              # Scoped to paths
└── testing.md             # Scoped to paths
```

**Frontmatter (YAML):**

| Property | Required | Description |
|----------|----------|-------------|
| `paths` | **Yes** | Glob patterns for when to load. Without `paths:` = always loaded! |

**Example:**
```yaml
---
paths:
  - src/**/*.py
  - "!tests/**"      # Exclude pattern
---
```

See [rules-checklist.md](references/rules-checklist.md) for detailed checklist.

### Agents

```
.claude/agents/
├── implementer-opus.md    # Heavy implementation
├── scout-haiku.md         # Fast exploration
└── reviewer-opus.md       # Code review
```

**Frontmatter (YAML):**

| Property | Required | Description |
|----------|----------|-------------|
| `name` | Yes | Agent identifier |
| `model` | Yes | `opus`, `sonnet`, or `haiku` |
| `description` | Yes | What agent does + when to use. Include `<example>` for clarity. |
| `tools` | No | Available tools (default: all) |
| `skills` | No | Skills to preload |

**Model Selection:**

| Model | Use For |
|-------|---------|
| `opus` | Complex tasks, research, quality-critical |
| `sonnet` | Balanced speed/quality |
| `haiku` | Fast exploration, simple tasks |

---

## Quick Reference

### Syntax in Commands/Skills

| Syntax | Purpose | Example |
|--------|---------|---------|
| `$ARGUMENTS` | All arguments (can be 1000+ lines!) | `$ARGUMENTS` |
| `$1`, `$2` | Positional arguments | `$1` = first arg |
| `` !`cmd` `` | Bash injection (execute and insert) | `` !`git status` `` |
| `@path` | Include file contents | `@src/utils.py` |

### Project Structure

```
project/
├── CLAUDE.md              # Always loaded (core conventions)
└── .claude/
    ├── settings.json      # Permissions, hooks, MCP
    ├── settings.local.json # Local overrides (gitignored)
    ├── rules/             # Path-scoped rules
    ├── commands/          # Slash commands
    ├── skills/            # Model-invoked capabilities
    └── agents/            # Custom subagents
```

---

## What NOT to Include

A skill/command should only contain essential files. Do NOT create:

- README.md
- INSTALLATION_GUIDE.md
- QUICK_REFERENCE.md
- CHANGELOG.md

These add clutter. The skill contains information for Claude to do the job—not auxiliary context about creation process or user-facing documentation.

---

## Common Anti-Patterns

| Avoid | Why | Instead |
|-------|-----|---------|
| Usage section in body | Skill/command already invoked! | Start with instructions |
| "When to Use" in body | Body loads AFTER trigger | Put in frontmatter `description` |
| "Triggers" section | Skills don't have explicit triggers | Triggers ARE the description |
| Mixed languages | Confusing, inconsistent | Pick one: EN or RU |
| Examples of invoking | Already happened | Examples of DOING the task |
| Deeply nested refs | Hard to navigate | Max one level from SKILL.md |

See [anti-patterns.md](references/anti-patterns.md) for detailed examples.

---

## References

For detailed checklists and patterns:

- [skills-checklist.md](references/skills-checklist.md) — Skill creation checklist
- [commands-checklist.md](references/commands-checklist.md) — Command creation checklist
- [rules-checklist.md](references/rules-checklist.md) — Rule creation checklist
- [anti-patterns.md](references/anti-patterns.md) — Common mistakes with fixes

## External Resources

- https://docs.anthropic.com/en/docs/claude-code — Official Claude Code docs
- https://www.anthropic.com/engineering/claude-code-best-practices — Best practices blog
