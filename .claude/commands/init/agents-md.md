---
description: Создать или обновить AGENTS.md. Не перезаписывает — дополняет.
argument-hint: [--full | --minimal]
---

# /init:agents-md — Инициализация AGENTS.md

Создаёт или **аккуратно дополняет** существующий AGENTS.md.

## Принцип работы

1. Если AGENTS.md **не существует** → создать из шаблона
2. Если AGENTS.md **существует** → проверить и дополнить недостающие секции

**НИКОГДА не перезаписывать существующий контент без явного запроса.**

## Структура

```
.claude/commands/init/
├── agents-md.md          # Эта команда
├── checks/               # Отдельные проверки
│   ├── 01-project.md
│   ├── 02-scope.md
│   ├── 03-tools.md
│   ├── 04-golden-rules.md
│   ├── 05-layers.md
│   ├── 06-skill-task-manage.md
│   └── 07-mcp-server.md
└── templates/            # Шаблоны
    ├── agents-md-full.md
    ├── agents-md-minimal.md
    └── mcp.json
```

## Execution

### 1. Preflight

```bash
ls AGENTS.md CLAUDE.md .mcp.json 2>/dev/null
```

### 2. Если файла нет

Использовать шаблон `@.claude/commands/init/templates/agents-md-full.md` или `agents-md-minimal.md`.

**Запросить у пользователя:**
- Название проекта
- Описание
- Язык/стек (предложить варианты)

### 3. Если файл есть

Для каждого файла в `checks/` по порядку:
1. Прочитать check-файл
2. Выполнить проверку
3. Если секция отсутствует → предложить добавить

```
Используй AskUserQuestion с multiSelect: true

Question: "Какие секции добавить в AGENTS.md?"
Header: "Секции"
Options:
  - label: "<project>" (если отсутствует)
  - label: "<scope>" (если отсутствует)
  - label: "<tools>" (если отсутствует)
  - label: "<golden_rules>" (если отсутствует)
  - label: "<layers>" (рекомендуется)
  - label: "skill-ссылка task-manage"
  - label: "MCP Server (.mcp.json)"
```

### 4. MCP Server

Если пользователь выбрал MCP Server:
1. Скопировать `.claude/commands/init/templates/mcp.json` → `.mcp.json`
2. Вывести сообщение о успешном добавлении

### 5. Skill-ссылки

Если пользователь выбрал task-manage skill:

```markdown
## Skills (добавить в конец AGENTS.md)

@.claude/skills/task-manage/SKILL.md
```

## Checks Reference

| File | Section | Required |
|------|---------|----------|
| `01-project.md` | `<project>` | Yes |
| `02-scope.md` | `<scope>` | Yes |
| `03-tools.md` | `<tools>` | Yes |
| `04-golden-rules.md` | `<golden_rules>` | Yes |
| `05-layers.md` | `<layers>` | Recommended |
| `06-skill-task-manage.md` | skill reference | Recommended |
| `07-mcp-server.md` | `.mcp.json` | Recommended |

## Output

```
═══════════════════════════════════════════════════════════
                 AGENTS.MD INITIALIZED
═══════════════════════════════════════════════════════════

File: AGENTS.md (created/updated)

Sections:
  ✅ <project>
  ✅ <scope>
  ✅ <tools>
  ✅ <golden_rules>
  ⚪ <layers> — skipped

Skills added:
  ✅ @.claude/skills/task-manage/SKILL.md

MCP Server:
  ✅ .mcp.json created

Next steps:
  1. Review and customize AGENTS.md
  2. Run /agents-md-check to validate
═══════════════════════════════════════════════════════════
```

## References

- `@.claude/commands/init/checks/` — отдельные проверки
- `@.claude/commands/init/templates/` — шаблоны
- `/agents-md-check` — валидация
