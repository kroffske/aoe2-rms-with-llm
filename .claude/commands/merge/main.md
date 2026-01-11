---
description: Commit, push to main, merge selected PRs
argument-hint: [--no-pr]
---

# /merge:main — Merge workflow

> Закоммитить изменения, запушить в main, смерджить выбранные PR.

## Режим работы

**Использует Plan Mode** для сложных сценариев (несколько PR, конфликты).

---

## Phase 0: Анализ состояния

### Step 1: Проверить статус

```bash
# Текущая ветка
git branch --show-current

# Незакоммиченные изменения
git status --porcelain

# Открытые PR
gh pr list --state open --json number,title,headRefName,mergeable --limit 20
```

### Step 2: Категоризация изменений

Разделить изменения на категории:

| Категория | Паттерн | Отдельный коммит? |
|-----------|---------|-------------------|
| Claude config | `.claude/**` | Да |
| Source code | `src/**`, `*.py`, `*.ts` | По контексту |
| Остальное | `*` | Нет |

---

## Phase 1: Plan Mode (если нужно)

**Войти в Plan Mode если:**
- Есть открытые PR для мерджа
- Изменения затрагивают > 5 файлов
- Есть конфликты

### План должен включать:

```markdown
## Merge Plan

### Коммиты
1. `.claude/` изменения → `chore(claude): ...`
2. Остальные изменения → `feat/fix/chore: ...`

### Push
- Ветка: main
- Remote: origin

### PR для мерджа
- [ ] #123 — Feature X
- [ ] #456 — Fix Y

---
Approve?
```

→ `ExitPlanMode` для получения одобрения.

---

## Phase 2: Commit Changes

### Step 1: Коммит .claude/ (если есть изменения)

```bash
# Проверить есть ли изменения в .claude/
git status --porcelain .claude/
```

Если есть:

```bash
git add .claude/
git commit -m "$(cat <<'EOF'
chore(claude): update claude config

Co-Authored-By: Claude Opus 4.5 <noreply@anthropic.com>
EOF
)"
```

### Step 2: Коммит остальных изменений

```bash
# Добавить всё остальное
git add -A

# Проверить что осталось
git status --porcelain
```

Если есть изменения — определить тип и создать коммит:

```bash
git commit -m "$(cat <<'EOF'
<type>(<scope>): <description>

Co-Authored-By: Claude Opus 4.5 <noreply@anthropic.com>
EOF
)"
```

---

## Phase 3: Push to Main

### Step 1: Проверить ветку

```bash
git branch --show-current
```

**Если не main** — спросить пользователя:
- Переключиться на main и merge?
- Push в текущую ветку?

### Step 2: Push

```bash
git push origin main
```

---

## Phase 4: Merge PRs

### Step 1: Получить список PR

```bash
gh pr list --state open --json number,title,headRefName,mergeable,reviewDecision
```

### Step 2: Спросить пользователя

**Использовать AskUserQuestion:**

```yaml
Question: "Какие PR смерджить?"
Header: "PRs"
MultiSelect: true
Options:
  - label: "#123 — Feature X"
    description: "branch: feature-x, mergeable: true"
  - label: "#456 — Fix Y"
    description: "branch: fix-y, mergeable: true"
  - label: "Пропустить"
    description: "Не мерджить PR сейчас"
```

### Step 3: Merge выбранных

Для каждого выбранного PR:

```bash
gh pr merge <number> --merge --delete-branch
```

**Опции merge:**
- `--merge` — обычный merge commit
- `--squash` — squash and merge
- `--rebase` — rebase and merge

Использовать `--merge` по умолчанию.

---

## Phase 5: Report

```
═══════════════════════════════════════════════════════════
                    MERGE SUMMARY
═══════════════════════════════════════════════════════════

Commits created:
  ✅ chore(claude): update claude config
  ✅ feat(api): add new endpoint

Pushed to: origin/main

PRs merged:
  ✅ #123 — Feature X
  ✅ #456 — Fix Y

Status: ✅ Complete

═══════════════════════════════════════════════════════════
```

---

## Флаги

| Флаг | Описание |
|------|----------|
| `--no-pr` | Пропустить фазу мерджа PR |

---

## Правила

1. **Отдельный коммит для .claude/** — изолировать config от кода
2. **Plan Mode для PR** — пользователь выбирает что мерджить
3. **Conventional Commits** — автоматически определять тип
4. **Delete branch после merge** — cleanup
