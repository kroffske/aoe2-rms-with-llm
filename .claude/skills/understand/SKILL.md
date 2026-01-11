---
name: understand
description: Rephrase user request and get confirmation BEFORE starting work. Use for ambiguous tasks, complex features, or when scope needs clarification. Triggers on "/understand", "explain what you'll do", "what do you understand".
---

# Skill: Understand

Rephrase user request and confirm understanding BEFORE starting work.

---

## Triggers

- `/understand` - explicit call
- `explain what you'll do`, `what do you understand`
- `clarify the task`, `let me explain`
- Implicit: ambiguous or complex requests

---

## When to Use

| Situation | Action |
|-----------|--------|
| Complex multi-step task | ALWAYS confirm |
| Ambiguous scope | ALWAYS confirm |
| User says "build X" without details | ALWAYS confirm |
| Simple fix ("fix typo in README") | SKIP - just do it |
| User provides detailed spec | SKIP - proceed |
| Follow-up in ongoing work | SKIP - context is clear |

**Rule**: If you're uncertain about ANY aspect - use this skill.

---

## Process

```
User Request
    |
    v
+-------------------+
| Phase 1: PARSE    |
| - Extract intent  |
| - Identify scope  |
| - Find ambiguity  |
+-------------------+
    |
    v
+-------------------+
| Phase 2: REPHRASE |
| - State in clear  |
|   terms           |
| - Show scope      |
| - List questions  |
+-------------------+
    |
    v
+-------------------+
| Phase 3: CONFIRM  |<--+
| - User says yes   |   |
| - User corrects   |---+
| - Iterate until   |
|   confirmed       |
+-------------------+
    |
    v
Proceed with Work
```

---

## Phase 1: PARSE

### Extract Intent

Categorize the request:

| Intent | Signals | Example |
|--------|---------|---------|
| `research` | "should we", "is it worth", "compare" | "Should we use Qdrant?" |
| `plan` | "design", "architect", "plan" | "Design new auth system" |
| `implement` | "add", "create", "build", "implement" | "Add dark mode toggle" |
| `fix` | "fix", "bug", "broken", "error" | "Fix login error" |
| `refactor` | "refactor", "cleanup", "improve" | "Refactor auth module" |
| `docs` | "document", "update README" | "Document new API" |
| `test` | "add tests", "test coverage" | "Add tests for parser" |

### Identify Scope

Determine boundaries:

- **IN scope**: What specifically will be changed/created
- **OUT of scope**: What will NOT be touched (explicit exclusions)
- **Dependencies**: What existing code/systems are affected

### Find Ambiguity

Look for unclear points:

- Undefined terms ("make it better" - what is better?)
- Missing constraints ("add feature" - which module?)
- Implicit assumptions ("like we did before" - when?)
- Multiple interpretations possible

---

## Phase 2: REPHRASE

Present understanding in structured format.

### Output Template

```markdown
## Understanding the Request

**Task:** {1-2 sentence clear rephrasing}

**Intent:** {research | plan | implement | fix | refactor | docs | test}

**Scope:**
- IN: {what will be done}
- OUT: {what will NOT be done}

**Affected:**
- Files: {modules/files that will change, if known}
- Dependencies: {related systems}

**Questions:** (if any)
- {unclear point 1}
- {unclear point 2}

---

Is this correct?
```

### Language Matching

Match user's language:
- User writes in Russian -> respond in Russian
- User writes in English -> respond in English
- Mixed -> follow dominant language

### Russian Template

```markdown
## Как я понял запрос

**Задача:** {1-2 предложения, перефразированные четко}

**Intent:** {research | plan | implement | fix | refactor | docs | test}

**Scope:**
- Входит: {что будет сделано}
- Не входит: {что НЕ будет затронуто}

**Затрагивает:**
- Файлы: {модули/файлы, если известны}
- Зависимости: {связанные системы}

**Неясно:** (если есть)
- {неясный момент 1}
- {неясный момент 2}

---

Это верно?
```

---

## Phase 3: CONFIRM

### Confirmation Loop

```
Show understanding
    |
    v
Wait for user response
    |
    +---> "yes" / "da" / "correct" / "proceed"
    |         |
    |         v
    |     CONFIRMED -> Proceed with work
    |
    +---> "no" / "net" / correction
    |         |
    |         v
    |     RE-PARSE with new info -> back to Phase 2
    |
    +---> clarifying question
              |
              v
          ANSWER question -> back to Phase 2
```

### Response Patterns

| User Says | Action |
|-----------|--------|
| "yes", "да", "верно", "correct" | Proceed to work |
| "no", "нет", correction | Re-parse and show again |
| "also need X" | Add to scope, confirm again |
| "don't do Y" | Add to OUT scope, confirm |
| Question about approach | Answer, then confirm |

### Maximum Iterations

- **3 iterations max** for confirmation loop
- If still unclear after 3: ask user to provide written spec
- Anti-pattern: endless back-and-forth

---

## Integration Points

### With /work Commands

Understanding is the **FIRST phase** of complex workflows:

```
/work:plan → [UNDERSTAND] → PLAN → REVIEW → DECIDE
/work:lead → [UNDERSTAND if unclear] → EXECUTE
/work:team → [UNDERSTAND] → DELEGATE
```

