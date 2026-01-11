---
description: Code formatting, style conventions, and comment guidelines
paths:
  - "**/*.py"
---

# Code Style

## Formatting

- Line length: 120 chars
- Indent: 4 spaces
- Naming: PEP8 (snake_case functions, PascalCase classes)

### CLI Arguments (compact)

```python
# BAD (verbose)
batch_size: int = typer.Option(
    32,
    "--batch-size",
    help="Batch size",
),

# GOOD (compact)
batch_size: int = typer.Option(32, "--batch-size", help="Batch size"),
```

### Config Injection (minimal)

```python
# BAD (God config)
def build_index(cfg: ProjectConfig): ...

# GOOD (specific)
def build_index(paths: PathsConfig, embed: EmbeddingConfig): ...
```

## Comments

**Principle:** Code should be self-documenting. Comment = sign that code isn't clear.

### When to Comment

1. **Pipeline stages**:
   ```python
   # Stage 1: Load documents
   docs = loader.load(source_dir)

   # Stage 2: Split into chunks
   chunks = chunker.split(docs)
   ```

2. **Magic numbers**:
   ```python
   # 0.85: tuned on test dataset
   THRESHOLD = 0.85
   ```

3. **Workarounds**:
   ```python
   # HACK: Library bug -- must flush before read
   db.flush()
   ```

4. **Complex algorithms** (brief idea):
   ```python
   # RRF fusion: combine ranks, lower rank = higher score
   ```

5. **Public API docstrings**:
   ```python
   def retrieve(query: str, top_k: int = 10) -> list[Chunk]:
       """Hybrid search with reranking."""
   ```

### When NOT to Comment

- Obvious code
- Self-explanatory conditionals
- Every line/function
- TODO without task reference

### Format

- Inline: lowercase, no period
- Block: `# Stage N: Verb + object`
- TODO: `# TODO(TASK-X): description`
- Language: English

## Pre-flight

```bash
ruff check --fix && ruff format
pytest -q
```
