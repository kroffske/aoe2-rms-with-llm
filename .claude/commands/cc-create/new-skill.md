---
description: Creates Claude Code skills with deep multi-lens analysis and multi-agent synthesis panel. Use for "create skill", "создай скилл".
argument-hint: <skill goal or description>
---

# /cc-create:new-skill — Claude Code Skill Creator

Создаёт Claude Code skills с глубоким анализом и multi-agent синтезом.

## Documentation

**Activate `skill-creator` skill** for skills anatomy, frontmatter, and best practices.
See: `.claude/skills/skill-creator/references/skills-checklist.md`

---

## Цель

Создать SKILL.md который:
1. Соответствует официальной спецификации Claude Code
2. Имеет правильный frontmatter
3. Содержит чёткие инструкции для Claude
4. Продуман через 11 линз анализа
5. Проверен multi-agent panel

## Process Overview

```
Your Request
    │
    ▼
┌─────────────────────────────────────────────────────┐
│ Phase 1: DEEP ANALYSIS                              │
│ • Expand requirements (explicit, implicit, unknown) │
│ • Apply 11 thinking models + Automation Lens        │
│ • Question until no new insights (3 empty rounds)   │
│ • Identify automation/script opportunities          │
├─────────────────────────────────────────────────────┤
│ Phase 2: SPECIFICATION                              │
│ • Generate XML spec with all decisions + WHY        │
│ • Include scripts section (if applicable)           │
│ • Validate timelessness score ≥ 7                   │
├─────────────────────────────────────────────────────┤
│ Phase 3: GENERATION                                 │
│ • Write SKILL.md with fresh context                 │
│ • Generate references/, assets/, and scripts/       │
├─────────────────────────────────────────────────────┤
│ Phase 4: SYNTHESIS PANEL                            │
│ • 3-4 Opus agents review independently              │
│ • Script Agent added when scripts present           │
│ • All agents must approve (unanimous)               │
│ • If rejected → loop back with feedback             │
└─────────────────────────────────────────────────────┘
    │
    ▼
Production-Ready Agentic Skill
```

**Key principles:**
- Evolution/timelessness is the core lens (score ≥ 7 required)
- Every decision includes WHY
- Zero tolerance for errors
- Autonomous execution at maximum depth
- Scripts enable self-verification and agentic operation

---

## Frontmatter Requirements

**Source:** `.claude/skills/skill-creator/references/skills-checklist.md`

Skills must use ONLY these allowed frontmatter properties:

| Property | Required | Description |
|----------|----------|-------------|
| `name` | Yes | Lowercase, hyphens, numbers only. Max 64 chars. Should match directory name. |
| `description` | Yes | What skill does + when to use it. Max 1024 chars, no `<` or `>`. **This is how Claude decides when to use the skill!** |
| `allowed-tools` | No | Restrict which tools Claude can use when skill is active |
| `model` | No | Model to use (e.g., `claude-sonnet-4-20250514`) |

**Пример правильного frontmatter:**

```yaml
---
name: my-skill
description: Does X and Y. Use when user asks about Z or mentions "keyword1", "keyword2".
allowed-tools: Read, Grep, Glob
---
```

**НЕ ИСПОЛЬЗУЙ:** `license`, `metadata`, `version` — это НЕ валидные поля!

---

## Skill Output Structure

```
~/.claude/skills/{skill-name}/
├── SKILL.md                    # Main entry point (required)
├── references/                 # Deep documentation (optional)
│   ├── patterns.md
│   └── examples.md
├── assets/                     # Templates (optional)
│   └── templates/
└── scripts/                    # Automation scripts (optional)
    ├── validate.py             # Validation/verification
    ├── generate.py             # Artifact generation
    └── state.py                # State management
```

---

## Anti-Patterns

| Avoid | Why | Instead |
|-------|-----|---------|
| Duplicate skills | Bloats registry | Check existing first |
| Vague description | Claude can't match requests | Include specific trigger words in description |
| Invalid frontmatter | Won't load | Use ONLY: name, description, allowed-tools, model |
| "Triggers" section | Skills don't have triggers | Description IS the trigger mechanism |
| Over-engineering | Complexity without value | Start simple, keep SKILL.md < 500 lines |
| Missing use cases | Hard to discover | Description answers: what does it do + when to use |

---

## Verification Checklist

After creation:

