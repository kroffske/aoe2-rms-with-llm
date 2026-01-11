---
description: claude code create agents with role analysis and model tier selection.
argument-hint: agent role or description
---

# /cc-create:agent — Claude Code Agent Creator

Creates Claude Code agents with proper structure and model tier selection.

## Documentation

**Activate `skill-creator` skill** for agents anatomy and best practices.
See: `.claude/skills/skill-creator/SKILL.md`

---

## Goal

Create an agent that:
1. Has proper frontmatter (name, model, description)
2. Has clear specialization and role
3. Uses correct model tier (haiku/sonnet/opus)

---

## Process

```
Your Request
    │
    ▼
┌─────────────────────────────────────────────────────┐
│ Phase 1: ANALYSIS                                   │
│ • Define agent's role and specialization            │
│ • Check existing agents for overlap                 │
│ • Determine model tier (haiku/sonnet/opus)          │
├─────────────────────────────────────────────────────┤
│ Phase 2: DESIGN                                     │
│ • Define "When to Use" / "When NOT to Use"          │
│ • Structure behavior and output format              │
├─────────────────────────────────────────────────────┤
│ Phase 3: GENERATION                                 │
│ • Write agent.md with proper frontmatter            │
│ • Include clear examples                            │
└─────────────────────────────────────────────────────┘
```

---

## Agent File Structure

Agents live in `.claude/agents/`:

**Frontmatter (required):**

| Field | Value |
|-------|-------|
| name | agent-name |
| model | opus / sonnet / haiku |
| description | What this agent does. Use for X, Y, Z. |

**Body sections:**

| Section | Purpose |
|---------|---------|
| When to Use | Trigger conditions |
| When NOT to Use | Anti-triggers |
| Behavior | Step-by-step process |
| Output Format | Expected output structure |
| Rules | Constraints and guidelines |

---

## Model Selection

| Model | Use When |
|-------|----------|
| haiku | Speed critical, simple tasks |
| sonnet | Balanced speed/quality |
| opus | Quality critical, complex reasoning |

---

## Existing Agents

Check before creating duplicates:

| Agent | Role |
|-------|------|
| scout-haiku | Fast exploration |
| implementer-opus | Implementation |
| reviewer-opus | Code review |
| architect | Architecture analysis |
| planner-opus | Strategic planning |

---

## Verification

After creation:
- [ ] File is in `.claude/agents/`
- [ ] Frontmatter has: name, model, description
- [ ] Has "When to Use" and "When NOT to Use"
- [ ] Has Behavior steps and Output Format

---

## Related

| Command | Purpose |
|---------|---------|
| `/cc-create:new-skill` | Create Claude Code skills |
| `/cc-create:command` | Create Claude Code commands |
