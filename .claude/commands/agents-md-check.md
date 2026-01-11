---
description: Проверить AGENTS.md на обязательные секции и скиллы.
---

# /agents-md-check — Валидация AGENTS.md

Проверяет что AGENTS.md содержит все обязательные элементы.

## Checks

Все проверки находятся в отдельных файлах:

```
@.claude/commands/init/checks/
├── 01-project.md        # <project> section (Required)
├── 02-scope.md          # <scope> section (Required)
├── 03-tools.md          # <tools> section (Required)
├── 04-golden-rules.md   # <golden_rules> section (Required)
├── 05-layers.md         # <layers> section (Recommended)
├── 06-skill-task-manage.md  # skill reference (Recommended)
└── 07-mcp-server.md     # .mcp.json (Recommended)
```

## Execution

1. Прочитать `AGENTS.md` (или `CLAUDE.md` если symlink)
2. Для каждого check-файла:
   - Выполнить проверку из "How to check" секции
   - Записать результат
3. Вывести отчёт

## Output Format

```
═══════════════════════════════════════════════════════════
                 AGENTS.MD CHECK
═══════════════════════════════════════════════════════════

Required sections:
  ✅ <project>
  ✅ <scope>
  ❌ <tools> — missing
  ✅ <golden_rules>

Recommended sections:
  ✅ <layers>
  ⚠️ <dependencies_policy> — optional, not found

Required skills:
  ❌ @.claude/skills/task-manage/ — not referenced

MCP Server:
  ❌ .mcp.json — not found

Result: ❌ FAIL (1 required section missing, 1 skill missing)
═══════════════════════════════════════════════════════════
```

## Auto-fix

При запуске с `--fix`:
- Запустить `/init:agents-md` для интерактивного добавления недостающих секций

## References

- `@.claude/commands/init/checks/` — детали каждой проверки
- `@.claude/commands/init/templates/` — шаблоны секций
- `/init:agents-md` — создание/обновление AGENTS.md
