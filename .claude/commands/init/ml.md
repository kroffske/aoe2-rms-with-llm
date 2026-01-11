---
description: Bootstrap ML проекта в указанной папке. Можно создавать вне текущего репо.
argument-hint: <path> [--python 3.11] [--with-docker]
---

# /init:ml — ML Project Bootstrap

Создаёт production-ready ML проект с Hydra configs, MLflow tracking.

**Самый простой способ создать новый ML проект.**

**Input:** $ARGUMENTS

## Examples

```bash
# Создать в соседней папке (самый частый случай)
/init:ml ../my-ml-project

# Создать в абсолютном пути
/init:ml /home/user/projects/fraud-detection

# Создать в текущей папке (если пустая)
/init:ml .
```

## Overview

```
/init:ml "../my-project"
       │
       ▼
┌─────────────────────────────────────────────────────────────┐
│ Phase 0: PREFLIGHT                                          │
│ • Parse arguments (или интерактивный режим)                 │
│ • Validate project_name                                     │
│ • Check dependencies (uv/python)                            │
├─────────────────────────────────────────────────────────────┤
│ Phase 1: GENERATION                                         │
│ • Create directory structure                                │
│ • Render templates                                          │
│ • Setup Claude Code integration                             │
├─────────────────────────────────────────────────────────────┤
│ Phase 2: VALIDATION                                         │
│ • Import check                                              │
│ • Output summary                                            │
└─────────────────────────────────────────────────────────────┘
```

## Phase 0: Preflight

### Interactive Mode (если нет аргументов)

Использовать `AskUserQuestion`:

1. **Path** — куда создать проект (например `../my-project`)
2. **Python version** — 3.10 | 3.11 (рекомендуется) | 3.12
3. **Project type** — Tabular ML | Deep Learning | Minimal
4. **Docker** — да/нет

### Arguments

```
Required:
  path: путь к папке проекта (относительный или абсолютный)
        - ../my-project — создаст папку рядом
        - /home/user/projects/foo — абсолютный путь
        - . — текущая папка (должна быть пустой)

Optional:
  --python 3.10|3.11|3.12  Python version (default: 3.11)
  --with-docker            Include Docker files
  --force                  Overwrite existing
```

### Path Handling

1. Извлечь `project_name` из последнего сегмента пути:
   - `../my-ml-project` → project_name = `my-ml-project`
   - `/home/user/fraud-detection` → project_name = `fraud-detection`

2. Создать папку если не существует:
   ```bash
   mkdir -p <path>
   ```

3. Все операции выполнять в `<path>/`

### Validation

- project_name: `^[a-z][a-z0-9_-]*$`
- Не reserved word Python
- Нет конфликтующих путей (src/, configs/, pyproject.toml)

## Phase 1: Generation

### Directory Structure

```
mkdir -p src/{package_name}
mkdir -p configs
mkdir -p tests
mkdir -p data/{raw,processed}
mkdir -p outputs/{artifacts,models}
```

### Templates

Использовать `templates/ml-project/`:

```
pyproject.toml.template → ./pyproject.toml
README.md.template → ./README.md
src/*.template → ./src/{package_name}/
configs/*.template → ./configs/
tests/*.template → ./tests/
```

### Claude Code Integration

Создать `.claude/rules/project.md` с правилами проекта.

Добавить skill-ссылки:
```
@.claude/skills/task-manage/
```

## Phase 2: Validation

```bash
python -c "from {package_name} import __version__"
ruff check src/ --select=E,F --quiet
```

## Output

```
═══════════════════════════════════════════════════════════
                 ML PROJECT CREATED
═══════════════════════════════════════════════════════════

Project: {{project_name}}
Package: {{package_name}}
Python:  {{python_version}}

Created:
├── pyproject.toml
├── src/{{package_name}}/
├── configs/
├── tests/
└── data/

Quick Start:
────────────────────────────────────────────────────────────
uv sync                                    # Install deps
python -m {{package_name}}.main task=train # Train model
────────────────────────────────────────────────────────────
═══════════════════════════════════════════════════════════
```

## Stack

| Component | Purpose |
|-----------|---------|
| Hydra | Configuration |
| Pydantic | Validation |
| MLflow | Tracking |
| Polars | Data |
| Ruff | Lint |
| pytest | Tests |

## References

- `templates/ml-project/` — шаблоны
- `/init:agents-md` — добавить AGENTS.md
- Оригинал: `.local/.archive/commands/ml-repo/bootstrap.md`
