# /repo:gh-projects — Initialize GitHub Issues as Task Tracker

Setup GitHub Issues with structured labels, issue templates, and Project board integration.

## When to Use

- Setting up a new project with GitHub Issues workflow
- Migrating from file-based task tracking (tasks/*.md) to GitHub Issues
- Standardizing issue creation across team

## Arguments

| Arg | Description |
|-----|-------------|
| `--local` | Install gh CLI locally to ~/.local/bin (no sudo required) |
| `--areas=X,Y,Z` | Custom area labels (default: backend,data,infra,docs) |
| `--skip-test` | Don't create test issue |
| `--force` | Overwrite existing issue templates |

## Execution

**Выполняй Phase 1-5 последовательно.** Код в секциях — готовый к выполнению bash.

НЕ ищи скрипты через Search/Glob. Для работы с существующим проектом используй:
```bash
.claude/skills/gh-toolkit/projects.sh <command>
```

Доступные команды: `list`, `items`, `status`, `link-repo`, `setup-board`, `setup-views`.

---

## Process

### Phase 1: Prerequisites

#### 1. Verify Git + GitHub Remote

```bash
# Must be in git repo with GitHub remote
REMOTE_URL=$(git remote get-url origin 2>/dev/null)
if [ -z "$REMOTE_URL" ]; then
  echo "Error: Not a git repository or no 'origin' remote"
  exit 1
fi

# Extract owner/repo for later use
OWNER=$(echo "$REMOTE_URL" | sed -E 's|.*[:/]([^/]+)/([^/]+)(\.git)?$|\1|')
REPO=$(echo "$REMOTE_URL" | sed -E 's|.*[:/]([^/]+)/([^/]+)(\.git)?$|\2|' | sed 's/\.git$//')
echo "Repository: $OWNER/$REPO"
```

#### 2. Check gh CLI (version ≥2.21 required)

```bash
REQUIRED_VERSION="2.21.0"
CURRENT_VERSION=$(gh version 2>/dev/null | grep -oP 'gh version \K[0-9.]+' | head -1)

version_ge() {
  [ "$(printf '%s\n' "$1" "$2" | sort -V | head -n1)" = "$1" ]
}

if [ -z "$CURRENT_VERSION" ]; then
  echo "gh CLI not installed"
  NEED_INSTALL=true
elif ! version_ge "$REQUIRED_VERSION" "$CURRENT_VERSION"; then
  echo "gh CLI $CURRENT_VERSION < $REQUIRED_VERSION (need upgrade)"
  NEED_INSTALL=true
else
  echo "✓ gh CLI $CURRENT_VERSION"
  NEED_INSTALL=false
fi
```

**Installation flow (if needed):**

```
IF --local flag provided:
    → Install to ~/.local/bin (no sudo)
ELSE:
    → Try apt install first (recommended)
    → IF apt fails (no sudo, permission denied):
        → Fallback to local install automatically
        → Show: "Installing locally to ~/.local/bin"
```

**apt installation (recommended):**
```bash
# Add GitHub CLI repository and install
(type -p wget >/dev/null || (sudo apt update && sudo apt-get install wget -y)) \
&& sudo mkdir -p -m 755 /etc/apt/keyrings \
&& out=$(mktemp) && wget -nv -O$out https://cli.github.com/packages/githubcli-archive-keyring.gpg \
&& cat $out | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
&& sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
&& sudo apt update && sudo apt install gh -y
```

**Local installation (fallback or --local):**
```bash
mkdir -p ~/.local/bin
GH_VERSION=$(curl -s https://api.github.com/repos/cli/cli/releases/latest | grep '"tag_name"' | sed -E 's/.*"v([^"]+)".*/\1/')
curl -L -o /tmp/gh.tar.gz "https://github.com/cli/cli/releases/download/v${GH_VERSION}/gh_${GH_VERSION}_linux_amd64.tar.gz"
tar -xzf /tmp/gh.tar.gz -C /tmp
cp "/tmp/gh_${GH_VERSION}_linux_amd64/bin/gh" ~/.local/bin/gh
chmod +x ~/.local/bin/gh
rm -rf /tmp/gh.tar.gz "/tmp/gh_${GH_VERSION}_linux_amd64"

# Remind user to add to PATH if needed
if ! echo "$PATH" | grep -q "$HOME/.local/bin"; then
  echo "Add to ~/.bashrc: export PATH=\"\$HOME/.local/bin:\$PATH\""
fi
```

#### 3. Check auth + project scopes

```bash
if ! gh auth status &>/dev/null; then
  echo "Not authenticated. Run: gh auth login"
  exit 1
fi

# Test project scope
if ! gh project list --limit 1 &>/dev/null; then
  echo "Missing project scope. Refreshing auth..."
  gh auth refresh -h github.com -s project,read:project
fi
echo "✓ gh auth OK with project scope"
```

---

### Phase 2: Labels

Create labels with `--force` for idempotency (updates existing):

```bash
echo "Creating labels..."

# Type labels
gh label create "type:bug"   -d "Bug report" -c "E99695" --force
gh label create "type:task"  -d "Feature or task" -c "C2E0C6" --force
gh label create "type:chore" -d "Maintenance, refactoring" -c "D4C5F9" --force

# Priority labels
gh label create "prio:P0" -d "Urgent/Critical" -c "B60205" --force
gh label create "prio:P1" -d "High priority" -c "D93F0B" --force
gh label create "prio:P2" -d "Normal priority" -c "FBCA04" --force
gh label create "prio:P3" -d "Low priority" -c "0E8A16" --force

# Area labels (from --areas or default: backend,data,infra,docs)
AREAS="${AREAS:-backend,data,infra,docs}"
for area in ${AREAS//,/ }; do
  gh label create "area:$area" -d "$area" -c "1D76DB" --force
done

echo "✓ Labels created"
```

---

### Phase 3: Project

#### 1. List existing projects and select

```bash
echo "Checking projects..."
PROJECTS=$(gh project list --owner "$OWNER" --format json 2>/dev/null)
PROJECT_COUNT=$(echo "$PROJECTS" | jq 'length')

if [ "$PROJECT_COUNT" -eq 0 ]; then
  # No projects — create new
  echo "No projects found. Creating '$REPO'..."
  CREATE_NEW=true

elif [ "$PROJECT_COUNT" -eq 1 ]; then
  # Single project — auto-select
  PROJECT_NUM=$(echo "$PROJECTS" | jq -r '.[0].number')
  PROJECT_TITLE=$(echo "$PROJECTS" | jq -r '.[0].title')
  echo "✓ Using existing project: $PROJECT_TITLE (#$PROJECT_NUM)"
  CREATE_NEW=false

else
  # Multiple projects — ask user
  echo "Multiple projects found:"
  echo "$PROJECTS" | jq -r '.[] | "  \(.number). \(.title)"'
  echo "  0. [Create new project]"

  # Use AskUserQuestion to select
  # Selected number stored in PROJECT_NUM
  # If 0 selected → CREATE_NEW=true
fi
```

#### 2. Create project if needed

```bash
if [ "$CREATE_NEW" = true ]; then
  echo "Creating project '$REPO'..."

  # ВАЖНО: --private обязателен! Public проекты видны всем.
  if ! OUTPUT=$(gh project create --owner "$OWNER" --title "$REPO" --private 2>&1); then
    echo "Error creating project: $OUTPUT"
    echo "Check permissions: gh auth refresh -s project"
    exit 1
  fi

  # Extract project number and link to repo
  PROJECT_NUM=$(gh project list --owner "$OWNER" --format json | jq -r '.[0].number')
  gh project link "$PROJECT_NUM" --owner "$OWNER" --repo "$OWNER/$REPO"

  PROJECT_TITLE="$REPO"
  echo "✓ Created and linked project: $PROJECT_TITLE (#$PROJECT_NUM)"
fi
```

#### 3. Verify project fields

```bash
echo "Verifying project fields..."
FIELDS=$(gh project field-list "$PROJECT_NUM" --owner "$OWNER" 2>/dev/null)

# Status and Priority should exist by default in new projects
if echo "$FIELDS" | grep -q "Status"; then
  echo "✓ Status field exists"
else
  echo "⚠ Status field missing — add manually in project settings"
fi
```

---

### Phase 4: Issue Templates

#### 1. Create directory

```bash
mkdir -p .github/ISSUE_TEMPLATE
```

#### 2. Check existing files

```bash
if [ -f .github/ISSUE_TEMPLATE/config.yml ] && [ "$FORCE" != true ]; then
  echo "Templates already exist. Use --force to overwrite."
  SKIP_TEMPLATES=true
else
  SKIP_TEMPLATES=false
fi
```

#### 3. Write templates (with OWNER/REPO substitution)

**config.yml:**
```yaml
blank_issues_enabled: false
contact_links:
  - name: Discussions
    url: https://github.com/${OWNER}/${REPO}/discussions
    about: Use discussions for questions and ideas
```

**01-bug.yml:**
```yaml
name: Bug Report
description: Report a bug or unexpected behavior
title: "[Bug]: "
labels: ["type:bug"]
body:
  - type: dropdown
    id: priority
    attributes:
      label: Priority
      options:
        - P2 (Normal)
        - P1 (High)
        - P0 (Critical)
        - P3 (Low)
    validations:
      required: true

  - type: dropdown
    id: area
    attributes:
      label: Area
      options:
        # Populated from --areas or defaults
        - backend
        - data
        - infra
        - docs
    validations:
      required: true

  - type: textarea
    id: description
    attributes:
      label: Bug Description
      description: What happened? What did you expect?
    validations:
      required: true

  - type: textarea
    id: reproduction
    attributes:
      label: Steps to Reproduce
    validations:
      required: true

  - type: textarea
    id: logs
    attributes:
      label: Logs / Screenshots
      render: shell
```

**02-task.yml:**
```yaml
name: Task / Feature
description: Request a feature or describe a task
title: "[Task]: "
labels: ["type:task"]
body:
  - type: dropdown
    id: priority
    attributes:
      label: Priority
      options:
        - P2 (Normal)
        - P1 (High)
        - P3 (Low)
        - P0 (Critical)
    validations:
      required: true

  - type: dropdown
    id: area
    attributes:
      label: Area
      options:
        - backend
        - data
        - infra
        - docs
    validations:
      required: true

  - type: textarea
    id: description
    attributes:
      label: What
      description: What needs to be done? (1-2 sentences)
    validations:
      required: true

  - type: textarea
    id: done-criteria
    attributes:
      label: Done When
      description: Checklist of acceptance criteria
      placeholder: |
        - [ ] Criterion 1
        - [ ] Criterion 2
    validations:
      required: true
```

---

### Phase 5: Verification

#### 1. Create test issue (unless --skip-test)

```bash
if [ "$SKIP_TEST" != true ]; then
  echo "Creating test issue..."

  if ISSUE_URL=$(gh issue create \
    --title "[Test]: GitHub Issues tracker setup" \
    --body "Verify setup works. Delete after checking." \
    --label "type:chore" --label "prio:P3" --label "area:infra" \
    --project "$PROJECT_NUM" 2>&1); then

    ISSUE_NUM=$(echo "$ISSUE_URL" | grep -oP '/issues/\K\d+')
    echo "✓ Test issue created: #$ISSUE_NUM"
  else
    echo "⚠ Test issue creation failed: $ISSUE_URL"
    echo "Try manually: gh issue create --label type:chore --project $PROJECT_NUM"
  fi
fi
```

#### 2. Save project config

```bash
# Save for gh-toolkit scripts and /task:* commands
echo "project=$PROJECT_NUM" > .gh-project
echo "✓ Saved project config to .gh-project"
```

#### 3. Show summary

```
┌─────────────────────────────────────────────────────┐
│ GitHub Issues Tracker Setup Complete                │
├─────────────────────────────────────────────────────┤
│ ✓ gh CLI: v2.x.x                                    │
│ ✓ Labels: 11 created/updated                        │
│ ✓ Project: "$REPO" (#N) — linked to repo            │
│ ✓ Templates: 3 files in .github/ISSUE_TEMPLATE/     │
│ ✓ Config: .gh-project (for /task:create)            │
│ ✓ Test issue: #XX                                   │
├─────────────────────────────────────────────────────┤
│ Next steps:                                         │
│ • View project: gh project view N --owner "$OWNER" --web
│ • Create issue: gh issue create                     │
│ • Commit templates:                                 │
│   git add .github/ISSUE_TEMPLATE && git commit      │
└─────────────────────────────────────────────────────┘
```

---

## Examples

### Basic Setup
```
/repo:gh-projects
```

### Force Local gh Installation (no sudo)
```
/repo:gh-projects --local
```

### Custom Areas for Frontend Project
```
/repo:gh-projects --areas=frontend,backend,api,design
```

### Force Overwrite Existing Templates
```
/repo:gh-projects --force
```

### Skip Test Issue Creation
```
/repo:gh-projects --skip-test
```

---

## Edge Cases

| Case | Handling |
|------|----------|
| Not in git repo | Error: "Not a git repository or no 'origin' remote" |
| No GitHub remote | Error: "No GitHub remote found" |
| gh not installed | Try apt → fallback to local (or use --local) |
| gh version < 2.21 | Same as not installed (upgrade) |
| gh not authenticated | Error: "Run `gh auth login` first" |
| Project scope missing | Auto-refresh: `gh auth refresh -s project` |
| Multiple projects exist | Prompt user to select or create new |
| Project creation fails | Error with permission check hint |
| Labels already exist | `--force` updates them (idempotent) |
| Templates already exist | Skip unless `--force` |
| No sudo for apt | Auto-fallback to local install |
| Test issue fails | Warning with manual command |
| API rate limit | Error: wait or use PAT |

---

## Daily Workflow After Setup

```bash
# Create issue with labels and project
gh issue create \
  --label "type:task" --label "prio:P1" --label "area:backend" \
  --project N

# List high-priority issues
gh issue list --label "prio:P0,prio:P1"

# Assign issue to yourself
gh issue edit 123 --add-assignee @me

# Link PR to issue (auto-closes on merge)
# In PR description: "Fixes #123"

# View project board
gh project view N --owner "$OWNER" --web
```

---

## Related

- `/commit` — commit with conventional format
- `/task:create` — create epic with GitHub Issue
- `@.claude/skills/gh-toolkit/SKILL.md` — GitHub CLI toolkit for operations
