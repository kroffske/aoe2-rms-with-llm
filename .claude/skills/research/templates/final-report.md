# Template: Final Report

Use for the single consolidated report in `docs/research/<topic>/README.md`.

---

# Research Report: {Title}

**Date:** YYYY-MM-DD
**Complexity:** X/10 ({mode} mode)
**Status:** completed | partial | inconclusive
**Verdict:** DO / DON'T / PARTIAL
**Confidence:** X%

## TL;DR
- <top finding>
- <top finding>
- <top finding>

## How to read
- Start with Results for what works and what does not.
- See Methods for what was tried.
- Figures are embedded near the relevant sections.
- Appendix contains supporting detail.

## Problem statement
<What decision/question this research answers>

## Scope
**IN:**
- <item>

**OUT:**
- <item>

## Data and assumptions
- Sources:
- Time range:
- Assumptions/constraints:

## Methods and experiments
| ID | Method | Data/Features | Model | Metric | Result | Notes |
|---|---|---|---|---|---|---|
| E1 | | | | | | |

## Results
### What works
- <bullet>

### What does not work
- <bullet>

## Feature groups (if ML/DS)
### Engineered / technical
- <bullet>

### Generated / LAMP / LLM
- <bullet>

### Other sources
- <bullet>

## Model and training (if ML/DS)
- Model(s):
- Training setup:
- Key hyperparameters:

## Validation (if ML/DS)
- Protocol: holdout / k-fold
- Folds:
- Leakage checks:
- Notes:

## Figures
![<caption>](figures/<file>)

## Risks and limitations
- <bullet>

## Recommendations / next steps
- <bullet>

## Artifacts and references
- `tasks/.../artifacts/...` - <what it contains>
- `docs/research/<topic>/appendix.md` - <if used>

## Appendix (optional)
<Place detailed tables, raw metrics, and long notes here or in appendix.md>
