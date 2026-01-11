# Export Folder to Single File

Export all files from a folder (respecting .gitignore) into a single file.

## Usage

```
/export <folder_path> [output_file]
```

**Arguments** (via `$ARGUMENTS`):
- `folder_path` — folder to export (required)
- `output_file` — output file path (optional, default: `export.txt`)

## Examples

```bash
/export src/              # Export src/ to export.txt
/export lib output.md     # Export lib/ to output.md
/export . context.txt     # Export entire repo to context.txt
```

---

## Script

Execute the following bash script:

```bash
#!/bin/bash
set -euo pipefail

# Parse arguments
args=($ARGUMENTS)
folder_path="${args[0]:-}"
output_file="${args[1]:-export.txt}"

# Validate folder path
if [[ -z "$folder_path" ]]; then
    echo "Error: folder_path is required"
    echo ""
    echo "Usage: /export <folder_path> [output_file]"
    echo ""
    echo "Examples:"
    echo "  /export src/"
    echo "  /export lib output.md"
    exit 1
fi

# Remove trailing slash for consistency
folder_path="${folder_path%/}"

# Check if folder exists
if [[ ! -d "$folder_path" ]]; then
    echo "Error: folder '$folder_path' does not exist or is not a directory"
    exit 1
fi

# Get git root for relative path calculation
git_root=$(git rev-parse --show-toplevel 2>/dev/null) || {
    echo "Error: not a git repository"
    exit 1
}

# Get files using git ls-files (respects .gitignore)
files=$(git ls-files "$folder_path" 2>/dev/null)

if [[ -z "$files" ]]; then
    echo "Error: no tracked files found in '$folder_path'"
    echo "Hint: files must be tracked by git (not in .gitignore)"
    exit 1
fi

# Clear output file
> "$output_file"

# Count files
file_count=$(echo "$files" | wc -l)

# Export each file
while IFS= read -r file; do
    # Get path relative to git root
    rel_path=$(realpath --relative-to="$git_root" "$file" 2>/dev/null || echo "$file")

    # Write source header
    echo "# source://$rel_path" >> "$output_file"

    # Write file content
    cat "$file" >> "$output_file"

    # Add newline separator
    echo "" >> "$output_file"
done <<< "$files"

echo "Exported $file_count files from '$folder_path' to '$output_file'"
```

---

## Output Format

Each file in the output is prefixed with a source comment:

```
# source://path/to/file.py
<file content>

# source://path/to/another.js
<file content>
```

Paths are relative to the repository root.

---

## Notes

- Uses `git ls-files` — only tracked files are exported
- Respects `.gitignore` automatically
- Binary files are included but may not display correctly
- For large exports, consider using a specific subfolder
