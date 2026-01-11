---
description: Testing conventions and patterns
paths:
  - "tests/**"
  - "**/*_test.py"
  - "**/test_*.py"
---

# Testing

## Pattern: AAA

All tests follow **Arrange-Act-Assert**:

```python
def test_chunker_splits_document():
    # Arrange
    doc = Document(content="Long text..." * 100)
    chunker = Chunker(size=512)

    # Act
    chunks = chunker.split(doc)

    # Assert
    assert len(chunks) > 1
    assert all(len(c.content) <= 512 for c in chunks)
```

## Categories

| Category | Location | Purpose | Marker |
|----------|----------|---------|--------|
| Unit | `tests/unit/` | Isolated, mocked | (none) |
| Integration | `tests/integration/` | Real deps | `@pytest.mark.integration` |
| E2E | `tests/e2e/` | Full pipeline | `@pytest.mark.e2e` |

## Running

```bash
# All
pytest -q

# Single
pytest tests/path/test_file.py::test_name -v

# By marker
pytest -m integration
pytest -m "not e2e"

# Coverage
pytest --cov=src
```

## Markers

```python
@pytest.mark.integration
def test_db_persists():
    """Requires actual database."""
    ...

@pytest.mark.slow
def test_full_pipeline():
    """Takes >10s."""
    ...
```

## Fixtures

Place in `conftest.py` at appropriate level:

- `tests/conftest.py` — global
- `tests/unit/conftest.py` — unit-specific
- `tests/integration/conftest.py` — integration-specific

## Naming

- Files: `test_<module>.py`
- Functions: `test_<behavior>` or `test_<method>_<scenario>`
- Fixtures: descriptive nouns (`sample_doc`, `mock_db`)

## Isolated Paths

Override for test runs:

```python
os.environ["APP_DATA_DIR"] = str(tmp_path / "data")
```
