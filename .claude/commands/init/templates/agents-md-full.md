# AGENTS.md

This file provides guidance to Claude Code when working with code in this repository.

<project>
  <name>{{project_name}}</name>
  <description>{{description}}</description>
  <language>{{language}}</language>
  <stack>{{stack}}</stack>
</project>

<scope>
  - Applies to the whole repo. Use docs/ for details when needed.
  - Canonical layout:
    - docs/ — documentation
    - src/ or {{package_name}}/ — source code
    - tests/ — tests
    - configs/ — configuration files
  - Tasks: `tasks/GH<N>-<slug>/epic.md` (epic-as-folder, GitHub-backed).
  - Backlog: `tasks/backlog/`. Done: `tasks/done/`.
</scope>

<tools>
  - Install: `{{install_cmd}}`
  - Lint: `{{lint_cmd}}`
  - Tests: `{{test_cmd}}`
  - Single test: `pytest tests/path/test_file.py::test_name -v`
</tools>

<golden_rules>
  - Single responsibility per function.
  - Fail fast with specific exceptions; never silent.
  - NO FALLBACKS: let code raise errors. Fallbacks hide misconfigurations.
  - Explicit dependencies; no hidden globals.
  - Config immutability after validation; derive via loaders/factories.
  - Preserve exception context: `raise ... from exc`.
  - Delete unused code immediately; no deprecation warnings.
  - Minimal config injection: pass only needed models, never full config.

```python
# BAD: silent fallback
value = getattr(config, "timeout", 30)

# GOOD: explicit validation
if config.timeout is None:
    raise ValueError("config.timeout is required")

# BAD: broad exception
try:
    process()
except Exception:
    return None

# GOOD: specific exception
try:
    process()
except ValueError as e:
    raise ProcessingError(f"failed: {e}") from e
```
</golden_rules>

<layers>
  - Domain models → {{package_name}}/models/
  - Config → {{package_name}}/config/
  - Core logic → {{package_name}}/core/
  - Providers → {{package_name}}/providers/ (external integrations)
  - CLI → {{package_name}}/cli/
</layers>

<dependencies_policy>
  - Core: minimal dependencies.
  - Providers: may have external dependencies.
  - Network calls only in providers; core logic stays pure.
</dependencies_policy>
