---
description: Format and create a conventional commit
argument-hint: "<type> [description]  |  Types: feat fix refactor test docs chore perf style"
---

# Commit Workflow

> Создать форматированный коммит по Conventional Commits. Используй после завершения логического блока работы.

## Quick Reference

```
/commit              → auto-detect type from changes
/commit feat         → new feature
/commit fix          → bug fix
/commit refactor     → code restructuring
/commit test         → add/update tests
/commit docs         → documentation only
/commit chore        → deps, CI, configs
/commit perf         → performance optimization
/commit style        → formatting only
```

**Arguments**: `$ARGUMENTS` (опционально: type и description)

---

## Step 1: Analyze Changes

### 1.1 Проверить staged changes

```bash
git status --porcelain
git diff --cached --stat
```

### 1.2 Если ничего не staged

```bash
# Показать unstaged changes
git diff --stat

# Спросить что добавить
git add -p  # или git add {files}
```

### 1.3 Review изменения

```bash
git diff --cached
```

Понять:
- Какие файлы изменены
- Какой тип изменения (feat/fix/refactor/etc)
- Какой scope (модуль/компонент)

---

## Step 2: Determine Commit Type

### Типы коммитов

| Type | Когда использовать |
|------|-------------------|
| `feat` | Новая функциональность для пользователя |
| `fix` | Исправление бага |
| `refactor` | Рефакторинг без изменения поведения |
| `test` | Добавление/изменение тестов |
| `docs` | Изменения документации |
| `chore` | Build, deps, CI, конфиги |
| `perf` | Оптимизация производительности |
| `style` | Форматирование, без изменения логики |

### Scope (опционально, но рекомендуется)

| Scope | Описание |
|-------|----------|
| `cli` | CLI команды (locusrag/cli/) |
| `retrieval` | Retrieval pipeline (locusrag/retrieval/) |
| `ingestion` | Ingestion pipeline (locusrag/ingestion/) |
| `api` | FastAPI сервис (services/api/) |
| `ui` | Gradio UI (services/ui/) |
| `config` | Конфигурация (locusrag/config/) |
| `providers` | Провайдеры (locusrag/providers/) |
| `pipeline` | Pipeline stages (locusrag/pipeline/) |

---

## Step 3: Format Message

### 3.1 Структура

```
{type}({scope}): {description}

{body - опционально}

{footer}
```

### 3.2 Правила description

- Lowercase, без точки в конце
- Императив: "add", "fix", "update" (не "added", "fixes")
- Максимум 72 символа
- Отвечает на "This commit will..."

### 3.3 Body (опционально)

- Когда нужно объяснить "почему"
- Wrap на 72 символа
- Отделяется пустой строкой от description

### 3.4 Issue Reference (рекомендуется)

Если работа связана с GitHub Issue — **всегда указывай ссылку**:

| Формат | Когда использовать |
|--------|-------------------|
| `Refs #9` | Прогресс по issue (не закрывает) |
| `Closes #9` | Финальный коммит (закрывает issue) |
| `Fixes #9` | Исправление бага (закрывает issue) |

**Как определить issue:**
- Посмотреть текущий epic: `tasks/GH<N>-*/epic.md` → Issue #N
- Или найти `**GitHub Issue:** #N` в epic.md

### 3.5 Footer (обязательно)

```
Refs #9

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude Opus 4.5 <noreply@anthropic.com>
```

### 3.6 Breaking Changes

Если breaking change:
```
feat(api)!: change authentication flow

BREAKING CHANGE: API now requires OAuth2 tokens instead of API keys.

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude Opus 4.5 <noreply@anthropic.com>
```

---

## Step 4: Pre-Commit Safety Check

### 4.1 Проверить объём и содержимое

```bash
# Посчитать staged файлы
git diff --cached --name-only | wc -l
```

**Правила:**
- **>30 файлов** → Спросить пользователя: "Коммитим N файлов, продолжить?"
- **benchmarks/, .env, secrets** → Предложить отдельный коммит или exclude
- **Новые untracked директории** → Явно подтвердить включение

### 4.2 При необходимости — разделить

```bash
# Убрать из stage спорные файлы
git reset HEAD -- benchmarks/ path/to/sensitive/

# Закоммитить основное
git commit -m "..."

# Отдельный коммит для benchmarks (легко откатить)
git add benchmarks/ && git commit -m "chore: add benchmark data for X"
```

---

## Step 5: Create Commit

### 5.1 Выполнить коммит

```bash
git commit -m "$(cat <<'EOF'
{type}({scope}): {description}

{body если нужен}

Refs #N

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude Opus 4.5 <noreply@anthropic.com>
EOF
)"
```

> **Note:** Замени `Refs #N` на актуальный issue. Используй `Closes #N` только для финального коммита.

### 5.2 Verify

```bash
# Проверить что коммит создан
git log -1 --oneline

# Проверить статус
git status
```

---

## Примеры

### Простой feat
```
feat(retrieval): add MMR diversity selection
```

### Fix с scope
```
fix(cli): handle missing config file gracefully
```

### Refactor с body
```
refactor(ingestion): extract chunking logic to separate module

Moved chunking functions from simple_md.py to chunker.py
for better separation of concerns and testability.
```

### Docs
```
docs: update API reference for retrieve endpoint
```

### Chore (deps)
```
chore(deps): bump pydantic to 2.10.0
```

### Breaking change
```
feat(config)!: migrate to Pydantic v2 settings

BREAKING CHANGE: Environment variable prefix changed from
LOCUSRAG_ to LOCUSRAG__.
```

---

## Правила

1. **Один коммит = один логический блок** - не мешать разные изменения
2. **Atomic** - коммит должен оставлять код в рабочем состоянии
3. **Conventional format** - всегда type: description
4. **Issue reference** - `Refs #N` для прогресса, `Closes #N` только в финале
5. **Footer обязателен** - Claude Code attribution
6. **Не коммитить secrets** - проверять .env файлы
