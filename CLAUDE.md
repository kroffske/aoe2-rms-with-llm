# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Purpose

This repository is dedicated to **creating Age of Empires II Random Map Scripts (RMS)**. The goal is to enable Claude to generate .rms map files based on user descriptions or reference images.

## RMS Generation Workflow

### Step 1: UNDERSTAND — Parse the Request

Identify the map archetype from user description:

| Keyword | Archetype | Key Settings |
|---------|-----------|--------------|
| "islands", "water" | Islands | `base_terrain WATER`, zones for separation |
| "team islands", "2v2" | Team Islands | `set_zone_by_team`, `create_connect_teams_lands` |
| "arabia", "open", "land" | Arabia | `base_terrain GRASS`, scattered forests |
| "arena", "walled" | Arena | Forest ring around players |
| "nomad" | Nomad | `nomad_resources`, no starting TC |
| "black forest" | Black Forest | Dense forests, narrow paths |
| "regicide" | Regicide | Add KING, usually CASTLE + extra villagers |

### Step 2: GENERATE — Write Complete .rms

Write all sections in order, referencing section docs:

1. **<PLAYER_SETUP>** → `docs/rms/01-player-setup.md`
2. **<LAND_GENERATION>** → `docs/rms/02-land-generation.md`
3. **<ELEVATION_GENERATION>** → `docs/rms/03-elevation-generation.md`
4. **<TERRAIN_GENERATION>** → `docs/rms/05-terrain-generation.md`
5. **<CONNECTION_GENERATION>** → `docs/rms/07-connection-generation.md`
6. **<OBJECTS_GENERATION>** → `docs/rms/06-objects-generation.md`

### Step 3: VALIDATE — Check and Iterate

```bash
cd rms-check && cargo build --release
./target/release/rms-check path/to/map.rms --de
```

Fix any errors, iterate until clean.

### Quick Patterns

**Arabia-style (open land):**
```rms
base_terrain GRASS
create_player_lands { terrain_type GRASS land_percent 30 }
```

**Islands (separated by water):**
```rms
base_terrain WATER
create_player_lands { terrain_type GRASS land_percent 25 zone 1 other_zone_avoidance_distance 10 }
```

**Team Islands:**
```rms
base_terrain WATER
create_player_lands { terrain_type GRASS set_zone_by_team other_zone_avoidance_distance 8 }
```

### Appendices
- `docs/rms/appendices/game-modes.md` — Regicide, Nomad, Empire Wars, Death Match
- `docs/rms/appendices/standard-resources-de.md` — Exact DE starting resource specs

## What is RMS?

Random Map Scripts are plain text files (.rms extension) that instruct the AoE2 game engine to procedurally generate maps. Unlike static scenarios, RMS produces unique maps every time.

## RMS File Structure

Scripts are processed sequentially, top to bottom. The six primary sections must appear in order:

1. `<PLAYER_SETUP>` - Player configuration, team layouts, global rules
2. `<LAND_GENERATION>` - Landmasses and water bodies (the canvas)
3. `<ELEVATION_GENERATION>` - Hills and height variations
4. `<TERRAIN_GENERATION>` - Surface features: forests, deserts, patches
5. `<CONNECTION_GENERATION>` - Guaranteed paths between areas
6. `<OBJECTS_GENERATION>` - Units, resources, relics, decorations

## Core Syntax

```rms
command {
  attribute argument
  attribute argument
}
```

- Commands: `create_land`, `create_object`, `create_terrain`
- Attributes: `terrain_type`, `number_of_objects`, `min_distance_to_players`
- Arguments: Constants like `GRASS`, `GOLD`, or numeric values

## Key Concepts

### Critical Land Generation Rules

1. **base_size default = 7×7 tiles!**
   - Default `base_size 3` creates 49-tile origin square
   - For 1-tile lands: **always use `base_size 0`**
   ```rms
   /* WRONG */ create_land { number_of_tiles 1 land_position 50 50 }
   /* RIGHT */ create_land { number_of_tiles 1 base_size 0 land_position 50 50 }
   ```

2. **Land generation order:**
   - Origins placed sequentially (script order)
   - All lands grow simultaneously after
   - Later lands win overlaps

3. **Lands compete for space** - may be smaller than specified if constrained

### Land Generation
- `base_terrain` - Sets the map canvas (e.g., `WATER` for islands, `GRASS` for land maps)
- `create_player_lands` - Creates starting areas for each player
- `create_land` - Creates neutral/shared landmasses
- `circle_radius` - Controls player spread from center

### Object Placement Order Matters
Objects are placed sequentially. Place critical objects (Town Centers, starting resources) first. Later objects may fail to spawn if space is exhausted.

### Sticky vs Temporary Spacing
- `temp_min_distance_group_placement` - Affects only current command
- `min_distance_group_placement` - **Persists and accumulates** (common pitfall)

### Conditional Logic
```rms
if 2_PLAYER_GAME
  number_of_clumps 10
elseif 4_PLAYER_GAME
  number_of_clumps 20
endif
```

