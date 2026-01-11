# Rules Templates

Generic rule templates for Claude Code projects.

## Usage

1. Copy desired rules to `.claude/rules/`:
   ```bash
   cp .claude/rules-template/error-handling.md .claude/rules/
   ```

2. Adapt paths in frontmatter:
   ```yaml
   paths:
     - "src/**"      # change to your project structure
     - "lib/**"
   ```

3. Customize content for your project

## Available Templates

| Template | Purpose |
|----------|---------|
| `architecture.md` | Layers, module placement, I/O boundaries |
| `code-style.md` | Formatting, comments, pre-flight checks |
| `error-handling.md` | NO FALLBACKS principle, exception patterns |
| `lint-fixes.md` | Quick fixes for common violations |
| `testing.md` | AAA pattern, markers, fixtures |

## Notes

- Templates are **not active** — only files in `rules/` are loaded
- Adapt `paths:` in frontmatter to match your project structure
- Remove sections that don't apply to your project