**When to auto-invoke:**
- Task has multiple steps
- User request is open-ended
- Multiple interpretations possible

**When to skip:**
- User provides structured spec
- Follow-up in ongoing conversation
- Simple one-liner fixes

### With Agents

For complex tasks, may spawn `scout-haiku` to gather context:

```markdown
Task for scout-haiku:
- Find existing patterns for {topic}
- List affected files
- Check for naming conventions

Use findings to populate "Affected" section.
```

**Rule**: Only use scout-haiku if codebase context is needed for understanding. Most understanding is about user intent, not code.

### With Epic Creation

After confirmation, if task warrants epic:

```
CONFIRMED
    |
    v
Complexity check:
    |
    +---> Simple (1-3) -> Just do it
    |
    +---> Medium (4-6) -> Suggest epic
    |
    +---> Complex (7+) -> Create epic before work
```

---

## Simple Request Handling

### Skip Criteria

Skip understanding phase when:

1. **Atomic change**: "fix typo in README"
2. **Explicit spec**: User provides step-by-step
3. **Continuation**: "now do the second part"
4. **Obvious intent**: "run tests"

### Quick Acknowledge

For simple requests, use quick acknowledge instead:

```markdown
Got it - fixing the typo in README.md line 42.
```

No confirmation loop needed.

---

## Re-parse vs Questions

### When to Re-parse

- User provides NEW information
- User CORRECTS understanding
- Scope changes significantly

```
User: "No, I meant the frontend component, not backend"
-> Re-parse entire request with corrected scope
-> Show new understanding
```

### When to Ask Questions

- Specific detail is missing
- Options need to be chosen
- Ambiguity cannot be resolved from context

```markdown
**Question before proceeding:**
You mentioned "auth module" - do you mean:
A) lib/auth/ (backend authentication)
B) frontend/auth/ (login UI components)
C) Both
```

**Rule**: Prefer asking direct questions over guessing.

---

## Examples

### Example 1: Complex Implementation

```
User: "Add user preferences with theme support"

## Understanding the Request

**Task:** Add user preference system with dark/light theme switching.

**Intent:** implement

**Scope:**
- IN: User preferences storage, theme toggle UI, CSS variables for themes
- OUT: Backend API (assuming frontend-only), other preferences

**Affected:**
- Files: settings/, styles/, user context
- Dependencies: Existing user state management

**Questions:**
- Should preferences persist to localStorage or backend?
- Are there other preferences besides theme to add now?

---

Is this correct?
```

### Example 2: Ambiguous Fix

```
User: "Fix the login bug"

## Understanding the Request

**Task:** Fix a bug in the login functionality.

**Intent:** fix

**Scope:**
- IN: Login-related code
- OUT: Unknown until bug is identified

**Questions:**
- What is the bug? (error message, unexpected behavior?)
- When does it happen? (always, specific conditions?)
- Where to look? (frontend form, backend auth, session?)

---

Can you describe the bug symptoms?
```

### Example 3: Simple (Skip)

```
User: "Fix typo in README - change 'teh' to 'the'"

Got it - fixing typo in README.md.
[proceeds directly to fix]
```

### Example 4: Russian Request

```
User: "Добавь кеширование в эмбеддинг провайдер"

## Как я понял запрос

**Задача:** Добавить кеширование результатов в embedding provider для ускорения повторных запросов.

**Intent:** implement

**Scope:**
- Входит: Кеш для embed_text(), инвалидация, LRU стратегия
- Не входит: Изменение API провайдера, персистентный кеш

**Затрагивает:**
- Файлы: lib/embedding/
- Зависимости: Существующий EmbeddingProvider interface

**Неясно:**
- Какой размер кеша? (по умолчанию 1000 элементов?)
- Нужна ли персистенция между перезапусками?

---

Это верно?
```

---

## Anti-Patterns

| Avoid | Why | Instead |
|-------|-----|---------|
| Confirm obvious tasks | Wastes time | Quick acknowledge |
| Guess missing details | Wrong implementation | Ask questions |
| Long explanations | User loses interest | Keep to template |
| Technical jargon | User may not understand | Match user's language |
| Multiple confirmations | Annoying | One clear confirmation |
| Skip for complex tasks | Wrong scope | Always confirm complex |

---

## Checklist

Before proceeding:

- [ ] Intent clearly identified
- [ ] Scope explicitly stated (IN and OUT)
- [ ] All ambiguous points either clarified or queried
- [ ] User confirmed understanding
- [ ] Language matches user's preference

---

## Definition of Done

- User has explicitly confirmed understanding
- Scope is locked (no more scope creep)
- Questions answered or noted for later
- Ready to proceed with work

---

## See Also

### Commands
- `/work:plan` - Uses understand as first phase
- `/work:lead` - May invoke understand for complex tasks
- `/work:team` - Uses understand before delegation

### Skills
- **task** `.claude/skills/task-manage/` - Epic structure after understanding
- **research** `.claude/skills/research/` - For research intent type
- **developer** `.claude/skills/developer/` - For implement intent type

### Agents
- `scout-haiku` - Context gathering if needed
- `planner-opus` - Planning after confirmation
