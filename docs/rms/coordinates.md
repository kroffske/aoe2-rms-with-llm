# RMS Coordinate System (Rhombus Map)

> **Verified in game 2026-01-05** on wheel_of_fortune.rms

## land_position Mapping

The game map is a **rhombus (diamond)** shape. The `land_position X Y` coordinates map as follows:

```
              TOP corner
              (90, 10)
                 /\
                /  \
               /    \
   LEFT corner        RIGHT corner
    (10, 10)          (90, 90)
               \    /
                \  /
                 \/
             BOTTOM corner
              (10, 90)
```

## Corner Coordinates

| Corner | X | Y | Direction from Center |
|--------|---|---|----------------------|
| TOP    | 90 | 10 | +X, -Y |
| RIGHT  | 90 | 90 | +X, +Y |
| BOTTOM | 10 | 90 | -X, +Y |
| LEFT   | 10 | 10 | -X, -Y |

## Center

- Center of map: **(50, 50)**
- Center line (diagonal): X + Y = 100

## Edge Midpoints

| Edge | X | Y |
|------|---|---|
| TOP-RIGHT edge midpoint | 90 | 50 |
| RIGHT-BOTTOM edge midpoint | 50 | 90 |
| BOTTOM-LEFT edge midpoint | 10 | 50 |
| LEFT-TOP edge midpoint | 50 | 10 |

## Building Diagonal Shapes

For a triangle pointing to **TOP** corner:
- **Tip direction**: +X, -Y (toward 90, 10)
- **Row spread** (perpendicular): LEFT↔RIGHT diagonal
  - Toward LEFT: -X, -Y (but keep on perpendicular)
  - Toward RIGHT: +X, +Y

### Pattern for Triangle Rows

Each row in a triangle tier follows this pattern:
- Row with N blocks spans from leftmost to rightmost
- Leftmost block: (tip_x - N + 1, tip_y)
- Each subsequent block: +1 X, +1 Y
- Rightmost block: (tip_x, tip_y + N - 1)

### Example: Christmas Tree Tier (pointing UP)

```rms
/* Tier tip at (53, 47) */
/* Row 1: 1 block (tip) */
create_land { terrain_type GRASS_SNOW land_position 53 47 }

/* Row 2: 2 blocks */
create_land { terrain_type GRASS_SNOW land_position 52 47 }
create_land { terrain_type GRASS_SNOW land_position 53 48 }

/* Row 3: 3 blocks */
create_land { terrain_type GRASS_SNOW land_position 51 47 }
create_land { terrain_type GRASS_SNOW land_position 52 48 }
create_land { terrain_type GRASS_SNOW land_position 53 49 }

/* Row 4: 4 blocks */
create_land { terrain_type GRASS_SNOW land_position 50 47 }
create_land { terrain_type GRASS_SNOW land_position 51 48 }
create_land { terrain_type GRASS_SNOW land_position 52 49 }
create_land { terrain_type GRASS_SNOW land_position 53 50 }
```

### Moving Between Tiers

To position next tier's tip below previous tier's base:
- **DOWN** = toward BOTTOM corner = **-X, +Y**
- If Tier N base center is at (X, Y), Tier N+1 tip = (X-1, Y+1) or (X-2, Y+2)

## Notes

- Coordinates are **percentages** (0-100 for X, 0-99 for Y)
- On a 220×220 map: 1% ≈ 2.2 tiles
- `base_size 1` creates 3×3 tile origin
- For solid fill (no gaps), use spacing of 1 unit between blocks

## CONNECTION_GENERATION Pitfall

**IMPORTANT**: `replace_terrain` in CONNECTION_GENERATION can destroy your lands!

```rms
/* BAD - replaces PINE_FOREST with GRASS when creating paths */
create_connect_all_players_land {
  replace_terrain PINE_FOREST GRASS
}

/* GOOD - high terrain_cost makes paths go around forest */
create_connect_all_players_land {
  terrain_cost SNOW_FOREST 50
  terrain_cost PINE_FOREST 50
  terrain_cost GRASS_SNOW 50
  terrain_cost SNOW 1
  terrain_cost GRASS 1
}
```

If using forest terrain for decorations (Christmas tree, forests), **do not use `replace_terrain`** for those types — use high `terrain_cost` instead.
