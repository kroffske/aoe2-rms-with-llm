# ELEVATION_GENERATION Section

Adds hills and height variations to the map.

## Section Declaration

```rms
<ELEVATION_GENERATION>
```

## Main Command

### create_elevation

```rms
create_elevation MAX_HEIGHT {
  base_terrain GRASS
  number_of_clumps 15
  number_of_tiles 1000
  set_scale_by_groups
  spacing 3
}
```

`MAX_HEIGHT`: Maximum elevation level (1-7)

## Attributes

| Attribute | Description |
|-----------|-------------|
| `base_terrain TYPE` | Target terrain for hills (must exist on map) |
| `number_of_clumps N` | Number of separate hill clusters |
| `number_of_tiles N` | Total tiles of elevation |
| `set_scale_by_groups` | Scale clumps with map size |
| `set_scale_by_size` | Scale tiles with map size |
| `spacing N` | Distance between elevation changes |

## DE-Only Features

### enable_balanced_elevation

**CRITICAL for DE maps!** Fixes the southern bias bug from the original engine.

```rms
<ELEVATION_GENERATION>
enable_balanced_elevation

create_elevation 4 {
  base_terrain GRASS
  number_of_clumps 20
  set_scale_by_groups
}
```

Without this, hills cluster unfairly in the bottom half of the map.

## Elevation Levels

- Level 0: Sea level (default)
- Level 1-7: Increasing height
- Higher than 7: Not supported

## Checklist

- [ ] Add `enable_balanced_elevation` (DE only, but essential)
- [ ] Target correct `base_terrain` (must match land terrain)
- [ ] Set `number_of_clumps` for distribution
- [ ] Use `set_scale_by_groups` for consistent feel across map sizes
- [ ] Keep `create_elevation` argument in range 1-7

## Example: Balanced Hills

```rms
<ELEVATION_GENERATION>
enable_balanced_elevation

create_elevation 5 {
  base_terrain GRASS
  number_of_clumps 20
  number_of_tiles 2000
  set_scale_by_groups
  spacing 2
}

/* Lower hills on dirt */
create_elevation 3 {
  base_terrain DIRT
  number_of_clumps 10
  set_scale_by_groups
}
```

## Example: Highland-style

```rms
<ELEVATION_GENERATION>
enable_balanced_elevation

create_elevation 7 {
  base_terrain GRASS
  number_of_clumps 40
  number_of_tiles 4000
  set_scale_by_groups
  spacing 1
}
```

## Common Issues

1. **No hills appearing**: `base_terrain` doesn't match actual terrain on map
2. **Unbalanced hills**: Missing `enable_balanced_elevation` (DE)
3. **Too uniform**: `spacing` too high, reduce for more variation
