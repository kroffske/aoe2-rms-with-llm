---
name: research
description: Structured research with dynamic agent orchestration. Use for feasibility studies, A vs B comparisons, deep investigations, technical spikes. Triggers on "исследуй", "сравни", "should we", "стоит ли", "как работает".
---

# Skill: Research

> 🔬 **Reduce uncertainty before technical decisions** through structured multi-agent research.

## Activation

When used, announce:
> **Research**: assessing complexity for "{topic}"

## When to Use

- Feasibility: "стоит ли делать X?"
- Comparison: "A vs B?"
- Deep dive: "как работает X?"
- Technical spike before implementation

---

## Non-Negotiables (Final Report)

1. **Single final report** in `docs/research/<topic>/README.md` that consolidates the key findings.
2. **One folder per research**: all report materials live under `docs/research/<topic>/`.
3. **Figures embedded** in the report; store files in `docs/research/<topic>/figures/` and link with relative paths.
4. **Artifacts are summarized, not just linked**: the report must restate the core findings.
5. **Clear navigation**: start with "How to read" and a short roadmap.

## Research Folder Structure

```
docs/research/<topic>/
├── README.md          # Final report (entry point)
├── figures/           # Images referenced by README.md
├── appendix.md        # Optional deep detail
└── artifacts/         # Optional extra tables or exports
```

## Language

Write the final report in the user's language. If the user requests Russian, produce Russian output; otherwise follow the project's default language.

## ML/DS-Specific Requirements (when applicable)

- **Model**: name, version, training setup, and key hyperparameters.
- **Metric(s)**: primary metric, any secondary metrics, and why they matter.
- **Validation**: holdout vs cross-validation (k-fold details); call out if missing.
- **Feature groups**: split by origin (e.g., engineered/technical vs generated/LAMP/LLM).
- **Delta vs baseline**: absolute and relative improvement, plus confidence notes.

---

## Agent Orchestration

**This is the core of research skill** — coordinating multiple agents to gather perspectives while preserving context.

### Why Context Matters

Each agent needs full research context to provide relevant findings:
- **Without context**: agent explores randomly, misses scope
- **With context**: agent focuses on relevant areas, builds on previous findings

Context flows: `Question → Agent 1 findings → Agent 2 (with Agent 1 context) → Synthesis`

### Agent Selection by Complexity

| Complexity | Agents | Strategy |
|------------|--------|----------|
| 1-3 | 1 | scout-haiku only |
| 4-5 | 2 | scout-haiku + expert OR architect |
| 6-7 | 3 | scout-haiku + architect + expert |
| 8-10 | 4-5 | All + agent-opus for synthesis |

| Agent | Role | When Selected |
|-------|------|---------------|
| `scout-haiku` | Codebase exploration | Always (internal questions) |
| `architect` | Architecture analysis | complexity ≥ 5 OR design decisions |
| `expert` | Feasibility assessment | complexity ≥ 4 OR risk assessment |
| `agent-opus` | Deep synthesis | complexity ≥ 7 OR conflict resolution |
| `WebSearch` | External research | External libraries/tools |

### Parallelization Patterns

**PARALLEL** (independent perspectives, no dependency):
```
┌─────────────────┐     ┌─────────────────┐
│   scout-haiku   │     │    architect    │
│   (codebase)    │     │    (design)     │
└────────┬────────┘     └────────┬────────┘
         │                       │
         └───────────┬───────────┘
                     ▼
              [Combine findings]
```

When to use parallel:
- Architecture + Feasibility (different angles)
- External research + Codebase exploration
- Multiple independent questions

**SEQUENTIAL** (findings inform next step):
```
scout-haiku (codebase)
         │
         ▼ [findings]
    architect (design, using codebase findings)
         │
         ▼ [design proposals]
      expert (feasibility, using all above)
         │
         ▼ [verdict]
    agent-opus (synthesis, resolving conflicts)
```

When to use sequential:
- Codebase → Architecture (findings inform design)
- All perspectives → Synthesis (needs all inputs)
- When later agent needs earlier findings

### Context Passing Template

**CRITICAL**: Every agent must receive full research context.

