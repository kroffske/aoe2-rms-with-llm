#!/bin/bash
# Wrapper for lint.py - finds best available Python interpreter
# Priority: .venv/bin/python → uv run python → python3 → python

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LINT_SCRIPT="$SCRIPT_DIR/lint.py"

# Find Python interpreter
find_python() {
    # 1. Check .venv in current directory
    if [[ -x ".venv/bin/python" ]]; then
        echo ".venv/bin/python"
        return 0
    fi

    # 2. Check if uv is available
    if command -v uv &> /dev/null; then
        echo "uv run python"
        return 0
    fi

    # 3. Try python3
    if command -v python3 &> /dev/null; then
        echo "python3"
        return 0
    fi

    # 4. Try python
    if command -v python &> /dev/null; then
        echo "python"
        return 0
    fi

    return 1
}

PYTHON_CMD=$(find_python)
if [[ -z "$PYTHON_CMD" ]]; then
    # No Python available - silently exit
    exit 0
fi

# Run the linter
$PYTHON_CMD "$LINT_SCRIPT" --hook
