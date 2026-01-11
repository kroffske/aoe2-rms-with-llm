---
description: Architectural layers, module placement, and I/O boundaries
paths:
  - "src/**"
  - "lib/**"
---

# Architecture

## Layers

| Layer | Location | Contents |
|-------|----------|----------|
| Domain Models | `src/models/` | Core business entities (dataclass/Pydantic) |
| Database ORM | `src/database/models.py` | SQLAlchemy/ORM tables |
| Database Managers | `src/database/*_manager.py` | Single-responsibility managers |
| Config Models | `src/config/` | Configuration classes |
| Providers | `src/providers/` | External service integrations |
| Services | `src/services/` | Business logic orchestration |

**Rule:** Domain models are framework-agnostic. ORM is separate from domain.

## Placement Decisions

### New module? Ask:
1. Does it have I/O (DB, network, file)? → `providers/` or `database/`
2. Is it pure business logic? → `services/` or `domain/`
3. Is it a CLI/API entry point? → `cli/` or `api/`
4. Is it a utility? → `utils/` (but prefer explicit modules)

## I/O Boundaries

**Rule:** I/O lives at the edges, not in core logic.

```python
# BAD: I/O mixed with logic
def process(item: Item) -> Result:
    data = db.fetch(item.id)  # I/O inside
    result = transform(data)
    db.save(result)  # I/O inside
    return result

# GOOD: I/O at boundaries
def process(data: Data) -> Result:
    return transform(data)  # pure logic

# Caller handles I/O
data = db.fetch(item.id)
result = process(data)
db.save(result)
```

## Dependencies

- Core → nothing (pure)
- Services → Core, Providers
- Providers → External libs
- CLI/API → Services, Config

**No cycles.** Lower layers don't import from higher layers.