```markdown
**Research Context:**
- Question: {original question}
- Scope IN: {what to research}
- Scope OUT: {what NOT to research}
- Your role: {perspective}
- Previous findings: {summary of earlier agent outputs}

**Task:**
{perspective-specific instructions}

**Output Format:**
## {Perspective} Findings

### Key Points
1. ...

### Evidence
- `file:line` — description

### Confidence: X%
### Gaps: {what's still unclear}
```

### Perspective-Specific Prompts

**Codebase (scout-haiku):**
```
Find existing patterns, relevant code, affected modules.
Thoroughness: {quick|medium|very thorough based on complexity}
```

**Architecture (architect):**
```
Analyze design implications, propose approaches, identify trade-offs.
Consider existing architecture in: {codebase findings}
```

**Feasibility (expert):**
```
Assess DO/DON'T, identify risks, suggest alternatives.
Verdict format: DO / DON'T / PARTIAL with rationale.
```

**Synthesis (agent-opus):**
```
Combine all perspectives, resolve conflicts, generate final verdict.
Previous findings: {all agent outputs}
```

### Iteration Control

Research is iterative. Each iteration adds perspectives or depth.

**Confidence Thresholds:**

| Mode | Threshold | Meaning |
|------|-----------|---------|
| quick | 60% | "Probably right, minor risk" |
| standard | 75% | "Confident, edge cases covered" |
| deep | 85% | "Very confident, risks mitigated" |

**Termination Conditions** — stop when ANY is true:
1. **Confidence ≥ threshold** — sufficient certainty
2. **Max iterations reached** — resource limit (3 for deep)
3. **Diminishing returns** — <10% new insights vs previous iteration

**Iteration Example:**
```
Iteration 1:
  - Scout: found 3 relevant patterns
  - Architect: proposes 2 approaches
  - Confidence: 55% (need feasibility input)

Iteration 2:
  - Expert: Approach A has risk X, Approach B is safer
  - Confidence: 80% (above 75% threshold)
  → STOP, conclude with Approach B
```

### Conflict Resolution

When agents disagree:

1. **State the conflict** explicitly
2. **Weight by expertise**:
   - Architect wins on design questions
   - Expert wins on risk assessment
   - Scout wins on codebase facts
3. **Consider evidence quality** — code examples > opinions
4. **Default to conservative** — if uncertain, don't proceed

---

## Process Overview

```
Question → ASSESS → GATHER → SYNTHESIZE → FINALIZE → COMMIT
```

### Phase 1: ASSESS

1. Parse question — identify what's being asked
2. Score complexity (1-10) on 4 dimensions:
   - **Scope** (30%): single module → system-wide
   - **Uncertainty** (30%): known patterns → novel problem
   - **Risk** (25%): reversible → high stakes
   - **Dependencies** (15%): isolated → wide-reaching
3. Select mode: quick (1-3) / standard (4-6) / deep (7-10)
4. Plan agents: which agents, parallel vs sequential
5. Lock scope: explicit IN/OUT boundaries

**Output:** See `.claude/skills/research/templates/complexity-report.md`

### Phase 2: GATHER

1. Spawn agents according to plan (parallel where possible)
2. Pass context to each agent (use template above)
3. Collect findings from each perspective
4. Assess confidence — do we have enough?
5. Iterate if needed — spawn additional agents

### Phase 3: SYNTHESIZE

1. Aggregate findings from all perspectives
2. Resolve conflicts (use rules above)
3. Generate verdict: DO / DON'T / PARTIAL
4. State confidence percentage
5. List key findings, risks, next steps

**Output:** See `.claude/skills/research/templates/executive-summary.md`

### Phase 4: FINALIZE

1. Assemble the final report in `docs/research/<topic>/README.md` using the template.
2. Consolidate all key findings from artifacts into the report (no orphan findings).
3. Move/copy figures into `docs/research/<topic>/figures/` and embed them in the report.
4. Fill ML/DS sections when applicable (model, metrics, validation, feature groups).
5. Add `appendix.md` or `artifacts/` only for supporting detail.
6. Quality check — run doc-haiku to review.
7. Create or update `docs/research/README.md` — add navigation.
8. Create or update `docs/research/CHANGELOG.md` — record addition.

### Phase 5: COMMIT

