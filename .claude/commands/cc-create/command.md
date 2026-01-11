---
description: Creates Claude Code commands with analysis and multi-agent review. Use for "create command", "создай команду".
argument-hint: <command goal or description>
---

# /cc-create:command — Claude Code Command Creator

Создаёт Claude Code commands с глубоким анализом и multi-agent синтезом.

## Documentation

**Activate `skill-creator` skill** for commands anatomy, frontmatter, and best practices.
See: `.claude/skills/skill-creator/references/commands-checklist.md`

---

## Цель

Создать command который:
1. Соответствует официальной спецификации Claude Code
2. Имеет правильную структуру (markdown file)
3. Содержит чёткие инструкции для workflow
4. Продуман через multi-lens анализ
5. Проверен multi-agent panel

## Command vs Skill

| Аспект | Command | Skill |
|--------|---------|-------|
| Вызов | Явный (`/command`) | Неявный (по description) |
| Загрузка | On-demand | Каждую сессию (description) |
| Назначение | Workflows, procedures | Knowledge, protocols |
| Структура | Один .md файл | Папка с SKILL.md |

**Используй command когда:**
- Пользователь явно вызывает действие
- Это workflow/procedure
- Редко используется (не каждую сессию)

---

## Process Overview

```
Your Request
    │
    ▼
┌─────────────────────────────────────────────────────┐
│ Phase 1: ANALYSIS                                   │
│ • Understand the workflow user needs                │
│ • Check for existing similar commands               │
│ • Apply key thinking lenses                         │
│ • Identify agent orchestration needs                │
├─────────────────────────────────────────────────────┤
│ Phase 2: DESIGN                                     │
│ • Structure the command flow                        │
│ • Define phases and decision points                 │
│ • Plan agent usage (if complex)                     │
├─────────────────────────────────────────────────────┤
│ Phase 3: GENERATION                                 │
│ • Write command.md                                  │
│ • Include examples and edge cases                   │
├─────────────────────────────────────────────────────┤
│ Phase 4: SYNTHESIS PANEL                            │
│ • 2-3 Opus agents review independently              │
│ • All agents must approve (unanimous)               │
│ • If rejected → loop back with feedback             │
└─────────────────────────────────────────────────────┘
    │
    ▼
Production-Ready Command
```

---

## Command Structure

**Source:** `.claude/skills/skill-creator/references/commands-checklist.md`

Commands are markdown files in `.claude/commands/`:

```
.claude/commands/
├── my-command.md           # Simple command: /my-command
├── category/
│   ├── sub1.md             # Namespaced: /category:sub1
│   └── sub2.md             # Namespaced: /category:sub2
```

### Command File Format

```markdown
# /command-name — Brief Description

One-line description of what this command does.

## When to Use

- Trigger condition 1
- Trigger condition 2

## Process

1. Step one
2. Step two
3. Step three

## Examples

### Example 1: Basic Usage

```
/command-name arg1
```

## Edge Cases

- Handle case X by doing Y
```

---

## Anti-Patterns

| Avoid | Why | Instead |
|-------|-----|---------|
| Giant commands | Hard to maintain | Split into sub-commands |
| No examples | Users don't understand | Always include 2-3 examples |
| Implicit assumptions | Confusion | Document all assumptions |
| Duplicate commands | Bloat | Check existing first |
| Missing error handling | User frustration | Document edge cases |

---

## Verification Checklist

After creation:

- [ ] File is in `.claude/commands/` or subfolder
- [ ] Filename is lowercase, hyphens only
- [ ] Has clear "When to Use" section
- [ ] Has step-by-step Process
- [ ] Includes 2-3 examples
- [ ] Documents edge cases
- [ ] References related commands/skills

---

<details>
<summary><strong>Deep Dive: Phase 1 - Analysis</strong></summary>

### Understand the Workflow

| Question | Purpose |
|----------|---------|
| What triggers this command? | Define invocation pattern |
| What are the inputs? | Define parameters |
| What are the outputs? | Define success criteria |
| What can go wrong? | Define error handling |
| Who uses this? | Define audience |

### Check Existing Commands

```bash
ls .claude/commands/
# Check for similar functionality
```

| Match Score | Action |
|-------------|--------|
| >7/10 | Extend existing command |
| 5-7/10 | Clarify distinction |
| <5/10 | Proceed with new command |

### Key Lenses

Apply at minimum:

| Lens | Question |
|------|----------|
| **First Principles** | What's the core workflow? |
| **Inversion** | What would make this command useless? |
| **Pareto** | Which 20% delivers 80% value? |
| **User Journey** | What's the full experience? |

### Agent Orchestration Assessment

```
Is this a simple linear workflow?
├── Yes → No agents needed, simple command
└── No → Does it have independent subtasks?
    ├── Yes → Multi-agent parallel
    └── No → Are subtasks dependent?
        ├── Yes → Multi-agent sequential
        └── No → Single complex agent
```

</details>

<details>
<summary><strong>Deep Dive: Phase 2 - Design</strong></summary>

### Command Flow Structure

```
USER INVOKES /command
    │
    ▼
┌─────────────────────┐
│ Input Validation    │
│ - Check parameters  │
│ - Validate context  │
└─────────────────────┘
    │
    ▼
┌─────────────────────┐
│ Main Workflow       │
│ - Phase 1: ...      │
│ - Phase 2: ...      │
│ - Phase 3: ...      │
└─────────────────────┘
    │
    ▼
┌─────────────────────┐
│ Output/Completion   │
│ - Summary           │
│ - Next steps        │
└─────────────────────┘
```

### Decision Points

Document all branching:

```
IF condition A:
    → Path A actions
ELSE IF condition B:
    → Path B actions
ELSE:
    → Default path
```

### Agent Usage Patterns

| Pattern | When to Use |
|---------|-------------|
| No agents | Simple, linear workflow |
| Single agent | Complex but unified task |
| Parallel agents | Independent analysis |
| Sequential agents | Dependent steps |

</details>

<details>
<summary><strong>Deep Dive: Phase 4 - Synthesis Panel</strong></summary>

### Panel Composition (Commands)

| Agent | Focus |
|-------|-------|
| **Workflow/UX** | Is the flow intuitive? Clear steps? |
| **Completeness** | Are edge cases covered? Examples clear? |
| **Integration** | Does it fit with other commands/skills? |

### Consensus Protocol

```
IF all agents APPROVED (2/2 or 3/3):
    → Finalize command
    → Complete

ELSE:
    → Collect issues
    → Return to Phase 1
    → Re-design
    → Re-submit

IF 3 iterations without consensus:
    → Flag for human review
```

</details>

<details>
<summary><strong>Configuration</strong></summary>

```yaml
CC_COMMAND_CONFIG:
  mode: autonomous
  depth: standard  # less than skills

  analysis:
    min_lenses: 4
    check_existing: true

  synthesis:
    panel_size: 2
    require_unanimous: true
    max_iterations: 3

  model:
    primary: claude-opus-4-5-20251101
    subagents: claude-opus-4-5-20251101
```

</details>

---

## Related Commands

| Command | Purpose |
|---------|---------|
| `/cc-create:new-skill` | Create Claude Code skills |
| `/cc-create:agent` | Create Claude Code agents |