- [ ] Frontmatter has ONLY: `name`, `description`, `allowed-tools` (opt), `model` (opt)
- [ ] Name is lowercase, hyphens only, ≤64 chars, matches directory
- [ ] Description ≤1024 chars, no `<` or `>`, includes trigger words
- [ ] Description answers: "What does it do?" + "When to use?"
- [ ] No "Triggers" section (description IS the trigger)
- [ ] SKILL.md < 500 lines (use references/ for details)

---

<details>
<summary><strong>Deep Dive: Phase 1 - Analysis</strong></summary>

### 1A: Input Expansion

Transform user's goal into comprehensive requirements:

```
USER INPUT: "Create a skill for X"
                │
                ▼
┌─────────────────────────────────────────────────────────┐
│ EXPLICIT REQUIREMENTS                                    │
│ • What the user literally asked for                      │
│ • Direct functionality stated                            │
├─────────────────────────────────────────────────────────┤
│ IMPLICIT REQUIREMENTS                                    │
│ • What they probably expect but didn't say               │
│ • Standard quality expectations                          │
│ • Integration with existing patterns                     │
├─────────────────────────────────────────────────────────┤
│ UNKNOWN UNKNOWNS                                         │
│ • What they don't know they need                         │
│ • Expert-level considerations they'd miss                │
│ • Future needs they haven't anticipated                  │
├─────────────────────────────────────────────────────────┤
│ DOMAIN CONTEXT                                           │
│ • Related skills that exist                              │
│ • Patterns from similar skills                           │
│ • Lessons from skill failures                            │
└─────────────────────────────────────────────────────────┘
```

**Check for overlap with existing skills:**
```bash
ls ~/.claude/skills/
# Grep for similar triggers in existing SKILL.md files
```

| Match Score | Action |
|-------------|--------|
| >7/10 | Use existing skill instead |
| 5-7/10 | Clarify distinction before proceeding |
| <5/10 | Proceed with new skill |

### 1B: Multi-Lens Analysis

Apply all 11 thinking models systematically:

| Lens | Core Question | Application |
|------|---------------|-------------|
| **First Principles** | What's fundamentally needed? | Strip convention, find core |
| **Inversion** | What guarantees failure? | Build anti-patterns |
| **Second-Order** | What happens after the obvious? | Map downstream effects |
| **Pre-Mortem** | Why did this fail? | Proactive risk mitigation |
| **Systems Thinking** | How do parts interact? | Integration mapping |
| **Devil's Advocate** | Strongest counter-argument? | Challenge every decision |
| **Constraints** | What's truly fixed? | Separate real from assumed |
| **Pareto** | Which 20% delivers 80%? | Focus on high-value features |
| **Root Cause** | Why is this needed? (5 Whys) | Address cause not symptom |
| **Comparative** | How do options compare? | Weighted decision matrix |
| **Opportunity Cost** | What are we giving up? | Explicit trade-offs |

**Minimum requirement:** All 11 lenses scanned, at least 5 applied in depth.

### 1C: Regression Questioning

Iterative self-questioning until no new insights emerge:

```
ROUND N:
│
├── "What am I missing?"
├── "What would an expert in {domain} add?"
├── "What would make this fail?"
├── "What will this look like in 2 years?"
├── "What's the weakest part of this design?"
└── "Which thinking model haven't I applied?"
    │
    └── New insights > 0?
        │
        ├── YES → Incorporate and loop
        └── NO → Check termination criteria
```

**Termination Criteria:**
- Three consecutive rounds produce no new insights
- All 11 thinking models have been applied
- At least 3 simulated expert perspectives considered
- Evolution/timelessness explicitly evaluated
- Automation opportunities identified

### 1D: Automation Analysis

Identify opportunities for scripts that enable agentic operation:

```
FOR EACH operation in the skill:
│
├── Is this operation repeatable?
│   └── YES → Consider generation script
│
├── Does this produce verifiable output?
│   └── YES → Consider validation script
│
├── Does this need state across sessions?
│   └── YES → Consider state management script
│
├── Does this involve external tools?
│   └── YES → Consider integration script
│
└── Can Claude verify success autonomously?
    └── NO → Add self-verification script
```

</details>

<details>
<summary><strong>Deep Dive: Phase 2 - Specification</strong></summary>

### Specification Structure

The specification captures all analysis insights in XML format:

