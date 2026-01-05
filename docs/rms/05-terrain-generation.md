# TERRAIN_GENERATION Section

Paints terrain features (forests, patches, beaches) onto the base lands.

## Section Declaration

```rms
<TERRAIN_GENERATION>
```

## Main Command

### create_terrain

```rms
create_terrain TERRAIN_TYPE {
  base_terrain TARGET_TERRAIN
  land_percent 10
  number_of_clumps 15
  /* attributes */
}
```

## Size Attributes

| Attribute | Description |
|-----------|-------------|
| `land_percent N` | % of base_terrain to cover |
| `percent_of_land N` | Alternative to land_percent |
| `number_of_tiles N` | Fixed tile count |
| `number_of_clumps N` | Number of separate patches |

## Scaling Attributes

| Attribute | Description |
|-----------|-------------|
| `set_scale_by_groups` | Scale clump count by map size |
| `set_scale_by_size` | Scale tile count by map size |

## Placement Control

| Attribute | Description |
|-----------|-------------|
| `base_terrain TYPE` | Target terrain to paint on (REQUIRED) |
| `terrain_type TYPE` | Override terrain type (rarely needed) |
| `spacing_to_other_terrain_types N` | Gap from other terrains |
| `set_avoid_player_start_areas` | Don't place near TCs |
| `height_limits MIN MAX` | Only place at specific elevations |
| `set_flat_terrain_only` | Only place on flat ground |
| `clumping_factor N` | How tightly patches clump |

## DE Features

| Attribute | Description |
|-----------|-------------|
| `base_layer TYPE` | Layer-based terrain placement |

## Forest Terrain Types

| Constant | ID | Description |
|----------|---:|-------------|
| `FOREST` | 10 | Oak forest |
| `PINE_FOREST` | 19 | Pine forest |
| `PALM_DESERT` | 13 | Palm forest |
| `JUNGLE` | 17 | Jungle forest |
| `BAMBOO` | 18 | Bamboo forest |
| `SNOW_FOREST` | 21 | Snowy pine forest |
| `DLC_BAOBABFOREST` | 49 | Baobab forest |
| `DLC_DRAGONFOREST` | 48 | Dragon tree forest |
| `DLC_ACACIAFOREST` | 50 | Acacia forest |
| `DLC_MANGROVEFOREST` | 55 | Mangrove forest |
| `DLC_RAINFOREST` | 56 | Rainforest |
| `DLC_FORESTAUTUMN` | 104 | Autumn forest |
| `DLC_FORESTDEAD` | 106 | Dead forest |
| `MEDITERRANEAN_FOREST` | 88 | Mediterranean forest |

## Ground Terrain Types

| Constant | ID | Description |
|----------|---:|-------------|
| `GRASS` | 0 | Green grass |
| `GRASS2` | 12 | Grass variant |
| `GRASS3` | 9 | Grass variant |
| `DIRT` | 6 | Brown dirt |
| `DIRT2` | 11 | Dirt variant |
| `DIRT3` | 3 | Dirt variant |
| `DESERT` | 14 | Sand desert |
| `BEACH` | 2 | Beach sand |
| `SNOW` | 32 | Snow |
| `ICE` | 35 | Ice |
| `LEAVES` | 5 | Fallen leaves |
| `ROAD` | 24 | Stone road |
| `ROAD2` | 25 | Road variant |

## Checklist

- [ ] Set `base_terrain` to match existing terrain on map
- [ ] Choose appropriate `land_percent` or `number_of_tiles`
- [ ] Set `number_of_clumps` for distribution
- [ ] Use `set_scale_by_groups` for consistent map sizes
- [ ] Add `spacing_to_other_terrain_types` to prevent touching
- [ ] Use `set_avoid_player_start_areas` for forests
- [ ] Consider `height_limits` for themed placement

## Example: Arabia-style

```rms
<TERRAIN_GENERATION>

/* Main forest */
create_terrain FOREST {
  base_terrain GRASS
  land_percent 10
  number_of_clumps 12
  set_scale_by_groups
  set_avoid_player_start_areas
  spacing_to_other_terrain_types 3
}

/* Dirt patches */
create_terrain DIRT {
  base_terrain GRASS
  land_percent 8
  number_of_clumps 20
  set_scale_by_size
  spacing_to_other_terrain_types 0
}

/* Secondary small forests */
create_terrain PINE_FOREST {
  base_terrain DIRT
  land_percent 2
  number_of_clumps 5
  set_scale_by_groups
  set_avoid_player_start_areas
  spacing_to_other_terrain_types 2
}
```

## Example: Desert Map

```rms
<TERRAIN_GENERATION>

/* Palm forests */
create_terrain PALM_DESERT {
  base_terrain DESERT
  land_percent 8
  number_of_clumps 10
  set_scale_by_groups
  set_avoid_player_start_areas
  spacing_to_other_terrain_types 4
}

/* Oasis grass patches */
create_terrain GRASS {
  base_terrain DESERT
  land_percent 3
  number_of_clumps 8
  set_scale_by_groups
}

/* Rocky areas */
create_terrain DIRT3 {
  base_terrain DESERT
  land_percent 5
  number_of_clumps 15
  set_scale_by_size
}
```

## Example: Height-based Terrain

```rms
<TERRAIN_GENERATION>

/* Forest only on hills */
create_terrain FOREST {
  base_terrain GRASS
  land_percent 5
  number_of_clumps 8
  height_limits 3 7
  set_scale_by_groups
}

/* Snow only at high elevation */
create_terrain SNOW {
  base_terrain GRASS
  land_percent 2
  number_of_clumps 5
  height_limits 5 7
}
```

## Common Issues

1. **Terrain not appearing**: `base_terrain` doesn't exist on map
2. **Forests too close to TC**: Missing `set_avoid_player_start_areas`
3. **Inconsistent on map sizes**: Missing `set_scale_by_groups`
4. **Terrains overlapping**: Need `spacing_to_other_terrain_types`
