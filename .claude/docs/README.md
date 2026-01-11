# Claude Code Kit - Commands

Quick reference for all commands.

## Quick Start

| Want to...              | Command              |
|-------------------------|----------------------|
| Create new epic         | `/task:create`       |
| Resume work             | `/task:resume`       |
| Commit                  | `/release:commit`    |
| Close epic              | `/task:close`        |

## Guides

- [Task Management System](./task-management.md) - Complete guide to epics, commands, and workflows

## Categories

- [work/*](./commands/work.md) - Work modes (lead, team, research, plan)
- [task/*](./commands/task.md) - Epic management (quick reference)
- [dev/*](./commands/dev.md) - Code quality
- [release/*](./commands/release.md) - Git workflow
- [gh/*](./commands/gh.md) - GitHub integration
- [Workflows](./workflows/README.md) - Visual guides

## Distribution

```
locus-claude-kit/.claude/
         |
         | /sync
         v
target-project/.claude/
```

Copy `.claude/` to your projects via `/sync` command.
