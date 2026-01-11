---
name: writing-tests
description: Writes unit and integration tests following AAA pattern, organized by category (unit/integration/smoke/e2e). Use when adding test coverage, testing new features, validating changes with pytest, or when user asks to write or improve tests.
---

# Skill: Tester

## Активация

При использовании — сообщить:
> 🧪 **Tester**: пишу тесты по паттерну AAA

---

Надёжные, детерминированные тесты без внешних зависимостей.

## Структура тестов

```
tests/
├── conftest.py          # Общие фикстуры
├── unit/                # Быстрые изолированные тесты
│   ├── test_models.py
│   ├── test_retrieval/
│   └── test_synthesis/
├── integration/         # Взаимодействие компонентов
│   ├── test_pipeline.py
│   └── test_indexing.py
├── smoke/               # Быстрые проверки здоровья
│   └── test_cli_smoke.py
├── e2e/                 # End-to-end сценарии
│   └── test_full_flow.py
└── fixtures/            # Тестовые данные
    └── sample_docs/
```

## Категории тестов (marks)

| Mark | Назначение | Запуск |
|------|------------|--------|
| `@pytest.mark.unit` | Изолированные, без I/O | `pytest -m unit` |
| `@pytest.mark.integration` | Связки компонентов | `pytest -m integration` |
| `@pytest.mark.smoke` | Быстрые health checks | `pytest -m smoke` |
| `@pytest.mark.e2e` | Полные сценарии | `pytest -m e2e` |
| `@pytest.mark.external` | Требует сеть/API keys | `pytest -m external` |
| `@pytest.mark.slow` | >5 секунд | `pytest -m "not slow"` |

## Паттерн AAA (Arrange-Act-Assert)

```python
def test_mmr_diversity_selection() -> None:
    """Test MMR promotes diversity over duplicates."""
    # Arrange: подготовка данных
    query_emb = np.array([1.0, 0.0, 0.0])
    candidates = [
        ScoredDoc(chunk_id="c1", score=0.95, text="ML paper A"),
        ScoredDoc(chunk_id="c2", score=0.93, text="ML paper B"),  # похож на c1
        ScoredDoc(chunk_id="c3", score=0.85, text="Statistics"),   # разнообразие
    ]
    embeddings = {
        "c1": np.array([0.95, 0.05, 0.0]),
        "c2": np.array([0.93, 0.07, 0.0]),  # очень похож на c1
        "c3": np.array([0.7, 0.7, 0.0]),    # другое направление
    }

    # Act: вызов тестируемой функции
    result = mmr_select(candidates, n=2, lambda_div=0.5,
                        query_embedding=query_emb, candidate_embeddings=embeddings)

    # Assert: проверка результата
    assert len(result) == 2
    selected_ids = {doc.chunk_id for doc in result}
    assert "c1" in selected_ids, "Первый — самый релевантный"
    assert "c3" in selected_ids, "MMR предпочитает разнообразие, не дубликат c2"
```

## Именование тестов

Формат: `test_<что>_<сценарий>` или `test_<что>_<когда>_<ожидание>`

```python
# Good
def test_loader_missing_file_raises_error() -> None: ...
def test_embedding_dimension_mismatch_fails() -> None: ...
def test_mmr_empty_candidates_returns_empty() -> None: ...

# Bad
def test_loader() -> None: ...  # что именно?
def test_1() -> None: ...       # непонятно
```

## Фикстуры (conftest.py)

```python
# tests/conftest.py
import pytest
from pathlib import Path

@pytest.fixture
def tmp_project(tmp_path: Path) -> Path:
    """Создаёт временную структуру проекта."""
    (tmp_path / "docs").mkdir()
    (tmp_path / ".locusrag/indexes").mkdir(parents=True)
    (tmp_path / ".locusrag/cache").mkdir(parents=True)
    return tmp_path

@pytest.fixture
def offline_config(tmp_path: Path) -> Path:
    """Config с отключёнными провайдерами для offline тестов."""
    config = tmp_path / "config.yaml"
    config.write_text("""
embedding:
  provider: "off"
llm:
  provider: "off"
retrieval:
  vector_top_k: 0
""")
    return config

@pytest.fixture
def sample_chunks() -> list[Chunk]:
    """Тестовые чанки без I/O."""
    return [
        Chunk(chunk_id="doc1#0", text="First chunk", doc_id="doc1"),
        Chunk(chunk_id="doc1#1", text="Second chunk", doc_id="doc1"),
    ]
```

