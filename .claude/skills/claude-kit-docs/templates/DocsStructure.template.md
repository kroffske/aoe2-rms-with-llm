# Documentation Structure Template

Component-based Technical Solution docs with a flat layout.

## Flat Structure

```
docs/
├── <system>/
│   ├── README.md
│   └── references/
│       ├── diagrams.md
│       ├── workflows.md
│       ├── interfaces.md
│       ├── configs.md
│       └── decisions.md
├── <component-a>/
│   ├── README.md
│   └── references/
│       └── <topic>.md
└── <component-b>/
    ├── README.md
    └── references/
        └── <topic>.md
```

## Rules

- Only one level under `docs/`: component directories.
- Only allowed subfolder: `references/`.
- Keep `README.md` as the Technical Solution for the component.
- If a subsystem adds diagrams or workflows, give it its own component folder.
- Use kebab-case component names (`docs/model-agent/`).

## File Purposes

| Path | Purpose | Update Frequency |
| --- | --- | --- |
| `docs/<component>/README.md` | Component Technical Solution | On architecture changes |
| `docs/<component>/references/*.md` | Detailed diagrams, specs, decision logs | When details change |

## Navigation Pattern

- The top-level system component links to all subcomponents.
- Each component links back to the top-level system and its own references.

Example:
```
docs/platform/README.md
  -> docs/api-gateway/README.md
  -> docs/model-agent/README.md
  -> docs/runtime/README.md
```

## Diagram Distribution

- `README.md`: 2-4 diagrams max (as-is, to-be, key flow).
- `references/*.md`: detailed component, sequence, or data flow diagrams.

## Reference Doc Suggestions

- `references/diagrams.md` — detailed diagrams and notation
- `references/workflows.md` — sequences and operational flows
- `references/interfaces.md` — API/event contracts
- `references/configs.md` — configuration matrices
- `references/decisions.md` — ADR-style decisions
