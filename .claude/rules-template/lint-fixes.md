---
description: Quick fixes for common lint violations
paths:
  - "**/*.py"
---

# Lint Fixes Reference

Quick fixes for lint violations.

## Errors

### hasattr() prohibited

```python
# BAD
if hasattr(obj, "name"):
    return obj.name

# GOOD: explicit access
return obj.name  # let AttributeError surface

# GOOD: Protocol
class Named(Protocol):
    name: str
```

### getattr() with default

```python
# BAD
value = getattr(config, "timeout", 30)

# GOOD: explicit validation
if config.timeout is None:
    raise ValueError("timeout required")
value = config.timeout

# GOOD: Pydantic default
class Config(BaseModel):
    timeout: int = 30
```

### Bare except

```python
# BAD
try:
    risky()
except:
    pass

# GOOD: specific
try:
    risky()
except ValueError as e:
    logger.error(f"Invalid: {e}")
    raise
```

### Broad except Exception

```python
# BAD
except Exception:
    return None

# GOOD: specific
except (ValueError, KeyError) as e:
    raise ProcessingError(f"failed: {e}") from e
```

### from None (lost context)

```python
# BAD
raise ValidationError("invalid") from None

# GOOD
raise ValidationError(f"invalid: {e}") from e
```

## Warnings

### isinstance() in core

```python
# WARNING in business logic
if isinstance(obj, list):
    ...

# GOOD: polymorphism or config flags
if config.mode == "batch":
    process_batch(items)
```

### TODO without task

```python
# WARNING
# TODO: fix later

# GOOD
# TODO(tasks/2025-01-01-fix/epic.md): description
```

### File too long (>500 lines)

Split into focused modules.

### Function too long (>50 lines)

Extract helper functions.

## Suppression

```python
# With reason
value = getattr(obj, "x", None)  # noqa: GET001 — optional field
```
