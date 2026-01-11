---
description: Run all quality gates
---

# Quality Gates

> Быстрая проверка качества кода. Используй перед коммитом или для проверки состояния.

---

## Execution

### Gate 1: Ruff Check (BLOCKING)

```bash
ruff check locusrag/ scripts/ tests/ services/
```

**Что проверяет**:
- Синтаксические ошибки (E)
- Pyflakes (F) - unused imports, undefined names
- Bugbear (B) - common bugs
- И другие правила из pyproject.toml

**Результат**:
- ✅ PASS: No issues found
- ❌ FAIL: {count} errors → показать ошибки

### Gate 2: Ruff Format (BLOCKING)

```bash
ruff format --check locusrag/ scripts/ tests/ services/
```

**Что проверяет**:
- Форматирование кода
- Соответствие стилю

**Результат**:
- ✅ PASS: All files formatted
- ❌ FAIL: {count} files need formatting

**Auto-fix** (если нужно):
```bash
ruff format locusrag/ scripts/ tests/ services/
```

### Gate 3: Standards Lint (BLOCKING)

```bash
python .claude/hooks/lint.py --strict locusrag scripts services
```

**Что проверяет** (из AGENTS.md Golden Rules):
- `hasattr()`/`getattr()` с defaults - запрещено
- Broad `except:` без reraise - запрещено
- Banned imports в core - запрещено

**Результат**:
- ✅ PASS: No violations
- ❌ FAIL: {count} violations → показать

### Gate 4: Pytest (BLOCKING)

```bash
pytest -q --tb=short
```

**Что проверяет**:
- Все тесты проходят
- Нет regression

**Результат**:
- ✅ PASS: {passed} passed
- ❌ FAIL: {failed} failed → показать failures

---

## Summary

После выполнения всех gates вывести:

```
═══════════════════════════════════════════════════════════
                   QUALITY GATES SUMMARY
═══════════════════════════════════════════════════════════

Gate 1: ruff check        {✅|❌} {details}
Gate 2: ruff format       {✅|❌} {details}
Gate 3: standards-lint    {✅|❌} {details}
Gate 4: pytest            {✅|❌} {details}

Overall: {✅ ALL PASSED | ❌ FAILED}
═══════════════════════════════════════════════════════════
```

---

## Quick Fix Mode

Если gates fail и нужен auto-fix:

### Ruff fix

```bash
# Auto-fix safe issues
ruff check --fix locusrag/ scripts/ tests/ services/

# Format
ruff format locusrag/ scripts/ tests/ services/
```

### После fix

Повторить `/lint` для проверки.

---

## Selective Run

Можно запустить отдельные gates вручную:

```bash
# Только lint
ruff check locusrag/

# Только format
ruff format --check locusrag/

# Только tests
pytest tests/unit/ -q

# Только standards
python .claude/hooks/lint.py locusrag
```

---

## Правила

1. **Все gates BLOCKING** - релиз невозможен при failures
2. **Порядок важен** - быстрые проверки сначала
3. **Auto-fix безопасен** - ruff --fix не ломает логику
4. **Standards не auto-fixable** - требует ручного исправления
