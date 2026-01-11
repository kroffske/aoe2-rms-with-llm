---
description: Release workflow with version bump and changelog
argument-hint: [patch|minor|major]
---

# Release Workflow

> Создать релиз: bump version, changelog, tag, push. Используй для завершения работы над фичей/эпиком.

**Version bump**: `$ARGUMENTS` (по умолчанию: auto-detect)

---

## Phase 0: Pre-flight

### Step 1: Проверить окружение

```bash
# Clean working tree?
git status --porcelain

# На правильной ветке?
git branch --show-current

# Remote настроен?
git remote -v
```

### Step 2: Проверить качество

```bash
# Lint
ruff check locusrag/ scripts/ tests/ services/

# Format
ruff format --check locusrag/ scripts/ tests/ services/

# Standards
python .claude/hooks/lint.py --strict locusrag scripts services

# Tests
pytest -q --tb=short
```

**Если проверки не прошли**: STOP и исправить.

### Step 3: Получить текущую версию

```bash
# Из pyproject.toml
grep -m1 'version = ' pyproject.toml
```

Или Read `pyproject.toml` и найти `version = "X.Y.Z"`.

### Step 4: Получить последний тег

```bash
git tag --sort=-version:refname | head -1
```

---

## Phase 1: Analyze Commits

### Step 1: Получить коммиты с последнего релиза

```bash
git log {last_tag}..HEAD --oneline --no-merges
```

### Step 2: Категоризировать по Conventional Commits

Парсить коммиты и группировать:

| Prefix | Changelog Category | Version Impact |
|--------|-------------------|----------------|
| `feat:` | Added | minor |
| `fix:` | Fixed | patch |
| `feat!:` / `BREAKING CHANGE` | Changed | major |
| `refactor:` | Changed | - |
| `perf:` | Changed | patch |
| `docs:` | - | - |
| `test:` | - | - |
| `chore:` | - | - |

### Step 3: Определить версию (если auto)

```
IF has breaking changes:
    bump = major
ELIF has feat:
    bump = minor
ELSE:
    bump = patch
```

### Step 4: Вычислить новую версию

```
current: X.Y.Z
patch:   X.Y.(Z+1)
minor:   X.(Y+1).0
major:   (X+1).0.0
```

---

## Phase 2: Update Version

### Step 1: Обновить pyproject.toml

Edit `pyproject.toml`:
```toml
# До
version = "0.1.0"

# После
version = "0.2.0"
```

---

## Phase 3: Generate Changelog

### Step 1: Формат Keep a Changelog

```markdown
## [X.Y.Z] - YYYY-MM-DD

### Added
- feat(scope): description (commit_hash)

### Fixed
- fix(scope): description (commit_hash)

### Changed
- refactor(scope): description (commit_hash)
- perf(scope): description (commit_hash)
```

### Step 2: Обновить CHANGELOG.md

**Если файл существует**:
- Read CHANGELOG.md
- Вставить новую секцию после `# Changelog` header

**Если файла нет**:
- Создать с header:
```markdown
# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [X.Y.Z] - YYYY-MM-DD
...
```

---

## Phase 4: Commit & Tag & Push

### Step 1: Commit release changes

```bash
git add pyproject.toml CHANGELOG.md
git commit -m "$(cat <<'EOF'
chore(release): v{version}

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude Opus 4.5 <noreply@anthropic.com>
EOF
)"
```

### Step 2: Create tag

```bash
git tag -a v{version} -m "Release v{version}"
```

### Step 3: Push

```bash
git push origin {branch}
git push origin v{version}
```

---

## Phase 5: Report

### Вывести summary

```
═══════════════════════════════════════════════════════════
                    RELEASE SUMMARY
═══════════════════════════════════════════════════════════

Version: {old_version} → {new_version}
Type:    {patch|minor|major}
Tag:     v{new_version}
Branch:  {branch}

Commits included: {count}
  feat:     {n}
  fix:      {n}
  refactor: {n}
  other:    {n}

Files updated:
  - pyproject.toml
  - CHANGELOG.md

Status: ✅ Released and pushed

═══════════════════════════════════════════════════════════
```

---

## Rollback (если что-то пошло не так)

### Если коммит сделан, но не push

```bash
# Удалить тег
git tag -d v{version}

# Откатить коммит
git reset --soft HEAD~1

# Восстановить файлы
git checkout HEAD -- pyproject.toml CHANGELOG.md
```

### Если уже push

```bash
# Удалить remote тег
git push origin :refs/tags/v{version}

# Удалить local тег
git tag -d v{version}

# Revert коммит
git revert HEAD
git push
```

---

## Правила

1. **Pre-flight обязателен** - не релизить с failing tests
2. **Conventional Commits** - для auto-detect версии
3. **Keep a Changelog** - стандартный формат
4. **Semantic Versioning** - major.minor.patch
5. **Tag после commit** - чтобы тег указывал на release commit
