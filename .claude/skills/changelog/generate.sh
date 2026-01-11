#!/usr/bin/env bash
#
# Changelog Generator for Python Projects
# Generates CHANGELOG.md from conventional commits with version bump
#
# Features:
# - Auto-detects version bump from conventional commits
# - Generates CHANGELOG.md entries with Keep a Changelog format
# - Updates pyproject.toml version
# - Safe rollback with file backups
# - Optional git commit, tag, and push
#
# Usage: ./generate.sh [patch|minor|major] [--dry-run] [--commit] [--tag] [--push] [--yes]
#        Leave empty for auto-detection from conventional commits
#        --dry-run: Preview only, no file changes
#        --commit: Create git commit after update
#        --tag: Create git tag v{version}
#        --push: Push commit and tag to origin
#        --yes: Skip confirmation prompt
#
# Supported conventional commit types:
#   security:   → Security section (patch version)
#   feat:       → Added section (minor version)
#   fix:        → Fixed section (patch version)
#   deprecate:  → Deprecated section
#   remove:     → Removed section
#   refactor:   → Changed section
#   perf:       → Changed section
#   type!:      → Breaking changes (major version)

set -euo pipefail

# === CONFIGURATION ===
readonly DATE=$(date +%Y-%m-%d)
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly PROJECT_ROOT="$(cd "$SCRIPT_DIR/../../.." && pwd)"

# Colors for output
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly BLUE='\033[0;34m'
readonly NC='\033[0m' # No Color

# State tracking
DRY_RUN=false
SHOULD_COMMIT=false
SHOULD_TAG=false
SHOULD_PUSH=false
AUTO_CONFIRM=false
CREATED_COMMIT=""
CREATED_TAG=""
declare -a BACKUP_FILES=()

# Commit categorization
declare -a ALL_COMMITS=()
declare -a FEATURES=()
declare -a FIXES=()
declare -a BREAKING_CHANGES=()
declare -a REFACTORS=()
declare -a PERF=()
declare -a SECURITY_FIXES=()
declare -a DEPRECATIONS=()
declare -a REMOVALS=()
declare -a OTHER_CHANGES=()

# === UTILITIES ===

log_info() {
    echo -e "${BLUE}ℹ️  $*${NC}"
}

log_success() {
    echo -e "${GREEN}✅ $*${NC}"
}

log_warning() {
    echo -e "${YELLOW}⚠️  $*${NC}"
}

log_error() {
    echo -e "${RED}❌ $*${NC}" >&2
}

safe_first() {
    awk 'NR==1 {print; exit}'
}

# === BACKUP AND RESTORE ===

create_backup() {
    local file="$1"

    if [ ! -f "$file" ]; then
        return 0
    fi

    local backup="${file}.backup.$$"
    cp "$file" "$backup" || {
        log_error "Failed to create backup of $file"
        exit 1
    }

    BACKUP_FILES+=("$backup")
    log_info "Created backup: ${backup##*/}"
}