### Controlled Randomness
```rms
start_random
  percent_chance 40 land_percent 52
  percent_chance 30 land_percent 40
  percent_chance 30 land_percent 25
end_random
```

## Available Tools

### rms-check (in `rms-check/` subdirectory)
A Rust-based linter and language server for RMS files.

Build and run:
```bash
cd rms-check
cargo build --release
./target/release/rms-check path/to/map.rms
```

Subcommands:
- `check` - Lint a script
- `fix` - Auto-fix problems
- `format` - Format the file
- `pack/unpack` - Handle Zip-RMS maps

Compatibility flags: `--de`, `--aoc`, `--hd`, `--wk`, `--up14`, `--up15`

## Documentation Resources

### Section Checklists (docs/rms/)
Detailed guides for each RMS section with attributes, examples, and checklists:

- `docs/rms/00-overview.md` - RMS syntax overview, conditionals, DE features
- `docs/rms/01-player-setup.md` - Player configuration, placement modes
- `docs/rms/02-land-generation.md` - Land creation, zones, positioning
- `docs/rms/03-elevation-generation.md` - Hills, enable_balanced_elevation
- `docs/rms/04-cliff-generation.md` - Cliff parameters
- `docs/rms/05-terrain-generation.md` - Forests, terrain patches
- `docs/rms/06-objects-generation.md` - Resources, units, spacing rules
- `docs/rms/07-connection-generation.md` - Paths between lands
- `docs/rms/08-constants-de.md` - Complete DE constants reference

### Appendices (docs/rms/appendices/)
- `game-modes.md` - Regicide, Nomad, Empire Wars, Death Match, Battle Royale
- `standard-resources-de.md` - Exact DE starting resource distances and counts

### External Guides
- `docs/main-guide.md` - Zetnus's Definitive RMS Guide (comprehensive)
- `docs/notebooklm.md` - Condensed tutorial for map scripting

## Reference Files

Definition files with terrain/object constants:
- `rms-check/crates/rms-check/src/def_de.rms` - Definitive Edition constants
- `rms-check/crates/rms-check/src/def_aoc.rms` - Age of Conquerors constants

Example maps in `rms-check/crates/rms-check/tests/rms/`:
- `Dry Arabia.rms` - Good example of conditional terrain switching
- `CM_Houseboat_v2.rms` - Water-based map example

## Common Terrain Constants

```rms
GRASS 0, WATER 1, BEACH 2, SHALLOW 4, FOREST 10,
DIRT 6, DESERT 14, PALM_DESERT 13, PINE_FOREST 19,
SNOW 32, SNOW_FOREST 21, JUNGLE 17, BAMBOO 18
```

## Common Object Constants

```rms
BOAR 48, DEER 65, GOLD 66, STONE 102,
FORAGE 59, RELIC 285, VILLAGER 83,
TOWN_CENTER 109, SCOUT 448
```

## Debugging Tips

1. Use fixed seed in Scenario Editor to reproduce exact layouts
2. Comment out sections with `/* ... */` to isolate issues
3. Set `number_of_objects 10000` temporarily to visualize all valid spawn locations
4. Use bright terrain (SNOW) as placeholder to see land shapes on minimap

### In-Game Minimap Extraction

Alternative to rms-preview: capture minimap directly from AoE2 DE Scenario Editor.

**Setup (one time):**
```bash
# Copy .env.example and set your Steam User ID
cp .env.example .env
# Edit .env with your Steam User ID from:
# C:\Program Files (x86)\Steam\userdata\<YOUR_ID>\
```

**Workflow:**
1. Open AoE2 DE → Scenario Editor
2. Load your RMS map (Random Map → select map → Generate Map)
3. Press **F12** to take Steam screenshot
4. Run extraction script:

```bash
python scripts/extract-minimap.py output/my_map_minimap.png
```

The script automatically finds the latest screenshot and crops the minimap.

**Why use this instead of rms-preview?**
- Verifies actual game rendering (ground truth)
- No Docker/Node.js setup required
- Shows exact terrain colors as in game
- Good for comparing rms-preview accuracy

**Note:** Calibrated for 2560x1440 resolution. May need adjustment for other resolutions.

## Installing Maps to Game

**Path placeholders:**
- `<USERNAME>` - Windows username (e.g., `JohnDoe`)
- `<STEAM_UID>` - Steam User ID (numeric, e.g., `123456789012345678`)

Find your Steam UID in: `C:\Program Files (x86)\Steam\userdata\<YOUR_ID>\`

**Copy RMS to AoE2 DE (Windows via WSL):**

```bash
# Copy single map
cp maps/your_map.rms "/mnt/c/Users/<USERNAME>/Games/Age of Empires 2 DE/<STEAM_UID>/resources/_common/random-map-scripts/"