```bash
git add docs/research/
git commit -m "docs(research): <topic> — <verdict> (<confidence>%)"
```

---

## Depth Modes

| Mode | Complexity | Agents | Output |
|------|------------|--------|--------|
| **quick** | 1-3 | 1 | Verdict in response only |
| **standard** | 4-6 | 2-3 | `docs/research/<topic>/README.md` (+ optional appendix) |
| **deep** | 7-10 | 4-5 | Full folder with report, figures, appendix |

**How to request explicitly:**
- quick: "быстро оцени", "коротко"
- standard: (default)
- deep: "глубоко исследуй", "детально"
- with POC: "с прототипом", "проверь кодом"

---

## Artifacts

| Type | Location |
|------|----------|
| Working drafts | `tasks/.../artifacts/draft.md` |
| Raw agent output | `tasks/.../artifacts/raw/` |
| Figures | `docs/research/<topic>/figures/` |
| **Final report** | `docs/research/<topic>/README.md` |
| Supporting detail | `docs/research/<topic>/appendix.md` or `docs/research/<topic>/artifacts/` |

**Rule**: Published research → `docs/research/`. Working files → epic `artifacts/`.

## Templates

Read from `.claude/skills/research/templates/` when creating output:
- `.claude/skills/research/templates/final-report.md` — final report template (README.md)
- `.claude/skills/research/templates/executive-summary.md` — verdict + deliverables
- `.claude/skills/research/templates/analysis.md` — detailed findings (deep mode)
- `.claude/skills/research/templates/complexity-report.md` — scoring rationale

---

## Examples

### Quick (Complexity 2)

```
User: "Should we use pathlib instead of os.path?"

Complexity: 2/10 (standard Python, low risk)
Mode: quick
Agent: scout-haiku only

Findings: Codebase already uses pathlib in 80% of cases.

Verdict: DO (90% confidence)
- Pathlib is already standard
- Type hints work better
- No migration needed
```

### Standard (Complexity 5)

```
User: "Should we add caching to embedding provider?"

Complexity: 5/10 (multiple modules, moderate risk)
Mode: standard
Agents:
  - scout-haiku + architect (PARALLEL)
  - expert (SEQUENTIAL after above)

Iteration 1:
  Scout: Found existing cache pattern in cache/embeddings.py
  Architect: Proposes extending existing pattern
  Confidence: 60%

Iteration 2:
  Expert: DO with LRU eviction, monitor memory
  Confidence: 80%

Verdict: DO (80% confidence)
Output: docs/research/caching/README.md
```

### Deep (Complexity 8)

```
User: "Should we replace LanceDB with Qdrant?"

Complexity: 8/10 (system-wide, high risk, novel)
Mode: deep
Agents: scout-haiku → architect → expert → agent-opus + WebSearch

Iteration 1:
  Scout + WebSearch (PARALLEL): patterns + external comparison
  Confidence: 55%

Iteration 2:
  Architect: impact analysis, 2 approaches
  Confidence: 65%

Iteration 3:
  Expert: Approach A risky, Approach B safer but slower
  agent-opus: Synthesize, resolve conflict
  Confidence: 85%

Verdict: PARTIAL (85% confidence)
- Qdrant has better filtering, but migration is 2 weeks
- Recommend: Keep LanceDB for v1, plan migration for v2

Output: Full folder at docs/research/storage/lancedb-vs-qdrant/
```

---

## Anti-Patterns

| Avoid | Why | Instead |
|-------|-----|---------|
| Skip context passing | Agents explore randomly | Always use context template |
| Always parallel | Lose sequential insights | Match pattern to dependency |
| Infinite iterations | Never concludes | Use termination conditions |
| Skip synthesis | Conflicting findings confuse | Always resolve conflicts |
| Raw notes in docs/ | Clutters research folder | Keep in epic artifacts/ |

---

## See Also

### Orchestration Patterns

This skill uses the following patterns:

Use agen-opus for almost any required task. 

**Handoff**: Agents communicate via artifacts in epic folder. Coordinator (this skill) orchestrates, specialists execute. See `.claude/skills/handoff/SKILL.md`.

**WORKLOG**: Append-only session history at `tasks/YYYY-MM-DD-slug/WORKLOG.md`.
