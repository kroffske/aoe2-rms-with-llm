# Command Decision Tree

Which command for your situation?

## Main Decision Flow

```
    START
      |
      v
    New work or existing?
      |
      +--[New]--------> /task:create
      |
      +--[Existing]--> /task:resume
```

## Quick Reference

| Situation | Command |
|-----------|---------|
| "Starting new work" | `/task:create` |
| "Continue yesterday's work" | `/task:resume` |
| "Quick bug fix" | `/work:lead` |
| "Need help implementing" | `/work:team` |
| "Is code ok?" | `/dev:lint` |
| "Ready to commit" | `/release:commit` |
| "Epic is done" | `/task:close` |

## Work Mode Selection

```
    Need to implement something?
           |
           v
    Clear what to do?
      |
      +--[Yes]--> Can do it yourself?
      |             |
      |             +--[Yes]--> /work:lead
      |             |
      |             +--[No]---> /work:team
      |
      +--[No]----> /work:plan
```

## Quality Check Flow

```
    Code ready?
      |
      v
    /dev:lint
      |
      v
    Pass? --[No]--> Fix issues
      |
      +--[Yes]--> /release:commit
```

## Release Flow

```
    Ready to release?
      |
      v
    /release:push
      |
      v
    Bumps version
    Tags & pushes
```

## GitHub Sync Flow

```
    Want GitHub tracking?
      |
      v
    First time setup?
      |
      +--[Yes]--> /gh:projects (one-time)
      |
      +--[No]---> /task:resume (continue epic)
```
