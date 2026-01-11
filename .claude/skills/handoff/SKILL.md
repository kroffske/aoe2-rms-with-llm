---
name: handoff
version: 1.0.0
description: Agent communication protocol. Artifacts in epic folder, short summaries to coordinator, explicit handoff requests. Use for all agents that produce results or need to pass work to others.
license: MIT
model: claude-sonnet-4-20250514
metadata:
  domains: [orchestration, multi-agent, communication]
  type: protocol
---

# Handoff Protocol

Standard communication protocol for multi-agent workflows.

---

## Triggers

- `handoff` - Apply this protocol when returning results
- `artifact first` - Write detailed results to files
- `pass to agent` - Request delegation to another agent
- `agent result format` - Format for returning results

---

## Core Principle

**Agents don't talk to each other directly.** All communication flows through:
1. **Artifacts** — detailed results saved to `{epic_path}/artifacts/`
2. **Coordinator** — the agent/user who called you

```
Agent A ──(artifact)──> artifacts/
         ──(summary)──> Coordinator ──(delegates)──> Agent B
                                                        │
                                            reads artifacts/
```

---

## Process

### Phase 1: Do Work and Create Artifact

1. Complete your assigned task
2. Write detailed results to `{epic_path}/artifacts/{artifact-name}.md`
3. Include all decisions, code changes, findings in the artifact

### Phase 2: Append to WORKLOG.md

1. Append entry to `{epic_path}/WORKLOG.md`
2. Include: date, agent name, type, summary, status, files, artifact link
3. Use append-only format (never edit previous entries)

### Phase 3: Return Short Summary

1. Prepare response in Result format (see below)
2. Keep summary to 5-10 lines maximum
3. Reference artifact path for details

### Phase 4: Request Handoff (if needed)

1. Identify if another agent is required
2. Add explicit handoff request with agent name and task
3. Coordinator decides whether to delegate

---

## Protocol Rules

### CRITICAL: Never Write to Project Root

Before creating ANY file, verify the target path:
- **With epic context:** `{epic_path}/artifacts/{name}.md`
- **Research output:** `docs/research/<topic>/{name}.md`
- **NO epic, NO research context:** `.local/{name}.md` (gitignored scratch space)

**Forbidden patterns:**
```
Write("REPORT.md", ...)           # ← root = VIOLATION
Write("ANALYSIS.md", ...)         # ← root = VIOLATION
Write("RECONNAISSANCE_*.md", ...) # ← root = VIOLATION
```

---

### Rule 1: Write Artifacts, Return Summary

**DO:**
```
1. Do your work
2. Save detailed result to artifacts/{your-artifact}.md
3. Return SHORT summary to coordinator (5-10 lines max)
```

**DON'T:**
- Return full analysis in response (floods coordinator context)
- Skip artifact creation (loses detailed work)
- Assume coordinator will read artifact automatically

### Rule 2: Structured Return Format

Always return in this format:

```markdown
## Result

**Status:** DONE | PARTIAL | BLOCKED
**Epic:** {epic_path}
**Artifacts:**
- [{artifact-name}.md](./artifacts/{artifact-name}.md) — one-line description

**Summary:** 2-3 sentences about what was done/found.

**Next:** Recommended next step.

**Handoff:** (optional) Request for coordinator
```

### Rule 3: Explicit Handoff Requests

When you need another agent's involvement, **ask the coordinator**:

```markdown
**Handoff:**
- [ ] Pass to `reviewer-opus`: review implementation in batch1-*.md
- [ ] Pass to `tester`: add tests for new ChunkStrategy class
- [ ] Needs `expert` assessment: is GraphRAG worth complexity?
```

The coordinator decides whether to delegate.

---

## Artifact Naming

### Naming Rules

1. **Single artifact** — use base name (`plan.md`)
2. **Multiple artifacts of same type** — add topic suffix (`plan-{topic}.md`)
3. **Topic** — 1-3 words, kebab-case, describes content
4. **Never** use numbers only (`plan-1.md`) — not self-documenting

### Naming Patterns

| Agent | Single | Multiple (add topic) |
|-------|--------|----------------------|
| planner-opus | `plan.md` | `plan-{scope}.md` (e.g., `plan-phase2.md`) |
| architect | `architecture.md` | `architecture-{component}.md` |
| expert | `expert-assessment.md` | `expert-{topic}.md` |
| implementer-* | `implementation.md` | `impl-{scope}.md` (e.g., `impl-batch1-models.md`) |
| reviewer-opus | `review.md` | `review-{scope}.md` (e.g., `review-a4-a5.md`) |
| scout-haiku | `scout-findings.md` | `scout-{topic}.md` |
| doc-haiku | `docs-update.md` | `docs-{topic}.md` |
| agent-opus | `analysis.md` | `{topic}-research.md` |

---

## Communication Examples

### Example 1: Implementation Complete

```markdown
## Result

**Status:** DONE
**Epic:** tasks/2025-01-15-graph-rag/
**Artifacts:**
- [implementation.md](./artifacts/implementation.md) — GraphBuilder class + tests

**Summary:** Implemented GraphBuilder with node/edge extraction from chunks.
Added 12 unit tests, all passing. Integration with existing pipeline pending.

**Next:** Run full test suite, then review.

**Handoff:**
- [ ] Pass to `reviewer-opus`: check architecture alignment
- [ ] Pass to `tester`: add integration tests for pipeline
```

