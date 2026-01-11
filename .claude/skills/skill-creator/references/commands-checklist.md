# Commands Checklist

Detailed checklist for creating quality commands in Claude Code.

## Structure

```
.claude/commands/
├── my-command.md              # /my-command
└── category/
    ├── default.md             # /category (default subcommand)
    ├── sub1.md                # /category:sub1
    └── sub2.md                # /category:sub2
```

## Frontmatter Checklist

### Recommended Fields

- [ ] `description` — brief description for autocomplete
- [ ] `argument-hint` — shows in autocomplete (e.g., `[file] [--flag]`)

### Optional Fields

- [ ] `allowed-tools` — restrict which tools can be used
- [ ] `model` — override model for this command

**Good example:**
```yaml
---
description: Creates a new skill with analysis and multi-agent review
argument-hint: <skill goal or description>
allowed-tools: Read, Write, Bash(mkdir:*), Task
---
```

## File Naming

- [ ] Lowercase only
- [ ] Hyphens for word separation
- [ ] No spaces or special characters
- [ ] Descriptive name matching action

| Filename | Invocation |
|----------|------------|
| `commit.md` | `/commit` |
| `task/create.md` | `/task:create` |
| `task/default.md` | `/task` |

## Body Checklist

### Content

- [ ] NO usage section showing `/command args` (already invoked!)
- [ ] Clear purpose statement at top
- [ ] Step-by-step process
- [ ] Examples of the TASK being done (not invocation)
- [ ] Edge cases and error handling
- [ ] Single language (EN or RU)

### Structure

Recommended sections:

```markdown
# Command Name

Brief description of what this command does.

## Process

1. Step one
2. Step two
3. Step three

## Examples

### Example 1: Basic case
[Show the work being done, not `/command args`]

## Edge Cases

- If X happens, do Y
- If Z fails, handle with W
```

### What NOT to Include

- [ ] NO "Usage" section with `/command` invocation
- [ ] NO "How to invoke" examples
- [ ] NO "Arguments" section repeating frontmatter
- [ ] NO installation instructions

## Command vs Skill Decision

| Use Command When | Use Skill When |
|------------------|----------------|
| User explicitly invokes action | Triggered by context/description |
| Workflow/procedure | Knowledge/protocol |
| Rarely used (not every session) | Frequently relevant |
| Clear start/end | Ambient knowledge |

## Namespacing

Use subfolders for related commands:

```
commands/
├── task/
│   ├── create.md      # /task:create
│   ├── close.md       # /task:close
│   └── default.md     # /task
├── dev/
│   ├── lint.md        # /dev:lint
│   └── test.md        # /dev:test
```

## Arguments Syntax

| Syntax | Description | Example |
|--------|-------------|---------|
| `$ARGUMENTS` | All arguments as-is | Full user input |
| `$1`, `$2`, ... | Positional args | First arg, second arg |
| `` !`cmd` `` | Bash injection | `` !`git branch --show-current` `` |
| `@file` | File inclusion | `@src/main.py` |

## Final Verification

- [ ] Command invokes correctly (`/command-name`)
- [ ] Autocomplete shows description
- [ ] Process is clear and actionable
- [ ] Examples show work being done
- [ ] No invocation examples in body
- [ ] Related commands referenced
