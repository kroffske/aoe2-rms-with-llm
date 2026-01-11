# work/* Commands

Work mode selection - how you approach tasks.

## Comparison

| Mode | You code? | Agents? | When |
|------|-----------|---------|------|
| `/work:lead` | Yes | Optional | Quick fixes, clear tasks |
| `/work:team` | No | Yes | Complex orchestration |
| `/work:plan` | No | Yes | Need reviewed plan first |

---

## /work:lead

**Tech Lead mode.** You CAN code directly.

```
User: "fix the login bug"
      |
      v
/work:lead
      |
      +---> Read code, understand issue
      +---> Fix directly OR delegate parts
      +---> Commit when done
```

**When to use:**
- Quick fixes
- Clear, well-defined tasks
- You want direct control

---

## /work:team

**PM mode.** You MUST delegate everything.

```
User: "implement auth system"
      |
      v
/work:team
      |
      +---> Break into subtasks
      +---> Spawn agents for each
      +---> Collect artifacts
      +---> Never touch files directly
```

**When to use:**
- Complex multi-step tasks
- Parallel work possible
- Need multiple perspectives

---

## /work:plan

**Planning Coordinator.** Iterative multi-agent planning (2-10 iterations).

```
User: "add dark mode"
      |
      v
/work:plan
      |
      +---> CLARIFY: lock requirements
      |
      +---> ITERATIVE PLANNING:
      |     |
      |     +---> Iteration 1: DRAFT (planner-opus)
      |     |     Show plan with HOW details
      |     |
      |     +---> Iteration 2: REFINE (parallel reviewers)
      |     |     architect + expert + reviewer
      |     |
      |     +---> CHECKPOINT: questions? stable?
      |     |     ASK user if needed
      |     |
      |     +---> Loop until delta < 10%
      |
      +---> DECIDE: user approves
      +---> Execute via /work:lead or /work:team
```

**Key features:**
- Describes HOW, not just WHAT
- 2-10 iterations until plan stabilizes
- Questions include implementation impact

**When to use:**
- Need reviewed plan first
- Multiple valid approaches
- Want user sign-off before work