### Example 2: Research with Concerns

```markdown
## Result

**Status:** DONE
**Epic:** tasks/2025-01-15-graph-rag/
**Artifacts:**
- [graph-research.md](./artifacts/graph-research.md) — Full analysis of GraphRAG approaches

**Summary:** Analyzed 3 approaches: NetworkX, neo4j, custom.
NetworkX simplest but O(n²) for large graphs. Custom requires 2-3 weeks.

**Next:** Need feasibility decision before implementation.

**Handoff:**
- [ ] **Needs `expert`**: Is GraphRAG worth the complexity vs enhanced MMR?
```

### Example 3: Blocked

```markdown
## Result

**Status:** BLOCKED
**Epic:** tasks/2025-01-15-graph-rag/
**Artifacts:**
- [implementation.md](./artifacts/implementation.md) — Partial implementation (70%)

**Summary:** Cannot proceed — EmbeddingProvider interface missing `batch_embed` method.
Need interface change or workaround decision.

**Next:** Resolve interface question.

**Handoff:**
- [ ] **Question to coordinator**: Add `batch_embed` to EmbeddingProvider or use loop?
```

---

## Coordinator's Role

The coordinator (parent agent or user) is responsible for:

1. **Reading summaries** — understand what each agent produced
2. **Checking artifacts** — if details needed for decision
3. **Routing handoffs** — delegate to requested agents or decline
4. **Synthesizing** — combine results from multiple agents

### Coordinator Responses to Handoff

```markdown
# Accepting handoff
"Passing to reviewer-opus as requested..."
[calls reviewer-opus with artifact reference]

# Declining handoff
"Skipping tester handoff — will add tests in next batch"

# Redirecting
"Instead of expert, asking architect — this is design question"
```

---

## Anti-patterns

### DON'T: Wall of Text Return

```markdown
# BAD — floods coordinator context
**Summary:** Here's everything I found... [500 lines of analysis]
```

### DON'T: Silent Handoff Expectation

```markdown
# BAD — assumes coordinator will know what to do
**Next:** Done.
```

### DON'T: Direct Agent Call Without Coordinator

```markdown
# BAD — bypasses coordinator
[Agent A directly calls Agent B without asking]
```

### DON'T: Skip Artifact for "Simple" Results

```markdown
# BAD — loses work if context resets
**Summary:** Fixed 3 files, details in my response above...
```

### DON'T: Save to Project Root

```markdown
# BAD — pollutes project root, violates protocol
Write("SCOUT-REPORT.md", content)      # ← root!
Write("METRICS-GUIDE.md", content)     # ← root!

# GOOD — use epic context or docs/research/
Write("{epic_path}/artifacts/scout-report.md", content)
Write("docs/research/metrics/guide.md", content)
```

---

## Integration with Epic Structure

```
tasks/YYYY-MM-DD-slug/
├── epic.md                    # Tasks Overview (coordinator updates)
├── WORKLOG.md                 # Append-only work history (all agents append)
├── artifacts/                 # Agent outputs (handoff artifacts)
│   ├── plan.md               # planner-opus (single)
│   ├── plan-phase2.md        # planner-opus (multiple: add topic)
│   ├── architecture.md       # architect
│   ├── review.md             # reviewer-opus (single)
│   ├── review-batch1.md      # reviewer-opus (multiple: add scope)
│   └── expert-assessment.md  # expert
└── findings/                  # Investigation materials for THIS epic (optional)
```

### WORKLOG.md Protocol

Every agent MUST append to WORKLOG.md after completing work:

```markdown
## YYYY-MM-DD

### {agent-name}: {Type}
{1-2 sentence summary of what was done}
- Status: DONE | PARTIAL | BLOCKED
- Files: {modified files, comma-separated}
- Artifacts: [{name}.md](./artifacts/{name}.md)
```

**Type vocabulary:** Planning, Research, Implementation, Review, Testing, Documentation, Fix, Decision, Delegation

**When to append:**
- After DONE — document what was completed
- After PARTIAL — important for session continuity
- After BLOCKED — document why and what was tried

---

## Checklist

Before returning result:

- [ ] Artifact saved to `{epic_path}/artifacts/`
- [ ] Summary is SHORT (5-10 lines)
- [ ] Status is clear: DONE / PARTIAL / BLOCKED
- [ ] Next step is explicit
- [ ] Handoff requests are specific (agent + task)

---

## Definition of Done

- Artifact exists and contains full work
- Coordinator received actionable summary
- Handoff requests are clear and justified
- No context lost if conversation resets

---

## Extension Points

1. **New artifact types:** Add to Artifact Naming table
2. **New agent types:** Document naming convention
3. **Validation script:** Add `scripts/validate-handoff.py` for format checking
4. **Status types:** Extend beyond DONE/PARTIAL/BLOCKED if needed

---

## See Also

### Skills
- **task** `.claude/skills/task-manage/` — Define epic structure before starting work; handoff uses this structure
- **research** `.claude/skills/research/` — Deep investigation before implementation; uses handoff for agent results
- **developer** `.claude/skills/developer/` — Implement features; uses handoff protocol to return results
- **reviewer template** `.claude/skills/validation/references/reviewer-template.md` — Code review template; invoke via `/validation reviewer`

### Related Concepts
- `WORKLOG.md` — Append-only history that agents update via handoff
- `artifacts/` — Where agent outputs go per handoff protocol
- `findings/` — Investigation materials (not agent outputs)
