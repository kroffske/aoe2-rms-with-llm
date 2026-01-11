# Priority Matrix

Стратегическая приоритизация задач. Локальный файл `tasks/priority.md`.

## Когда использовать

- Много задач в backlog → нужно расставить приоритеты
- Планирование спринта/недели
- Обоснование "почему это, а не то"

**Отличие от GH Projects:**
- `priority.md` = план на бумаге, стратегия
- GH Projects = тактика, статус выполнения
- Могут расходиться — это нормально

## Создание

```bash
# Создать priority.md
touch tasks/priority.md
```

Или попросить: "создай priority matrix для проекта"

## Template

```markdown
# Task Priority Matrix

> **Created:** YYYY-MM-DD
> **Updated:** YYYY-MM-DD — краткое описание изменений
> **Purpose:** Стратегическая приоритизация задач

---

## Scoring Methodology

Каждая задача оценивается по 4 критериям (1-5 баллов):

| Критерий | Описание |
|----------|----------|
| **Value** | Бизнес-ценность для пользователя |
| **Maintenance** | Стоимость поддержки (5 = минимальная) |
| **Complexity** | Инвертированная сложность (5 = простая) |
| **Foundation** | Создаёт ли основу для будущих фич |

**Score = Value × 0.3 + Maintenance × 0.3 + Complexity × 0.2 + Foundation × 0.2**

---

## Priority Tiers

### Tier S — Do First (Score > 4.0)

| Task | Value | Maint | Cmplx | Found | Score | Status |
|------|-------|-------|-------|-------|-------|--------|
| GH{N}: Task name | 5 | 5 | 4 | 4 | **4.5** | In Progress |

### Tier A — High Priority (Score 3.5-4.0)

| Task | Value | Maint | Cmplx | Found | Score | Rationale |
|------|-------|-------|-------|-------|-------|-----------|
| GH{N}: Task name | 4 | 4 | 3 | 4 | **3.8** | Why this priority |

### Tier B — Medium Priority (Score 3.0-3.5)

| Task | Value | Maint | Cmplx | Found | Score | Rationale |
|------|-------|-------|-------|-------|-------|-----------|

### Tier C — Defer (Score < 3.0)

| Task | Value | Maint | Cmplx | Found | Score | Rationale |
|------|-------|-------|-------|-------|-------|-----------|

---

## Execution Order

```
Phase 1: ...
├── Task A
└── Task B

Phase 2: ...
├── Task C
└── Task D

Parallel / Later:
├── Task E (when time permits)
└── Task F (defer until trigger)
```

---

## Task Inventory

### Active Epics
| Epic | Status | Priority |
|------|--------|----------|

### Backlog
| Task | Category |
|------|----------|

### Completed
| Epic | Completion |
|------|------------|
```

## Maintenance

- Обновлять при добавлении новых эпиков
- Перемещать completed в конец таблицы (strikethrough ~~Task~~)
- Добавлять Updated date при изменениях

## Tips

1. **Не переусложняй** — если задач мало, хватит простого списка
2. **Score не догма** — используй как ориентир, не как закон
3. **Rationale важнее Score** — объясняй почему
4. **Execution Order** — самая полезная секция для планирования
