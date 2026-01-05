# AoE2 RMS - Random Map Scripts for Age of Empires II DE

Documentation and examples for creating custom random maps for Age of Empires II: Definitive Edition.

## What is RMS?

Random Map Scripts are plain text files (`.rms` extension) that instruct the AoE2 game engine to procedurally generate maps. Unlike static scenarios, RMS produces unique maps every time.

## Repository Contents

```
aoe2-rms/
├── docs/rms/        # RMS syntax documentation by section
├── maps/            # Example .rms maps with documentation
└── CLAUDE.md        # AI assistant instructions for map generation
```

## Documentation

Core RMS sections (read in order):

1. `docs/rms/00-overview.md` - Syntax basics, conditionals, DE features
2. `docs/rms/01-player-setup.md` - Player configuration
3. `docs/rms/02-land-generation.md` - Land creation, zones
4. `docs/rms/03-elevation-generation.md` - Hills
5. `docs/rms/05-terrain-generation.md` - Forests, terrain patches
6. `docs/rms/06-objects-generation.md` - Resources, units
7. `docs/rms/07-connection-generation.md` - Paths between lands

Reference:
- `docs/rms/08-constants-de.md` - Complete DE constants
- `docs/rms/appendices/` - Game modes, standard resources
- `docs/main-guide.md` - Comprehensive RMS guide (based on community documentation)

External:
- [RMS Guide (Google Doc)](https://docs.google.com/document/d/1jnhZXoeL9mkRUJxcGlKnO98fIwFKStP_OBozpr0CHXo/edit) - Definitive RMS reference
- [Zetnus RMS Syntax for Notepad++](https://github.com/Zetnus/Notepadplusplus-AoE2-RMS-Syntax-Highlighting) - Syntax highlighting (may be useful)

## Example Maps

| Map | Description |
|-----|-------------|
| `maps/wheel_of_fortune.rms` | FFA 8-player map with central Christmas tree, gold spokes, ICE barriers |
| `maps/simple_arabia.rms` | Basic open land map |
| `maps/simple_islands.rms` | Basic water map with separated islands |

## Testing Maps

1. Copy `.rms` to game folder:
   ```bash
   cp maps/your_map.rms "/mnt/c/Users/<USERNAME>/Games/Age of Empires 2 DE/<STEAM_UID>/resources/_common/random-map-scripts/"
   ```

2. In game: **Scenario Editor** → **Random Map** → Select map → **Generate Map**

3. Edit `.rms` → Regenerate (no restart needed)

## Using with AI

The `CLAUDE.md` file contains structured instructions for AI assistants (Claude Code, etc.) to generate RMS files from natural language descriptions or reference images.

## Visualization Tools

For AI-assisted workflows, visualization tools can accelerate iteration by generating map previews without launching the game. See `TOOLS.md` for details and links to upstream projects.

**Note:** These tools are not included in the repository and may require modifications for full DE support. For most use cases, in-game Scenario Editor testing is sufficient.

## License

Documentation and example maps: MIT

## Acknowledgments

- Zetnus for the Notepad++ syntax highlighting
- [SiegeEngineers](https://github.com/SiegeEngineers) for rms-check
- [genie-js](https://github.com/genie-js) for genie-rms
- The AoE2 modding community for the RMS documentation

---

*Age of Empires II is a trademark of Microsoft Corporation. This project is fan-made and not affiliated with Microsoft or Xbox Game Studios.*