```xml
<skill_specification>
  <metadata>
    <name>skill-name</name>
    <analysis_iterations>N</analysis_iterations>
    <timelessness_score>X/10</timelessness_score>
  </metadata>

  <context>
    <problem_statement>What + Why + Who</problem_statement>
    <existing_landscape>Related skills, distinctiveness</existing_landscape>
  </context>

  <requirements>
    <explicit>What user asked for</explicit>
    <implicit>Expected but unstated</implicit>
    <discovered>Found through analysis</discovered>
  </requirements>

  <architecture>
    <pattern>Selected pattern with WHY</pattern>
    <phases>Ordered phases with verification</phases>
    <decision_points>Branches and defaults</decision_points>
  </architecture>

  <scripts>
    <decision_summary>needs_scripts + rationale</decision_summary>
    <script_inventory>name, category, purpose, patterns</script_inventory>
    <agentic_capabilities>autonomous, self-verify, recovery</agentic_capabilities>
  </scripts>

  <evolution_analysis>
    <timelessness_score>X/10</timelessness_score>
    <extension_points>Where skill can grow</extension_points>
    <obsolescence_triggers>What would break it</obsolescence_triggers>
  </evolution_analysis>

  <anti_patterns>
    <pattern>What to avoid + WHY + alternative</pattern>
  </anti_patterns>

  <success_criteria>
    <criterion>Measurable + verification method</criterion>
  </success_criteria>
</skill_specification>
```

### Specification Validation

Before proceeding to Phase 3:

- [ ] All sections present with no placeholders
- [ ] Every decision includes WHY
- [ ] Timelessness score ≥ 7 with justification
- [ ] At least 2 extension points documented
- [ ] All requirements traceable to source
- [ ] Scripts section complete (if applicable)
- [ ] Agentic capabilities documented (if scripts present)

</details>

<details>
<summary><strong>Deep Dive: Phase 3 - Generation</strong></summary>

**Context:** Fresh, clean (no analysis artifacts polluting)
**Standard:** Zero errors—every section verified before proceeding

### Generation Order

```
1. Create directory structure
   mkdir -p ~/.claude/skills/{skill-name}/references
   mkdir -p ~/.claude/skills/{skill-name}/assets/templates
   mkdir -p ~/.claude/skills/{skill-name}/scripts  # if scripts needed

2. Write SKILL.md
   • Frontmatter (YAML - allowed properties only)
   • Title and brief intro
   • Quick Start section
   • Quick Reference table
   • How It Works overview
   • Commands
   • Scripts section (if applicable)
   • Validation section
   • Anti-Patterns
   • Verification criteria
   • Deep Dive sections (in <details> tags)

3. Generate reference documents (if needed)
   • Deep documentation for complex topics
   • Templates for generated artifacts
   • Checklists for validation

4. Create assets (if needed)
   • Templates for skill outputs

5. Create scripts (if needed)
   • Include Result dataclass pattern
   • Add self-verification
   • Document exit codes
   • Test before finalizing
```

### Quality Checks During Generation

| Check | Requirement |
|-------|-------------|
| Frontmatter | Only allowed properties (name, description, allowed-tools, model) |
| Name | Hyphen-case, ≤64 chars |
| Description | ≤1024 chars, no angle brackets |
| Phases | 1-3 max, not over-engineered |
| Verification | Concrete, measurable |
| Tables over prose | Structured information in tables |
| No placeholder text | Every section fully written |
| Scripts (if present) | Shebang, docstring, argparse, exit codes, Result pattern |
| Script docs | Scripts section in SKILL.md with usage examples |

</details>

<details>
<summary><strong>Deep Dive: Phase 4 - Multi-Agent Synthesis</strong></summary>

**Panel:** 3-4 Opus agents with distinct evaluative lenses
**Requirement:** Unanimous approval (all agents)
**Fallback:** Return to Phase 1 with feedback (max 5 iterations)

### Panel Composition

| Agent | Focus | Key Criteria | When Active |
|-------|-------|--------------|-------------|
| **Design/Architecture** | Structure, patterns, correctness | Pattern appropriate, phases logical, no circular deps | Always |
| **Audience/Usability** | Clarity, discoverability, completeness | Triggers natural, steps unambiguous, no assumed knowledge | Always |
| **Evolution/Timelessness** | Future-proofing, extension, ecosystem | Score ≥7, extension points clear, ecosystem fit | Always |
| **Script/Automation** | Agentic capability, verification, quality | Scripts follow patterns, self-verify, documented | When scripts present |

### Script Agent (Conditional)

The Script Agent is activated when the skill includes a `scripts/` directory. Focus areas:

