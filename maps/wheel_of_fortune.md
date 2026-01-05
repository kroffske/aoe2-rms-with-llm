# Wheel of Fortune - RMS Map

## Concept

FFA map for 8 players in wheel shape with **Christmas tree** in center:

- **Players close to center** — `direct_placement` with fixed positions between spokes
- **Christmas tree** — triangular tree made of SNOW_PINE_TREE pointing to TOP corner
- **15 relics as ornaments** — scattered across the tree
- **Spokes with gold** — 8 rays (DIRT_SNOW terrain) from center to edges
- **Outer rim with stone** — DIRT_SNOW terrain around perimeter
- **ICE between spokes** — prevents walling
- **Winter biome** — SNOW base terrain

## Key Features

- **Can't wall** — neighbors too close + ICE between spokes
- **Gold** — on spokes, single tiles spread out
- **Stone** — on outer rim (far from center)
- **Relics** — 15 on the Christmas tree (ornaments!)

---

# How to Build a Christmas Tree in RMS

> This guide explains how to build complex decorative shapes with objects (relics) on forest terrain.

## The Challenge

Forest terrains (SNOW_FOREST, PINE_FOREST, etc.) auto-generate trees, making it impossible to place relics or other objects. We need a technique to:
1. Create tree-shaped landmass
2. Place relics as ornaments
3. Fill with trees

## Solution: Placeholder Terrain + Trees as Objects

### Step 1: Use Non-Forest Terrain

Instead of SNOW_FOREST, use a terrain that doesn't auto-generate trees:

```rms
/* Use GRASS_SNOW (34) - snowy look, no auto-trees */
create_land {
  terrain_type GRASS_SNOW
  number_of_tiles 9
  base_size 1
  land_position 57 43
  zone 2
  land_id 42
}
```

**Good placeholder terrains**: GRASS_SNOW, DIRT3, GRASS2, GRASS3, DIRT2

### Step 2: Build Triangle Shape

The map is a **rhombus**. To point triangle to TOP corner:
- **Tip direction**: +X, -Y
- **Row spread**: +1X/+1Y per block within row

```rms
/* Tier with 3 rows, tip at (57, 43) */

/* Row 1: 1 block (tip) */
create_land { terrain_type GRASS_SNOW land_position 57 43 land_id 42 }

/* Row 2: 2 blocks */
create_land { terrain_type GRASS_SNOW land_position 56 43 land_id 42 }
create_land { terrain_type GRASS_SNOW land_position 57 44 land_id 42 }

/* Row 3: 3 blocks */
create_land { terrain_type GRASS_SNOW land_position 55 43 land_id 42 }
create_land { terrain_type GRASS_SNOW land_position 56 44 land_id 42 }
create_land { terrain_type GRASS_SNOW land_position 57 45 land_id 42 }
```

### Step 3: Stack Multiple Tiers

For Christmas tree effect, stack tiers with increasing size:

```
Tier 1: 3 rows (tip at 57,43)
Tier 2: 6 rows (tip below Tier 1 base)
Tier 3: 7 rows
Tier 4: 9 rows
Tier 5: 10 rows (base)
```

**Moving DOWN** between tiers: -X, +Y direction

### Step 4: Place Relics FIRST in OBJECTS_GENERATION

Objects are placed in script order. Place relics before trees:

```rms
<OBJECTS_GENERATION>

/* RELICS FIRST - before trees! */
create_object RELIC {
  set_gaia_object_only
  number_of_objects 15
  terrain_to_place_on GRASS_SNOW
  temp_min_distance_group_placement 5  /* spread apart */
}

/* THEN trees fill remaining space */
create_object SNOW_PINE_TREE {
  set_gaia_object_only
  number_of_objects 1
  number_of_groups 1000  /* many groups = uniform fill */
  terrain_to_place_on GRASS_SNOW
}
```

### Step 5: Protect from CONNECTION_GENERATION

Paths can destroy your tree! Use `terrain_cost` instead of `replace_terrain`:

```rms
<CONNECTION_GENERATION>
create_connect_all_players_land {
  /* DO NOT use replace_terrain GRASS_SNOW! */
  terrain_cost GRASS_SNOW 50  /* paths go around tree */
  terrain_cost SNOW 1
  terrain_cost GRASS 1
}
```

## Complete Example Structure

```
wheel_of_fortune.rms structure:

<LAND_GENERATION>
  base_terrain SNOW
  create_player_lands { ... }      /* 8 players with direct_placement */
  create_land { ICE center }       /* ICE circle for tree base */

  /* CHRISTMAS TREE - 5 tiers */
  /* All use GRASS_SNOW terrain */
  Tier 1: 3 rows, tip (57,43)
  Tier 2: 6 rows, tip (56,44)
  Tier 3: 7 rows, tip (55,45)
  Tier 4: 9 rows, tip (53,47)
  Tier 5: 10 rows, tip (51,49)

  /* TRUNK */
  create_land { DESERT } /* 4 rows below tree */

  /* SPOKES - 8 directions */
  create_land { DIRT_SNOW } /* gold placement */

  /* OUTER RIM */
  create_land { DIRT_SNOW } /* stone placement */

<CONNECTION_GENERATION>
  terrain_cost GRASS_SNOW 50  /* protect tree */

<OBJECTS_GENERATION>
  /* 1. RELICS on tree (first!) */
  create_object RELIC { terrain_to_place_on GRASS_SNOW }

  /* 2. TREES on tree (after relics) */
  create_object SNOW_PINE_TREE { terrain_to_place_on GRASS_SNOW }

  /* 3. BAOBAB on trunk */
  create_object DLC_BAOBABTREE { terrain_to_place_on DESERT }

  /* 4. Resources on spokes/rim */
  create_object GOLD { terrain_to_place_on DIRT_SNOW }
  create_object STONE { terrain_to_place_on DIRT_SNOW }
```

