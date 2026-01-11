---
description: Error handling patterns and the NO FALLBACKS principle
paths:
  - "src/**"
  - "lib/**"
---

# Error Handling

## Core Principle: NO FALLBACKS

**Let code raise errors. Fallbacks hide misconfigurations.**

Fail fast. Silent handling masks problems.

## Layer-Specific Rules

### Core/Business Layer
- Specific exceptions only
- Preserve context: `raise ... from exc`

### Data/Providers Layer
- Wrap SDK errors into domain errors
- Always: `raise DomainError(...) from exc`

### CLI/API Layer
- Catch only to format exit message
- Then re-raise or `Exit(1)`
- No silent fallbacks

## Patterns

### BAD: Silent fallback

```python
def get_config(key: str) -> str:
    return config.get(key, "default")  # hides missing config
```

### GOOD: Fail fast

```python
def get_config(key: str) -> str:
    if key not in config:
        raise ConfigError(f"Missing required config: {key}")
    return config[key]
```

### BAD: Swallowed exception

```python
try:
    process(data)
except Exception:
    pass  # silent failure
```

### GOOD: Specific handling

```python
try:
    process(data)
except ValidationError as e:
    raise ProcessingError(f"Invalid data: {e}") from e
```

### BAD: Lost context

```python
except ParseError as e:
    raise ValidationError("invalid") from None
```

### GOOD: Preserved context

```python
except ParseError as e:
    raise ValidationError(f"Parse failed: {e}") from e
```

## Domain Exceptions

Create project-specific exceptions:

```python
# src/exceptions.py
class AppError(Exception):
    """Base application error."""

class ConfigError(AppError):
    """Configuration error."""

class ValidationError(AppError):
    """Validation error."""

class DatabaseError(AppError):
    """Database operation error."""
```

## Suppression

Only with explicit reason:

```python
except TimeoutError:  # noqa: expected for optional cache
    return None
```
