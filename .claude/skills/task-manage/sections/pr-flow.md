# PR/Merge Flow

## Branch Naming

```
feat/GH<N>-short-description
fix/GH<N>-short-description
```

## PR Creation

```bash
git checkout -b feat/GH<N>-slug
# ... work ...
git push -u origin feat/GH<N>-slug
gh pr create --base dev --title "feat: description - Closes #<N>"
```

## Closing Keywords

In PR body, use:
- `Closes #<N>` - auto-closes issue on merge
- `Fixes #<N>` - same
- `Resolves #<N>` - same

## Default Branch

Note: Check repo default branch (`dev` vs `main`) before creating PR.