# Copy all maps from maps/ folder
cp maps/*.rms "/mnt/c/Users/<USERNAME>/Games/Age of Empires 2 DE/<STEAM_UID>/resources/_common/random-map-scripts/"
```

**Path structure:**
```
C:\Users\<USERNAME>\Games\Age of Empires 2 DE\<STEAM_UID>\resources\_common\random-map-scripts\
```

**Subscribed mods location:**
```
C:\Users\<USERNAME>\Games\Age of Empires 2 DE\<STEAM_UID>\mods\subscribed\
```

Useful for extracting constants from community RMS packs (e.g., Zetnus Random Map Script Pack).

**In game:**
1. Single Player → Skirmish
2. Map Style → **Custom**
3. Select your map from the list

**Note:** If map doesn't appear, restart the game.

## Known Limitations

### rms-preview Tool

The `rms-preview/` directory contains a Node.js-based RMS preview tool using a customized `genie-rms` library.

**Running rms-preview:**

The tool uses Docker to avoid native dependency issues with the `canvas` npm package.

```bash
# Build Docker image (first time only, from project root)
./rms-preview/scripts/docker-build.sh

# Generate map preview (8-player Houseboat example)
./rms-preview/scripts/rms-preview.sh \
  rms-check/crates/rms-check/tests/rms/CM_Houseboat_v2.rms \
  --players 8 --size large --scale 3 -o output/houseboat_8p.png

# Generate Dry Arabia 4v4
./rms-preview/scripts/rms-preview.sh \
  "rms-check/crates/rms-check/tests/rms/Dry Arabia.rms" \
  --players 8 --size large --scale 2 -o output/dry_arabia_8p.png
```

**CLI Options:**
- `--players N` - Number of players (2-8)
- `--size SIZE` - Map size: tiny|small|medium|large|giant|ludicrous
- `--scale N` - Pixels per tile (1-4, higher = bigger PNG)
- `--seed N` - Random seed for reproducible maps
- `-o PATH` - Output PNG path

**How it works:**
- `docker-build.sh` builds the image with all native dependencies and copies `genie-rms-de/` into `node_modules/genie-rms`
- `rms-preview.sh` runs the preview tool inside the container

**Why Docker?**
- Node 22+ has no prebuilt `canvas` binaries
- Building from source requires: `libcairo2-dev libpango1.0-dev libjpeg-dev libgif-dev librsvg2-dev libpixman-1-dev`
- Docker image bundles everything and handles the genie-rms setup automatically

**Limitations:**

1. **Custom genie-rms**: We maintain `genie-rms-de/` with enhancements over upstream:
   - **Map size support**: Supports all sizes up to 240x240 (ludicrous), not limited to 120x120
   - **numPlayers**: Properly passes player count through the generation pipeline
   - **circle_radius**: Implements circular player placement
   - **actor_area**: Supports actor_area placement constraints
   - **Custom terrain colors**: Local color overrides for better visual differentiation

2. **Player Positions**: Extracted from `controller.parser.lands` after generation to ensure they match terrain.

## Repository Structure

```
aoe2-rms/
├── docs/
│   ├── rms/                    # RMS section documentation
│   │   ├── 00-overview.md
│   │   ├── 01-player-setup.md
│   │   └── ...
│   └── research/               # Completed research artifacts
│       └── rms-preview-port/   # Rust port feasibility study
│
├── maps/                       # Custom RMS maps
│   ├── wheel_of_fortune.rms    # Example: FFA map with central spawn
│   ├── wheel_of_fortune.md     # Map documentation + dev notes
│   └── *.rms                   # Other maps
│
├── genie-rms-de/               # Customized genie-rms for Definitive Edition
│   └── src/
│       ├── Parser.js           # circle_radius support
│       ├── ObjectsGenerator.js # actor_area support
│       ├── MinimapRenderer.js  # Custom terrain colors
│       └── terrainColors.json  # Color overrides
│
├── rms-check/                  # Rust-based RMS linter (submodule)
│
├── rms-preview/                # Node.js preview generator
│   ├── src/
│   ├── scripts/
│   │   ├── docker-build.sh    # Build Docker image
│   │   └── rms-preview.sh     # Run preview in container
│   ├── Dockerfile
│   └── package.json
│
├── scripts/                    # Utility scripts
│   └── extract-minimap.py     # Extract minimap from Steam screenshot
│
├── tasks/                      # Epic tracking
│   └── done/                   # Completed epics with artifacts
│
└── output/                     # Generated previews (gitignored)
```

### Key Directories

| Directory | Purpose |
|-----------|---------|
| `docs/rms/` | RMS syntax documentation by section |
| `docs/research/` | Completed research (feasibility studies, architecture analysis) |
| `maps/` | Custom .rms files with documentation |
| `genie-rms-de/` | Customized genie-rms with DE enhancements and color fixes |
| `rms-preview/` | Preview tool with Docker workflow |
| `tasks/done/` | Closed epics with artifacts |

### Conventions

- **Map documentation**: Each significant map has a `mapname.md` alongside `mapname.rms`
- **Research artifacts**: Stored in `docs/research/<topic>/` with date prefix
- **Epics**: Use `tasks/YYYY-MM-DD-slug/` format, move to `tasks/done/` when complete
- **Generated files**: `output/` is gitignored; previews are regenerated as needed