restore_from_backups() {
    if [ ${#BACKUP_FILES[@]} -eq 0 ]; then
        return 0
    fi

    log_info "Restoring files from backups..."

    for backup in "${BACKUP_FILES[@]}"; do
        local original="${backup%.backup.*}"

        if [ -f "$backup" ]; then
            mv "$backup" "$original"
            log_success "Restored: ${original##*/}"
        fi
    done
}

cleanup_backups() {
    for backup in "${BACKUP_FILES[@]}"; do
        if [ -f "$backup" ]; then
            rm -f "$backup"
        fi
    done
}

# === CLEANUP AND ROLLBACK ===

cleanup() {
    local exit_code=$?

    if [ $exit_code -ne 0 ]; then
        echo ""
        log_error "Error occurred during changelog generation"
        echo ""
        log_warning "Rolling back changes..."

        # Delete tag if created
        if [ -n "$CREATED_TAG" ]; then
            git tag -d "$CREATED_TAG" 2>/dev/null || true
            log_success "Deleted tag $CREATED_TAG"
        fi

        # Rollback commit
        if [ -n "$CREATED_COMMIT" ]; then
            git reset --soft HEAD~1 2>/dev/null || true
            log_success "Rolled back commit"
        fi

        # Restore from backups
        restore_from_backups

        echo ""
        log_info "Rollback complete"
        echo ""
        exit $exit_code
    else
        # Success - clean up backups
        if [ "$DRY_RUN" = false ]; then
            cleanup_backups
        fi
    fi
}

trap cleanup EXIT

# === PRE-FLIGHT CHECKS ===

run_preflight_checks() {
    log_info "Running pre-flight checks..."
    echo ""

    # Check pyproject.toml exists
    if [ ! -f "$PROJECT_ROOT/pyproject.toml" ]; then
        log_error "Not in project root. Could not find pyproject.toml"
        exit 1
    fi

    # Check if on a branch
    BRANCH=$(git branch --show-current)
    if [ -z "$BRANCH" ]; then
        log_error "You are in detached HEAD state"
        echo "Checkout a branch first:"
        echo "  git checkout main"
        exit 1
    fi
    log_success "On branch: $BRANCH"

    # Get current version from pyproject.toml
    CURRENT_VERSION=$(grep -m1 'version = ' "$PROJECT_ROOT/pyproject.toml" | sed 's/.*version = "\(.*\)".*/\1/')
    if [ -z "$CURRENT_VERSION" ]; then
        log_error "Could not read version from pyproject.toml"
        exit 1
    fi
    log_success "Current version: $CURRENT_VERSION"

    # Get last git tag
    LAST_TAG=$(git tag --sort=-version:refname | safe_first || echo "")
    if [ -z "$LAST_TAG" ]; then
        log_warning "No previous git tags found (first release)"
        log_info "Will include all commits from repository start"
        COMMITS_RANGE="HEAD"
    else
        log_success "Last tag: $LAST_TAG"
        COMMITS_RANGE="${LAST_TAG}..HEAD"

        # Sync pyproject.toml with git tag if needed
        TAG_VERSION="${LAST_TAG#v}"
        if [ "$CURRENT_VERSION" != "$TAG_VERSION" ]; then
            log_warning "Version mismatch: pyproject.toml ($CURRENT_VERSION) != tag ($TAG_VERSION)"
            if [ "$DRY_RUN" = false ]; then
                log_info "Will sync pyproject.toml to $TAG_VERSION"
            fi
        fi
    fi

    # Check for commits since last tag
    COMMITS_COUNT=$(git rev-list $COMMITS_RANGE --count 2>/dev/null || echo "0")
    if [ "$COMMITS_COUNT" -eq 0 ]; then
        log_error "No commits since last release ($LAST_TAG)"
        echo "Nothing to add to changelog!"
        exit 1
    fi
    log_success "Found $COMMITS_COUNT commits since last release"

    echo ""
}

# === COMMIT PARSING ===

parse_commits() {
    log_info "Analyzing commits since ${LAST_TAG:-start}..."
    echo ""

    # Get all commits with hash
    while IFS= read -r line; do
        if [ -n "$line" ]; then
            ALL_COMMITS+=("$line")
        fi
    done < <(git log --format="%h %s" $COMMITS_RANGE)

    # Parse and categorize
    local breaking_pattern='^[a-z]+(\([^)]+\))?!:'
    local feat_pattern='^feat(\([^)]+\))?:'
    local fix_pattern='^fix(\([^)]+\))?:'
    local refactor_pattern='^refactor(\([^)]+\))?:'
    local perf_pattern='^perf(\([^)]+\))?:'
    local security_pattern='^security(\([^)]+\))?:'
    local deprecate_pattern='^deprecate(\([^)]+\))?:'
    local remove_pattern='^remove(\([^)]+\))?:'

    for commit in "${ALL_COMMITS[@]}"; do
        local hash=$(echo "$commit" | awk '{print $1}')
        local message=$(echo "$commit" | cut -d' ' -f2-)

        # Categorize
        if [[ "$message" =~ $breaking_pattern ]] || echo "$message" | grep -q "BREAKING CHANGE:"; then
            BREAKING_CHANGES+=("$commit")
        elif [[ "$message" =~ $security_pattern ]]; then
            SECURITY_FIXES+=("$commit")
        elif [[ "$message" =~ $feat_pattern ]]; then
            FEATURES+=("$commit")
        elif [[ "$message" =~ $fix_pattern ]]; then
            FIXES+=("$commit")
        elif [[ "$message" =~ $deprecate_pattern ]]; then
            DEPRECATIONS+=("$commit")
        elif [[ "$message" =~ $remove_pattern ]]; then
            REMOVALS+=("$commit")
        elif [[ "$message" =~ $refactor_pattern ]]; then
            REFACTORS+=("$commit")
        elif [[ "$message" =~ $perf_pattern ]]; then
            PERF+=("$commit")
        else
            OTHER_CHANGES+=("$commit")
        fi
    done

    # Display summary
    log_info "Commit summary:"
    [ ${#BREAKING_CHANGES[@]} -gt 0 ] && echo "  🔥 ${#BREAKING_CHANGES[@]} breaking changes"
    [ ${#SECURITY_FIXES[@]} -gt 0 ] && echo "  🔒 ${#SECURITY_FIXES[@]} security fixes"
    [ ${#FEATURES[@]} -gt 0 ] && echo "  ✨ ${#FEATURES[@]} features"
    [ ${#FIXES[@]} -gt 0 ] && echo "  🐛 ${#FIXES[@]} bug fixes"
    [ ${#DEPRECATIONS[@]} -gt 0 ] && echo "  ⚠️  ${#DEPRECATIONS[@]} deprecations"
    [ ${#REMOVALS[@]} -gt 0 ] && echo "  🗑️  ${#REMOVALS[@]} removals"
    [ ${#REFACTORS[@]} -gt 0 ] && echo "  ♻️  ${#REFACTORS[@]} refactors"
    [ ${#PERF[@]} -gt 0 ] && echo "  ⚡ ${#PERF[@]} performance improvements"
    [ ${#OTHER_CHANGES[@]} -gt 0 ] && echo "  📝 ${#OTHER_CHANGES[@]} other changes"
    echo ""
}

# === VERSION BUMP DETECTION ===

detect_version_bump() {
    local provided_bump="$1"

    if [ -n "$provided_bump" ]; then
        if [[ ! "$provided_bump" =~ ^(patch|minor|major)$ ]]; then
            log_error "Invalid version bump type: $provided_bump"
            echo "Usage: ./generate.sh [patch|minor|major]"
            exit 1
        fi
        BUMP_TYPE="$provided_bump"
        AUTO_DETECT_REASON="Manually specified"
        log_info "Using manual version bump: $BUMP_TYPE"
    else
        # Auto-detect from commits
        if [ ${#BREAKING_CHANGES[@]} -gt 0 ]; then
            BUMP_TYPE="major"
            AUTO_DETECT_REASON="Found ${#BREAKING_CHANGES[@]} breaking change(s)"
        elif [ ${#FEATURES[@]} -gt 0 ]; then
            BUMP_TYPE="minor"
            AUTO_DETECT_REASON="Found ${#FEATURES[@]} new feature(s)"
        elif [ ${#SECURITY_FIXES[@]} -gt 0 ]; then
            BUMP_TYPE="patch"
            AUTO_DETECT_REASON="Found ${#SECURITY_FIXES[@]} security fix(es)"
        elif [ ${#FIXES[@]} -gt 0 ]; then
            BUMP_TYPE="patch"
            AUTO_DETECT_REASON="Found ${#FIXES[@]} bug fix(es)"
        else
            BUMP_TYPE="patch"
            AUTO_DETECT_REASON="Default (no conventional commits detected)"
        fi
        log_success "Auto-detected version bump: $BUMP_TYPE ($AUTO_DETECT_REASON)"
    fi
    echo ""
}

# === VERSION CALCULATION ===

calculate_new_version() {
    local current="$CURRENT_VERSION"
    local IFS='.'
    read -ra parts <<< "$current"

    local major="${parts[0]}"
    local minor="${parts[1]}"
    local patch="${parts[2]}"

    case "$BUMP_TYPE" in
        major)
            major=$((major + 1))
            minor=0
            patch=0
            ;;
        minor)
            minor=$((minor + 1))
            patch=0
            ;;
        patch)
            patch=$((patch + 1))
            ;;
    esac

    NEW_VERSION="$major.$minor.$patch"
}

# === CHANGELOG GENERATION ===

format_changelog_line() {
    local commit="$1"
    local prefix="${2:-}"

    local hash=$(echo "$commit" | awk '{print $1}')
    local message=$(echo "$commit" | cut -d' ' -f2-)

    # Extract scope: "type(scope): message" -> "**scope**: message"
    local scope_pattern='^[a-z]+(\(([^)]+)\))?!?:[ ]+(.+)$'
    if [[ "$message" =~ $scope_pattern ]]; then
        local scope="${BASH_REMATCH[2]}"
        local msg="${BASH_REMATCH[3]}"

        if [ -n "$scope" ]; then
            echo "- ${prefix}**${scope}**: ${msg} (${hash})"
        else
            echo "- ${prefix}${msg} (${hash})"
        fi
    else
        echo "- ${prefix}${message} (${hash})"
    fi
}

generate_changelog_entry() {
    local version="$1"
    local date="$2"

    cat << EOF
## [$version] - $date

EOF

    # Security section (highest priority)
    if [ ${#SECURITY_FIXES[@]} -gt 0 ]; then
        echo "### Security"
        for commit in "${SECURITY_FIXES[@]}"; do
            format_changelog_line "$commit"
        done
        echo ""
    fi

    # Added section (features)
    if [ ${#FEATURES[@]} -gt 0 ]; then
        echo "### Added"
        for commit in "${FEATURES[@]}"; do
            format_changelog_line "$commit"
        done
        echo ""
    fi

    # Changed section (breaking, refactor, perf)
    if [ ${#BREAKING_CHANGES[@]} -gt 0 ] || [ ${#REFACTORS[@]} -gt 0 ] || [ ${#PERF[@]} -gt 0 ]; then
        echo "### Changed"
        for commit in "${BREAKING_CHANGES[@]}"; do
            format_changelog_line "$commit" "⚠️ BREAKING: "
        done
        for commit in "${REFACTORS[@]}"; do
            format_changelog_line "$commit"
        done
        for commit in "${PERF[@]}"; do
            format_changelog_line "$commit"
        done
        echo ""
    fi

    # Deprecated section
    if [ ${#DEPRECATIONS[@]} -gt 0 ]; then
        echo "### Deprecated"
        for commit in "${DEPRECATIONS[@]}"; do
            format_changelog_line "$commit"
        done
        echo ""
    fi

    # Removed section
    if [ ${#REMOVALS[@]} -gt 0 ]; then
        echo "### Removed"
        for commit in "${REMOVALS[@]}"; do
            format_changelog_line "$commit"
        done
        echo ""
    fi

    # Fixed section
    if [ ${#FIXES[@]} -gt 0 ]; then
        echo "### Fixed"
        for commit in "${FIXES[@]}"; do
            format_changelog_line "$commit"
        done
        echo ""
    fi

    # Other section
    if [ ${#OTHER_CHANGES[@]} -gt 0 ]; then
        echo "### Other"
        for commit in "${OTHER_CHANGES[@]}"; do
            format_changelog_line "$commit"
        done
        echo ""
    fi
}

# === UPDATE FILES ===

update_pyproject_toml() {
    local version="$1"
    local file="$PROJECT_ROOT/pyproject.toml"

    if [ "$DRY_RUN" = true ]; then
        log_info "Would update pyproject.toml: $CURRENT_VERSION → $version"
        return 0
    fi

    log_info "Updating pyproject.toml..."

    create_backup "$file"

    # Update version using sed
    sed -i "s/^version = \".*\"/version = \"$version\"/" "$file" || {
        log_error "Failed to update $file"
        exit 1
    }

    log_success "Updated pyproject.toml"
}

update_changelog() {
    local version="$1"
    local date="$2"
    local changelog_file="$PROJECT_ROOT/CHANGELOG.md"

    if [ "$DRY_RUN" = true ]; then
        log_info "Would update CHANGELOG.md"
        return 0
    fi

    log_info "Updating CHANGELOG.md..."

    create_backup "$changelog_file"

    # Generate new entry
    local new_entry=$(generate_changelog_entry "$version" "$date")

    # Update or create CHANGELOG.md
    if [ -f "$changelog_file" ]; then
        local existing_content=$(<"$changelog_file")

        # Insert after header
        if echo "$existing_content" | grep -q "# Changelog"; then
            {
                echo "$existing_content" | head -n 6
                echo ""
                echo "$new_entry"
                echo "$existing_content" | tail -n +7
            } > "$changelog_file"
        else
            # No proper header, insert at top
            {
                echo "$new_entry"
                echo "$existing_content"
            } > "$changelog_file"
        fi
    else
        # Create new CHANGELOG.md
        cat > "$changelog_file" << EOF
# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

$new_entry
EOF
    fi

    log_success "Updated CHANGELOG.md"
}

# === PREVIEW ===

show_preview() {
    cat << EOF
═══════════════════════════════════════════════════════════
                    CHANGELOG PREVIEW
═══════════════════════════════════════════════════════════

📌 Version: $CURRENT_VERSION → $NEW_VERSION (${BUMP_TYPE^^})
   Reason: $AUTO_DETECT_REASON

📊 Commits included: ${#ALL_COMMITS[@]}
EOF

    [ ${#BREAKING_CHANGES[@]} -gt 0 ] && echo "   🔥 ${#BREAKING_CHANGES[@]} breaking changes"
    [ ${#SECURITY_FIXES[@]} -gt 0 ] && echo "   🔒 ${#SECURITY_FIXES[@]} security fixes"
    [ ${#FEATURES[@]} -gt 0 ] && echo "   ✨ ${#FEATURES[@]} features"
    [ ${#FIXES[@]} -gt 0 ] && echo "   🐛 ${#FIXES[@]} bug fixes"
    [ ${#DEPRECATIONS[@]} -gt 0 ] && echo "   ⚠️  ${#DEPRECATIONS[@]} deprecations"
    [ ${#REMOVALS[@]} -gt 0 ] && echo "   🗑️  ${#REMOVALS[@]} removals"
    [ ${#REFACTORS[@]} -gt 0 ] && echo "   ♻️  ${#REFACTORS[@]} refactors"
    [ ${#PERF[@]} -gt 0 ] && echo "   ⚡ ${#PERF[@]} performance improvements"
    [ ${#OTHER_CHANGES[@]} -gt 0 ] && echo "   📝 ${#OTHER_CHANGES[@]} other changes"

    cat << EOF

📄 Files to update:
  - pyproject.toml
  - CHANGELOG.md

📝 CHANGELOG.md Entry:
───────────────────────────────────────────────────────────
$(generate_changelog_entry "$NEW_VERSION" "$DATE")───────────────────────────────────────────────────────────

═══════════════════════════════════════════════════════════
EOF
}

# === USER CONFIRMATION ===

get_user_confirmation() {
    if [ "$AUTO_CONFIRM" = true ] || [ "$DRY_RUN" = true ]; then
        return 0
    fi

    echo ""
    read -p "Proceed with changelog update? [Y/n]: " confirm

    if [[ ! "$confirm" =~ ^[Yy]?$ ]]; then
        log_warning "Cancelled by user"
        exit 0
    fi

    echo ""
}

# === EXECUTE ===

execute_update() {
    if [ "$DRY_RUN" = true ]; then
        log_info "Dry run mode - no files modified"
        return 0
    fi

    log_info "Executing changelog update..."
    echo ""

    update_pyproject_toml "$NEW_VERSION"
    update_changelog "$NEW_VERSION" "$DATE"

    # Optional commit
    if [ "$SHOULD_COMMIT" = true ]; then
        log_info "Creating commit..."
        git add pyproject.toml CHANGELOG.md
        git commit -m "chore(release): v$NEW_VERSION

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude Opus 4.5 <noreply@anthropic.com>" || {
            log_error "Failed to create commit"
            exit 1
        }
        CREATED_COMMIT="true"
        log_success "Commit created"
    fi

    # Optional tag
    if [ "$SHOULD_TAG" = true ]; then
        log_info "Creating git tag..."
        local tag_message="Release v$NEW_VERSION

$(generate_changelog_entry "$NEW_VERSION" "$DATE")"

        git tag -a "v$NEW_VERSION" -m "$tag_message" || {
            log_error "Failed to create tag"
            exit 1
        }
        CREATED_TAG="v$NEW_VERSION"
        log_success "Tag v$NEW_VERSION created"
    fi

    # Optional push
    if [ "$SHOULD_PUSH" = true ]; then
        log_info "Pushing to remote..."
        if [ "$SHOULD_TAG" = true ]; then
            git push origin "$BRANCH" --follow-tags || {
                log_error "Failed to push"
                exit 1
            }
        else
            git push origin "$BRANCH" || {
                log_error "Failed to push"
                exit 1
            }
        fi
        log_success "Pushed to origin/$BRANCH"
    fi

    echo ""
}

# === MAIN ===

main() {
    cd "$PROJECT_ROOT"

    echo ""
    echo "╔═══════════════════════════════════════════════════════════╗"
    echo "║                  Changelog Generator                      ║"
    echo "╚═══════════════════════════════════════════════════════════╝"
    echo ""

    # Parse arguments
    local bump_arg=""

    for arg in "$@"; do
        case "$arg" in
            --dry-run)
                DRY_RUN=true
                ;;
            --commit)
                SHOULD_COMMIT=true
                ;;
            --tag)
                SHOULD_TAG=true
                ;;
            --push)
                SHOULD_PUSH=true
                ;;
            --yes|-y)
                AUTO_CONFIRM=true
                ;;
            patch|minor|major)
                bump_arg="$arg"
                ;;
            *)
                log_error "Unknown argument: $arg"
                echo "Usage: $0 [patch|minor|major] [--dry-run] [--commit] [--tag] [--push] [--yes]"
                exit 1
                ;;
        esac
    done

    # Run workflow
    run_preflight_checks
    parse_commits
    detect_version_bump "$bump_arg"
    calculate_new_version

    # Show preview
    show_preview
    get_user_confirmation

    # Execute
    execute_update

    echo ""
    if [ "$DRY_RUN" = true ]; then
        echo "╔═══════════════════════════════════════════════════════════╗"
        echo "║                  DRY RUN COMPLETE                         ║"
        echo "╚═══════════════════════════════════════════════════════════╝"
    else
        echo "╔═══════════════════════════════════════════════════════════╗"
        echo "║              CHANGELOG UPDATED! 📝                        ║"
        echo "╚═══════════════════════════════════════════════════════════╝"
    fi
    echo ""
    log_success "Version: $CURRENT_VERSION → $NEW_VERSION"
    if [ "$SHOULD_TAG" = true ]; then
        log_success "Tag: v$NEW_VERSION"
    fi
    echo ""
}

# Run main
main "$@"
