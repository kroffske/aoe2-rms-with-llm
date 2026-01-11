---
name: developer
description: Implements features, fixes bugs, writes production code aligned with AGENTS.md. Use when writing new code, adding functions, fixing implementation issues, or refactoring existing modules.
---

# Skill: Developer

Quick reference for implementation patterns. Procedure lives in agent (implementer-opus).

## Checklist

| Area | Rule |
|------|------|
| **Layer** | Pure logic -> `lib/common/`, I/O -> `providers/`, scripts -> `scripts/` |
| **Contracts** | Cross-module -> Pydantic, internal -> dataclass |
| **Deps** | No `pandas` in core (use `pyarrow`), network only in providers |
| **Errors** | Fail-fast, no silent fallbacks, `raise ... from exc` |
| **Config** | Minimal injection (sub-config, not ProjectConfig), no mutation after validation |
| **Performance** | No try/except in hot paths, check compatibility once at init |
| **Observability** | Spans/timers on stages, no secrets in logs |
| **Tests** | Unit tests for changes, mock providers, no network by default |

## Anti-patterns

| Bad | Good |
|-----|------|
| `value if value else default` | `if value is None: raise ValueError(...)` |
| `getattr(cfg, "x", default)` | `cfg.x` (let error surface) |
| `isinstance(p, OpenAI): p.special()` | `p.embed(text)` (polymorphism) |
| `except: pass` | `except ValueError as e: raise X(...) from e` |
| `raise ... from None` | `raise ... from exc` (preserve context) |

## Definition of Done

- [ ] Correct layer (core/providers/scripts)
- [ ] AGENTS.md compliant (errors/deps/observability)
- [ ] Tests passing locally
- [ ] Lint/format passed (`ruff check --fix && ruff format`)
- [ ] TODOs linked to tasks or removed
- [ ] Examples offline-first, assembled via factories