## Мокирование внешних зависимостей

```python
from unittest.mock import MagicMock, patch

def test_smoke_embeddings_success(smoke_config: Path) -> None:
    """Test successful embeddings smoke test."""
    runner = CliRunner()
    mock_embeddings = np.random.rand(1, 768).astype(np.float32)

    with patch("locusrag.cli.smoke.ComponentFactory.create_embedding_provider") as mock:
        mock_provider = MagicMock()
        mock_provider.embed_texts.return_value = mock_embeddings
        mock.return_value = mock_provider

        result = runner.invoke(app, ["--config", str(smoke_config), "smoke", "embeddings"])

        assert result.exit_code == 0
        assert "PASS" in result.output
        mock_provider.embed_texts.assert_called_once()
```

## Чек-лист тестировщика

### Unit тесты
- [ ] Покрывают ветвления, ошибки, краевые случаи
- [ ] Нет сети/диска; провайдеры замоканы
- [ ] Детерминированы (фиксированный seed где нужно)
- [ ] Следуют AAA паттерну
- [ ] Понятные имена: `test_<что>_<сценарий>`

### Integration тесты
- [ ] Связи между стадиями корректны
- [ ] Временные каталоги через `tmp_path`
- [ ] Индексы/кеши в `.locusrag/*` под `tmp_path`

### Контракты и ошибки
- [ ] Pydantic схемы валидируются
- [ ] Ошибки специфичные, без «тихих» падений
- [ ] Примеры/CLI по умолчанию работают offline

### Marks и организация
- [ ] Тест помечен правильным mark (unit/integration/smoke/e2e)
- [ ] Тесты с сетью помечены `@pytest.mark.external`
- [ ] Медленные тесты помечены `@pytest.mark.slow`

## Workflow: добавление теста

1. **Определи категорию**: unit → integration → smoke → e2e
2. **Создай/найди файл**: `tests/<category>/test_<module>.py`
3. **Напиши тест по AAA**: Arrange → Act → Assert
4. **Добавь mark**: `@pytest.mark.<category>`
5. **Запусти**: `pytest tests/<category>/test_<module>.py -v`
6. **Проверь изоляцию**: `pytest tests/<category>/test_<module>.py --forked`

## Команды запуска

```bash
# Все тесты
pytest -q

# По категории
pytest -m unit
pytest -m "integration and not slow"
pytest -m smoke

# Конкретный файл/функция
pytest tests/unit/test_mmr.py -v
pytest tests/unit/test_mmr.py::test_cosine_similarity_identical_vectors

# Без внешних зависимостей
pytest -m "not external"

# С покрытием изменённых файлов
pytest --cov=locusrag --cov-report=term-missing
```

## Антипаттерны

```python
# ❌ Неявная зависимость от порядка
class TestSuite:
    data = []  # shared state между тестами!

    def test_add(self):
        self.data.append(1)

    def test_check(self):
        assert len(self.data) == 1  # flaky!

# ✅ Изолированные тесты
def test_add(tmp_data):
    tmp_data.append(1)
    assert len(tmp_data) == 1

# ❌ Тест без assertions
def test_process():
    result = process(data)  # и что?

# ✅ Явные проверки
def test_process_returns_valid_output():
    result = process(data)
    assert result.status == "ok"
    assert len(result.items) > 0

# ❌ Тест слишком много
def test_everything():
    # 50 строк проверок разных вещей

# ✅ Один тест — один сценарий
def test_login_success(): ...
def test_login_wrong_password(): ...
def test_login_user_not_found(): ...
```

## Definition of Done

- [ ] Тесты детерминированы и быстрые
- [ ] Покрыт изменённый код и негативные сценарии
- [ ] Нет зависимостей от сети/окружения
- [ ] Локально воспроизводимо
- [ ] Все marks расставлены корректно
