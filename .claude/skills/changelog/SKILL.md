---
name: changelog-generator
description: Generates CHANGELOG.md from conventional commits with version bump and pyproject.toml sync. Use before commits or when releasing to track changes systematically.
---

# Skill: Changelog Generator

## Активация

При использовании — сообщить:
> 📝 **Changelog**: генерирую CHANGELOG из коммитов

---

## Цель

Автоматически генерировать CHANGELOG.md в формате [Keep a Changelog](https://keepachangelog.com/en/1.1.0/):
- Парсить conventional commits с последнего тега
- Категоризировать изменения (Added/Fixed/Changed/etc)
- Обновлять версию в `pyproject.toml` (опционально)
- Создавать git tag (опционально)

## Использование

### Только генерация CHANGELOG (без bump)

```bash
.claude/skills/changelog/generate.sh --dry-run
```

Выведет preview изменений без модификации файлов.

### С version bump

```bash
# Auto-detect версии из коммитов
.claude/skills/changelog/generate.sh

# Явно указать тип bump
.claude/skills/changelog/generate.sh patch
.claude/skills/changelog/generate.sh minor
.claude/skills/changelog/generate.sh major
```

### В составе release workflow

```bash
# Полный цикл: bump + changelog + commit + tag + push
.claude/skills/changelog/generate.sh patch --commit --tag --push
```

## Опции

| Опция | Описание |
|-------|----------|
| `--dry-run` | Preview без изменений файлов |
| `--commit` | Создать коммит после обновления |
| `--tag` | Создать git tag v{version} |
| `--push` | Push коммит и тег в origin |
| `--yes` | Skip confirmation prompt |

## Conventional Commits → Changelog

Скрипт парсит коммиты и группирует по категориям:

| Commit Type | Changelog Section | Version Impact |
|------------|------------------|----------------|
| `feat:` | **Added** | minor |
| `fix:` | **Fixed** | patch |
| `security:` | **Security** | patch (high priority) |
| `refactor:` | **Changed** | - |
| `perf:` | **Changed** | patch |
| `deprecate:` | **Deprecated** | - |
| `remove:` | **Removed** | - |
| `type!:` / `BREAKING CHANGE` | **Changed** | major |
| `docs:`, `chore:`, `test:` | **Other** | - |

## Формат вывода

```markdown
## [0.2.0] - 2024-12-24

### Added
- **retrieval**: add MMR diversity selection (a1b2c3d)
- **api**: add streaming endpoint (e4f5g6h)

### Fixed
- **cli**: handle missing config file gracefully (i7j8k9l)

### Changed
- **config**: migrate to Pydantic v2 (m0n1o2p)
```

## Примеры

### Preview изменений

```bash
.claude/skills/changelog/generate.sh --dry-run
```

Вывод:
```
═══════════════════════════════════════════════════════════
                    CHANGELOG PREVIEW
═══════════════════════════════════════════════════════════

📌 Version: 0.1.0 → 0.2.0 (MINOR)
   Reason: Found 3 new feature(s)

📊 Commits included: 5
   ✨ 3 features
   🐛 1 bug fix
   📝 1 other change

📄 CHANGELOG.md Entry:
───────────────────────────────────────────────────────────
## [0.2.0] - 2024-12-24

### Added
- **retrieval**: add MMR diversity selection (a1b2c3d)
...
```

### Release с auto-detect версии

```bash
# Анализирует коммиты, определяет bump, обновляет файлы
.claude/skills/changelog/generate.sh --yes
```

### Release с явной версией

```bash
# Patch release
.claude/skills/changelog/generate.sh patch --commit --tag
```

## Интеграция с workflow

### Pre-commit hook

Claude может вызывать скрипт перед коммитом:

```python
# .claude/hooks/pre-commit.py
import subprocess
result = subprocess.run([".claude/skills/changelog/generate.sh", "--dry-run"], capture_output=True)
print(result.stdout.decode())
```

### Release workflow

См. `.claude/commands/push.md` для полного release flow.

## Требования

- Git репозиторий с коммитами
- Python 3.11+ (для парсинга `pyproject.toml`)
- Conventional Commits в истории

## Особенности

- **Безопасный rollback**: создает бэкапы `.backup.$$` перед изменениями
- **Sync с git tags**: автоматически синхронизирует версию с последним тегом
- **Auto-commit**: опционально коммитит изменения перед релизом
- **Remote check**: проверяет что локальная ветка не отстает от origin

## Troubleshooting

### Нет коммитов с последнего релиза

```
❌ No commits since last release (v0.1.0)
```

**Решение**: Сделать коммиты или использовать `--force` для пустого релиза.

### Version mismatch

```
⚠️  Version mismatch: pyproject.toml (0.1.5) != tag (0.1.0)
```

**Поведение**: Скрипт автоматически синхронизирует `pyproject.toml` с последним тегом.

### Remote is ahead

```
❌ Remote is 2 commit(s) ahead of local
```

**Решение**: `git pull origin {branch}` или skip check с `CHANGELOG_SKIP_REMOTE_CHECK=true`.

## См. также

- `.claude/commands/push.md` - Release workflow
- `.claude/commands/commit.md` - Conventional commits guide
