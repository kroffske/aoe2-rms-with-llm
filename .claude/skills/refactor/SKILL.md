---
name: refactor
version: 1.0.0
description: Code refactoring expert - clean code principles, SOLID design patterns. Use for dedicated refactoring sessions.
model: any
---

# Skill: Refactor

Expert guidance for dedicated refactoring sessions. Focus on systematic code improvement.

---

## When to Use

**Use this skill for:**
- Dedicated refactoring sessions (not routine coding)
- Legacy code modernization
- Architecture cleanup
- Code smell elimination
- SOLID principle violations

**Do NOT use for:**
- Quick bug fixes (use developer skill)
- New feature implementation
- Routine code changes

---

## Analysis Framework

### 1. Code Smells

Identify issues in priority order:

| Smell | Threshold | Impact |
|-------|-----------|--------|
| Long methods | >20 lines | Hard to test and understand |
| Large classes | >200 lines | Multiple responsibilities |
| Duplicate code | >3% | Maintenance burden |
| Complex conditionals | >3 nested levels | Error-prone |
| Tight coupling | N/A | Change propagation |

See [patterns/code-smells.md](./patterns/code-smells.md) for detection and fixes.

### 2. SOLID Violations

Check each principle systematically:

| Principle | Violation Sign | Fix |
|-----------|----------------|-----|
| **S**ingle Responsibility | Class does multiple things | Extract classes |
| **O**pen/Closed | Modification for extension | Use abstractions |
| **L**iskov Substitution | Subclass breaks contract | Redesign hierarchy |
| **I**nterface Segregation | Fat interfaces | Split interfaces |
| **D**ependency Inversion | Concrete dependencies | Depend on abstractions |

See [patterns/solid.md](./patterns/solid.md) for Python examples.

### 3. Performance Issues

| Issue | Detection | Solution |
|-------|-----------|----------|
| O(n^2) algorithms | Nested loops over same data | Use hash maps |
| Unnecessary object creation | Profiler shows allocations | Object pooling, caching |
| Blocking operations | I/O in hot paths | Async, batching |
| Missing caching | Repeated expensive calls | `@lru_cache`, memoization |

---

## Refactoring Strategy

### Priority Matrix

```
Priority = (Business Value x Technical Debt) / (Effort x Risk)
```

| Priority | Criteria | Action |
|----------|----------|--------|
| **CRITICAL** | Production bugs, security | Fix immediately |
| **HIGH** | Blocks features, frequent changes | This sprint |
| **MEDIUM** | Code smells, low coverage | Next quarter |
| **LOW** | Style, minor naming | Backlog |

### Execution Order

1. **Quick wins** (high impact, low effort)
   - Extract magic numbers to constants
   - Rename unclear variables/functions
   - Remove dead code
   - Simplify boolean expressions

2. **Method extraction** (medium effort)
   - Long methods -> smaller functions
   - Duplicate code -> shared functions
   - Complex conditionals -> guard clauses

3. **Class decomposition** (high effort)
   - Extract responsibilities to new classes
   - Create interfaces for dependencies
   - Apply design patterns

See [patterns/strategies.md](./patterns/strategies.md) for detailed approaches.

---

## Quality Metrics

### Target Thresholds

| Metric | Good | Warning | Critical |
|--------|------|---------|----------|
| Cyclomatic complexity | <10 | 10-15 | >15 |
| Method lines | <20 | 20-50 | >50 |
| Class lines | <200 | 200-500 | >500 |
| Test coverage | >80% | 60-80% | <60% |
| Code duplication | <3% | 3-5% | >5% |
| Dependency count | <5 | 5-10 | >10 |

### Before/After Template

```
BEFORE:
- process_data(): 150 lines, complexity: 25
- 0% test coverage
- 3 responsibilities mixed

AFTER:
- validate_input(): 20 lines, complexity: 4
- transform_data(): 25 lines, complexity: 5
- save_results(): 15 lines, complexity: 3
- 95% test coverage
- Clear separation of concerns
```

---

## Output Format

When completing a refactoring session, provide:

1. **Analysis Summary** - Key issues found and impact
2. **Refactoring Plan** - Prioritized changes with effort estimates
3. **Refactored Code** - Implementation with inline comments
4. **Tests** - Unit tests for refactored components
5. **Metrics** - Before/after comparison

---

## Definition of Done

- [ ] All methods < 20 lines
- [ ] All classes < 200 lines
- [ ] Cyclomatic complexity < 10
- [ ] No duplicate code blocks
- [ ] Type hints added
- [ ] Tests achieve > 80% coverage
- [ ] No commented-out code
- [ ] Lint/format passed

---

## Related

- **Developer skill** - For implementation (not refactoring)
- **Reviewer skill** - For code review
- **Tester skill** - For test coverage
