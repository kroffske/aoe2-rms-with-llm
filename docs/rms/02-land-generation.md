# LAND_GENERATION Section

Creates foundational landmasses and water bodies - the map's canvas.

## Critical Rules

### 1. base_size Default = 7×7 tiles!

**CRITICAL**: Default `base_size` is 3, which creates a **7×7 = 49 tile origin square** before any growth!

```rms
/* WRONG - creates 49+ tiles even with number_of_tiles 1 */
create_land { terrain_type GRASS number_of_tiles 1 land_position 50 50 }

/* CORRECT - creates exactly 1 tile origin */
create_land { terrain_type GRASS number_of_tiles 1 base_size 0 land_position 50 50 }
```

For pixel-perfect placement, **always use `base_size 0`** with small lands.

### 2. Land Generation Order

1. **Origins placed sequentially** - in script order
2. **All lands grow simultaneously** - after origins are placed
3. **Later lands visible in overlaps** - if origins overlap

```rms
/* Land A placed first, Land B second */
/* If they overlap, B's terrain shows on top */
create_land { terrain_type DIRT ... }   /* A - placed first */
create_land { terrain_type GRASS ... }  /* B - placed second, wins overlap */
```

### 3. Lands Compete for Space

Lands grow until they hit `number_of_tiles` limit, borders, or other lands. If space is limited, lands may be smaller than specified.

## Section Declaration

```rms
<LAND_GENERATION>
```

## Base Terrain

Sets the default terrain covering the entire map before lands are added.

```rms
base_terrain TERRAIN_TYPE
```

Examples:
```rms
base_terrain WATER       /* Islands/water map */
base_terrain GRASS       /* Land map */
base_terrain DESERT      /* Desert map */
```

## Land Commands

### create_player_lands

Creates starting land for each player.

```rms
create_player_lands {
  terrain_type GRASS
  land_percent 30        /* Total for ALL players combined */
  base_size 10
  /* attributes */
}
```

### create_land

Creates a single neutral landmass.

```rms
create_land {
  terrain_type DIRT
  land_percent 15        /* Size of THIS land only */
  land_position 50 50    /* Center of map */
  /* attributes */
}
```

## Size Attributes

| Attribute | Description |
|-----------|-------------|
| `land_percent N` | Size as % of map (scales with map size) |
| `number_of_tiles N` | Fixed size in tiles (doesn't scale) |
| `base_size N` | Minimum square radius (default 3 = 7x7) |

## Position Attributes

| Attribute | Description |
|-----------|-------------|
| `land_position X Y` | Place land center at coordinates (X: 0-100, Y: 0-99) |
| `left_border N` | Avoid left edge by N% |
| `right_border N` | Avoid right edge by N% |
| `top_border N` | Avoid top edge by N% |
| `bottom_border N` | Avoid bottom edge by N% |

## Shape Attributes

| Attribute | Description |
|-----------|-------------|
| `border_fuzziness N` | Edge irregularity (0=smooth, higher=jagged) |
| `clumping_factor N` | How tightly land clumps |

## Zone System

Zones control how lands interact and merge.

| Attribute | Description |
|-----------|-------------|
| `zone N` | Assign to zone N (lands in same zone can merge) |
| `set_zone_by_team` | Auto-assign zone by team |
| `set_zone_randomly` | Random zone assignment |
| `other_zone_avoidance_distance N` | Min distance to other zones |

**WARNING**: `zone 99` crashes the game!

## Elevation

| Attribute | Description |
|-----------|-------------|
| `base_elevation N` | Set entire land to elevation N (0-7) |

**Note**: Elevation must be 0-7. Value 0 means "any elevation".

## Player Assignment (create_land only)

| Attribute | Description |
|-----------|-------------|
| `assign_to_player N` | Assign land to player N (1-8) |
| `assign_to TARGET N MODE FLAGS` | Advanced assignment |

### assign_to Details

```rms
assign_to AT_PLAYER 1 0 0    /* Assign to player 1 */
assign_to AT_COLOR 2 0 0     /* Assign to color 2 */
assign_to AT_TEAM 1 0 0      /* Assign to team 1 (random player) */
assign_to AT_TEAM 1 -1 0     /* Assign to team 1 (ordered) */
```

Target types:
- `AT_PLAYER` (0): Specific player (1-8)
- `AT_COLOR` (1): Specific color (1-8)
- `AT_TEAM` (2): Team (0=unteamed, 1-4=teams, negative=outside team)

Mode (AT_TEAM only):
- 0: Random selection
- -1: Ordered selection

Flags:
- 1: Reset previous assignments
- 2: Don't remember this assignment

## Land ID

```rms
land_id N    /* Assign ID for later reference in OBJECTS_GENERATION */
```

## Checklist

- [ ] Set `base_terrain` (water for islands, grass/dirt for land maps)
- [ ] Use `create_player_lands` for starting positions
- [ ] Set appropriate `land_percent` or `number_of_tiles`
- [ ] Configure `base_size` for minimum land area
- [ ] Use zones to control land merging/separation
- [ ] Set `other_zone_avoidance_distance` if lands should stay apart
- [ ] Never use `zone 99`
- [ ] Keep `base_elevation` in range 0-7
- [ ] Keep `land_position` X in 0-100, Y in 0-99

## Example: Arabia-style

```rms
<LAND_GENERATION>
base_terrain GRASS

create_player_lands {
  terrain_type GRASS
  land_percent 30
  base_size 9
  border_fuzziness 15
}
```

## Example: Islands

```rms
<LAND_GENERATION>
base_terrain WATER

create_player_lands {
  terrain_type GRASS
  land_percent 25
  base_size 8
  zone 1
  other_zone_avoidance_distance 10
}

/* Central island */
create_land {
  terrain_type GRASS
  land_percent 10
  land_position 50 50
  zone 2
}
```

## Example: Team Islands

```rms
<LAND_GENERATION>
base_terrain WATER

create_player_lands {
  terrain_type GRASS
  land_percent 30
  base_size 7
  set_zone_by_team
  other_zone_avoidance_distance 8
}
```