| Criterion | Checks |
|-----------|--------|
| **Pattern Compliance** | Result dataclass, argparse, exit codes |
| **Self-Verification** | Scripts can verify their own output |
| **Error Handling** | Graceful failures, actionable messages |
| **Documentation** | Usage examples in SKILL.md |
| **Agentic Capability** | Can run autonomously without human intervention |

**Script Agent Scoring:**

| Score | Meaning |
|-------|---------|
| 8-10 | Fully agentic, self-verifying, production-ready |
| 6-7 | Functional but missing some agentic capabilities |
| <6 | Requires revision - insufficient automation quality |

### Agent Evaluation

Each agent produces:

```markdown
## [Agent] Review

### Verdict: APPROVED / CHANGES_REQUIRED

### Scores
| Criterion | Score (1-10) | Notes |
|-----------|--------------|-------|

### Strengths
1. [Specific with evidence]

### Issues (if CHANGES_REQUIRED)
| Issue | Severity | Required Change |
|-------|----------|-----------------|

### Recommendations
1. [Even if approved]
```

### Consensus Protocol

```
IF all agents APPROVED (3/3 or 4/4):
    → Finalize skill
    → Update registry
    → Complete

ELSE:
    → Collect all issues (including script issues)
    → Return to Phase 1 with issues as input
    → Re-apply targeted questioning
    → Regenerate skill and scripts
    → Re-submit to panel

IF 5 iterations without consensus:
    → Flag for human review
    → Present all agent perspectives
    → User makes final decision
```

</details>

<details>
<summary><strong>Deep Dive: Evolution/Timelessness</strong></summary>

Every skill is evaluated through the evolution lens:

### Temporal Projection

| Timeframe | Key Question |
|-----------|--------------|
| 6 months | How will usage patterns evolve? |
| 1 year | What ecosystem changes are likely? |
| 2 years | What new capabilities might obsolete this? |
| 5 years | Is the core problem still relevant? |

### Timelessness Scoring

| Score | Description | Verdict |
|-------|-------------|---------|
| 1-3 | Transient, will be obsolete in months | Reject |
| 4-6 | Moderate, depends on current tooling | Revise |
| **7-8** | **Solid, principle-based, extensible** | **Approve** |
| 9-10 | Timeless, addresses fundamental problem | Exemplary |

**Requirement:** All skills must score ≥7.

### Anti-Obsolescence Patterns

| Do | Don't |
|----|-------|
| Design around principles | Hardcode implementations |
| Document the WHY | Only document the WHAT |
| Include extension points | Create closed systems |
| Abstract volatile dependencies | Direct coupling |
| Version-agnostic patterns | Pin specific versions |

</details>

<details>
<summary><strong>Architecture Pattern Selection</strong></summary>

Select based on task complexity:

| Pattern | Use When | Structure |
|---------|----------|-----------|
| **Single-Phase** | Simple linear tasks | Steps 1-2-3 |
| **Checklist** | Quality/compliance audits | Item verification |
| **Generator** | Creating artifacts | Input → Transform → Output |
| **Multi-Phase** | Complex ordered workflows | Phase 1 → Phase 2 → Phase 3 |
| **Multi-Agent Parallel** | Independent subtasks | Launch agents concurrently |
| **Multi-Agent Sequential** | Dependent subtasks | Agent 1 → Agent 2 → Agent 3 |
| **Orchestrator** | Coordinating multiple skills | Meta-skill chains |

### Selection Decision Tree

```
Is it a simple procedure?
├── Yes → Single-Phase
└── No → Does it produce artifacts?
    ├── Yes → Generator
    └── No → Does it verify/audit?
        ├── Yes → Checklist
        └── No → Are subtasks independent?
            ├── Yes → Multi-Agent Parallel
            └── No → Multi-Agent Sequential or Multi-Phase
```

</details>

<details>
<summary><strong>Configuration</strong></summary>

```yaml
CC_SKILL_CONFIG:
  mode: autonomous
  depth: maximum  # always
  core_lens: evolution_timelessness

  analysis:
    min_lens_depth: 5
    max_questioning_rounds: 7
    termination_empty_rounds: 3

  synthesis:
    panel_size: 3
    require_unanimous: true
    max_iterations: 5
    escalate_to_human: true

  evolution:
    min_timelessness_score: 7
    min_extension_points: 2
    require_temporal_projection: true

  model:
    primary: claude-opus-4-5-20251101
    subagents: claude-opus-4-5-20251101
```

</details>

---

## Related Commands

| Command | Purpose |
|---------|---------|
| `/cc-create:command` | Create Claude Code commands |
| `/cc-create:agent` | Create Claude Code agents |