## Key Lessons Learned

### 1. Coordinate System
- Map is **rhombus**, not square
- TOP corner: (90, 10)
- CENTER: (50, 50)
- See `docs/rms/coordinates.md`

### 2. Forest Terrain = Auto Trees
- SNOW_FOREST, PINE_FOREST, JUNGLE, FOREST all auto-fill with trees
- Can't place objects on them
- Use placeholder terrain + tree objects instead

### 3. Object Placement Order
- Objects placed in script order
- Place important objects (relics) BEFORE trees
- `number_of_objects 1` + `number_of_groups N` = uniform distribution

### 4. Terrain Restrictions
- ROAD: can't place trees or resources
- BEACH: limited object placement
- ICE: decorations only
- Use GRASS_SNOW, DIRT, GRASS for full compatibility

### 5. CONNECTION_GENERATION Destroys Terrain
- `replace_terrain` will delete your decorative lands
- Use `terrain_cost 50` to make paths go around

### 6. Land Size Matters
- `number_of_tiles 1` often too small, lands disappear
- Use `number_of_tiles 9` + `base_size 1` for reliable 3x3 blocks
- Spacing of 1 unit between blocks for solid fill

## Scripts

Helper scripts in `scripts/`:
- `shift_tree.py` — shift all tree coordinates by X/Y amount
- `generate_tier.py` — generate RMS code for triangle tier

## Testing

```bash
# Validate syntax
./rms-check/target/release/rms-check maps/wheel_of_fortune.rms --de

# Copy to game
cp maps/wheel_of_fortune.rms "/mnt/c/Users/<USERNAME>/Games/Age of Empires 2 DE/<STEAM_UID>/resources/_common/random-map-scripts/"
```

## Files

- `wheel_of_fortune.rms` — main map file
- `wheel_of_fortune.md` — this documentation

---

## Discoveries: Winter Wildlife & Terrain

### Working Animal Constants (DE)

| Constant | ID | Notes |
|----------|-----|-------|
| `DLC_PENGUIN` | 639 | Works! Needs `#const` definition |
| `DLC_SNOWLEOPARD` | built-in | Snow leopard, predator |
| `DLC_GOOSE` | 1243 | Goose flocks |
| `BEAR` | built-in | Brown bear |
| `WOLF` | built-in | Wolf |
| `MARLIN` | built-in | Deep water fish |
| `TUNA` | built-in | Deep water fish |
| `SHORE_FISH` | built-in | Works in small water patches |

### Arctic Animals (Unconfirmed IDs)

These were added in update 141935 (Dec 2024). IDs may be wrong:

```rms
#const POLAR_BEAR 1970   /* Unconfirmed */
#const ARCTIC_HARE 1966  /* Unconfirmed - gives food */
#const ARCTIC_FOX 1968   /* Unconfirmed - gives gold! */
#const ARCTIC_WOLF 1964  /* Unconfirmed */
```

Source: [AoE2 Fandom - Animals](https://ageofempires.fandom.com/wiki/Animal)

### Color Correction (Winter Mood)

```rms
<TERRAIN_GENERATION>
  color_correction CC_WINTER   /* Winter atmosphere */
```

Available: `CC_DEFAULT`, `CC_AUTUMN`, `CC_WINTER`, `CC_JUNGLE`, `CC_DESERT`

### Frozen Lakes on ICE

Create water patches on outer ICE for fish:

```rms
create_terrain WATER {
  base_terrain ICE
  land_percent 4
  number_of_clumps 24
  clumping_factor 3
  spacing_to_other_terrain_types 8
  set_avoid_player_start_areas
}
```

### What Doesn't Work

1. **`create_connect_same_land_zones` with many small lands** — crashes game
2. **ICE border around DIRT_SNOW via terrain** — `spacing_to_other_terrain_types 0` doesn't stick to specific terrain
3. **Terrain surrounding another terrain** — RMS has no direct way to "border" one terrain with another

### Zetnus RMS Pack Constants

Extract custom constants from Zetnus pack:
```
C:\Users\<USERNAME>\Games\Age of Empires 2 DE\<STEAM_UID>\mods\subscribed\2861_Zetnus Random Map Script Pack\resources\_common\random-map-scripts\
```

Example from `ZN@Antarctica.rms`:
```rms
#const SPAWN_PENGUIN 1029  /* Different ID than DLC_PENGUIN! */
```

### Steam Screenshots Path

```
C:\Program Files (x86)\Steam\userdata\<STEAM_UID>\760\remote\813780\screenshots
```

Or via Steam: **View → Screenshots → Show on disk**
