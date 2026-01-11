# Check: <tools> section

## What it checks

AGENTS.md must contain `<tools>` section with essential commands:
- Install — how to install dependencies
- Lint — how to run linting
- Tests — how to run tests

## How to check

```
grep -q "<tools>" AGENTS.md
```

## Template to add

### Python (uv)
```xml
<tools>
  - Install: `uv sync --extra dev`
  - Lint: `ruff check --fix . && ruff format .`
  - Tests: `pytest -q`
  - Single test: `pytest tests/path/test_file.py::test_name -v`
</tools>
```

### Python (pip)
```xml
<tools>
  - Install: `pip install -e ".[dev]"`
  - Lint: `ruff check --fix . && ruff format .`
  - Tests: `pytest -q`
</tools>
```

### Node.js
```xml
<tools>
  - Install: `npm install`
  - Lint: `npm run lint`
  - Tests: `npm test`
</tools>
```

## Questions to ask user

- Package manager? (uv, pip, npm, pnpm, yarn)
- Linter? (ruff, eslint, none)
- Test framework? (pytest, jest, vitest)
