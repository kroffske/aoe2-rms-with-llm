# Pixel Art with Land Blocks in RMS

## Basics

### Block Size
- `base_size 1` creates **3x3 tiles** origin
- `number_of_tiles 9` = one full 3x3 block
- On a 220x220 map: 1 coordinate ≈ 2.2 tiles

### Origin Size Formula
```
origin_size = (base_size × 2 + 1)²
base_size 0 = 1×1 (may not work!)
base_size 1 = 3×3 = 9 tiles
base_size 2 = 5×5 = 25 tiles
base_size 3 = 7×7 = 49 tiles (default!)
```

## Spacing for Solid Fill

### Problem
If spacing is too large — **gaps** appear between blocks.

### Solution
For 3x3 blocks use **spacing = 1** in coordinates:
```rms
/* Blocks with spacing 1 — overlap, create solid fill */
create_land { land_position 50 50 ... }
create_land { land_position 51 50 ... }  /* X+1 */
create_land { land_position 50 51 ... }  /* Y+1 */
```

### Verified
- Spacing 2-3: visible gaps
- Spacing 1: blocks merge into solid shape

## Building a Triangle (Christmas Tree)

### Rhombus Coordinate System
```
              TOP (90, 10)
                 /\
                /  \
   LEFT (10,10)      RIGHT (90, 90)
                \  /
                 \/
             BOTTOM (10, 90)
```

### Directions from Center (50, 50)
| Direction   | Delta X | Delta Y |
|-------------|---------|---------|
| To TOP      | +X      | -Y      |
| To BOTTOM   | -X      | +Y      |
| To LEFT     | -X      | -Y      |
| To RIGHT    | +X      | +Y      |

### Triangle Pointing to TOP
```rms
/* Each row expands diagonally LEFT↔RIGHT */

/* Row 1: tip */
create_land { land_position 54 46 ... }

/* Row 2: 2 blocks */
create_land { land_position 53 46 ... }  /* to LEFT: X-1 */
create_land { land_position 54 47 ... }  /* to RIGHT: Y+1 */

/* Row 3: 3 blocks */
create_land { land_position 52 46 ... }
create_land { land_position 53 47 ... }
create_land { land_position 54 48 ... }
```

### Multi-Tier Tree
For tiers like a real Christmas tree:
- Tier 2 tip should be **below** Tier 1 tip
- Direction: -X, +Y from tip to tip
- Tier 1 tip (54, 46) → Tier 2 tip (53, 47) → Tier 3 tip (52, 48)

```
     /\        Tier 1 (GRASS)
    /__\
     /\        Tier 2 (SNOW_FOREST)
    /  \
   /____\
```

## Connection Generation — IMPORTANT!

### Problem
`replace_terrain` in connection_generation **deletes** terrain!

```rms
/* BAD — will delete the entire tree! */
create_connect_all_players_land {
  replace_terrain SNOW_FOREST SNOW
}
```

### Solution
```rms
/* GOOD — don't replace tree terrain */
create_connect_all_players_land {
  terrain_cost SNOW_FOREST 50  /* high cost = paths go around */
  /* DO NOT use replace_terrain for tree terrain! */
}
```

## Direct Placement

### When to Use
For **fixed** player positions (e.g., between wheel spokes).

### Syntax
```rms
<PLAYER_SETUP>
  direct_placement

<LAND_GENERATION>
  /* Each player — separate create_land */
  create_land {
    terrain_type GRASS
    land_percent 1
    land_position 61 24
    assign_to_player 1
  }
```

### Limitation
`genie-rms` preview does NOT support direct_placement correctly — test in game!
