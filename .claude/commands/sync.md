# /sync — Sync .claude to target projects

Синхронизация `.claude` папки из locus-claude-kit в другие проекты.

## Quick start

Сразу вызывай скрипт — он сам покажет справку при ошибке:
```bash
./sync.sh $ARGUMENTS
```

## Execution (fallback)

**Проверь текущую директорию:**

```bash
# Проверка: мы в locus-claude-kit?
if [[ -f ".claude-plugin/marketplace.json" ]]; then
    # OK - выполняем sync.sh
    ./sync.sh $ARGUMENTS
else
    echo "❌ Эта команда работает только из locus-claude-kit репозитория."
    echo ""
    echo "Выполни из основного репо:"
    echo "  cd ~/projects/locus-claude-kit"
    echo "  /sync push-all"
fi
```

---

## Usage

```
/sync push <path> [--delete]   # Push to specific project
/sync push-all [--delete]      # Push to all registered targets
/sync list                     # Show registered targets
/sync add <path>               # Register new target
```

## Options

- `--delete` — удалить orphan файлы в target (после рефакторинга/переименований)

## Examples

```bash
# Push to all projects
/sync push-all

# Push with cleanup (after refactoring)
/sync push-all --delete

# Add new target
/sync add ~/projects/new-project
```

## What Gets Synced

| Included | Excluded (preserved) |
|----------|----------------------|
| `commands/` | `_local/` (project-specific) |
| `skills/` | `commands/lc/`, `commands/local/` |
| `agents/` | `rules/` |
| `hooks/` | `logs/` |
| `docs/` | `settings*.json` |

## Python Script (with preview)

Для preview изменений перед синхронизацией:

```bash
./sync.py diff ~/projects/my-app           # показать что изменится
./sync.py push ~/projects/my-app           # показать + спросить подтверждение
./sync.py push ~/projects/my-app -y        # применить без вопросов
./sync.py push-all --delete                # preview для всех targets
```

## Project-specific files

Кастомные скиллы/агенты/команды кладём в `_local/` или `commands/lc/`:

```
.claude/commands/lc/my-cmd.md      # /lc:my-cmd — local command
.claude/skills/_local/my-skill/
.claude/agents/_local/my-agent.md
```

Эти файлы **никогда** не синхронизируются и не удаляются.

См. SYNC.md для детальной документации.
