# Settings Template

Pre-configured permissions for Claude Code.

## Installation

Copy to your project root (NOT inside `.claude/`):

```bash
cp settings.json /path/to/your/project/.claude/settings.json
```

## What's Configured

### Allow (auto-approve)

| Category | Commands |
|----------|----------|
| Git (safe) | status, diff, log, branch, checkout, add, commit, stash, fetch, pull, merge |
| Testing | pytest, python -m pytest |
| Linting | ruff check, ruff format |
| Package managers | uv, npm, npx, pnpm, yarn, cargo, go |
| Build | make, go build, go test |
| File ops | ls, pwd, wc, mkdir, touch, cp, mv |
| Docker (read) | ps, logs, images |
| Runtimes | python, python3, node |

### Ask (confirm first)

| Category | Commands |
|----------|----------|
| Destructive | rm |
| Git (risky) | push, reset, rebase |
| Install | pip install, npm install |
| Publish | npm publish |
| Docker (write) | run, build, docker-compose |

### Deny (blocked)

| Category | Patterns |
|----------|----------|
| Secrets | .env, credentials*, secrets*, *.pem, *.key |
| Network | curl, wget, nc, telnet, ssh, scp |
| Dangerous | sudo, git push --force, rm -rf / |

## Customization

### Add allowed commands

```json
"allow": [
  "Bash(your-script *)",
  "Bash(custom-tool *)"
]
```

### Add protected files

```json
"deny": [
  "Read(config/production.yaml)",
  "Edit(*.prod.*)"
]
```

### Project-specific examples

**Python project:**
```json
"allow": [
  "Bash(poetry *)",
  "Bash(black *)",
  "Bash(mypy *)"
]
```

**Node.js project:**
```json
"allow": [
  "Bash(eslint *)",
  "Bash(prettier *)",
  "Bash(vitest *)"
]
```

## Default Mode

Template uses `"defaultMode": "acceptEdits"` — Claude edits files directly.

Options:
- `acceptEdits` — direct edits (fastest)
- `reviewEdits` — shows diffs, requires approval
- `planOnly` — only plans, never executes

## Additional Directories

If Claude needs access outside your project:

```json
"additionalDirectories": [
  "/path/to/shared/libs",
  "/usr/local/docs"
]
```

## Pattern Syntax

- `*` matches anything: `Bash(git *)` matches all git commands
- Patterns are prefix-matched
- Deny overrides allow

## Common Pitfalls

1. **cat/head/tail bypass** — These aren't in allow list by design. Use Read tool instead, which respects deny rules.

2. **Order matters** — Deny rules take precedence over allow.

3. **Debug denials** — Check Claude Code output for "Permission denied" messages.

## Security Notes

This template blocks network commands (curl, wget) by default. If you need them:

```json
"ask": [
  "Bash(curl *)"
]
```

Never add curl/wget to `allow` — always require confirmation for network access.
