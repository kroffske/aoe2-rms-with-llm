# PLAYER_SETUP Section

Sets player configuration and global map rules before generation begins.

## Section Declaration

```rms
<PLAYER_SETUP>
```

## Placement Mode (choose one)

| Command | Description |
|---------|-------------|
| `random_placement` | Players positioned in circle/oval around map (default) |
| `direct_placement` | Manual positioning with `assign_to_player` + `land_position` |
| `circle_placement` | Circular placement with configurable radius |

### Circle Radius

```rms
circle_radius 40    /* Distance from center (0-50) */
```

## Team Configuration

| Command | Description |
|---------|-------------|
| `grouped_by_team` | Team members placed in close proximity |

## Resource Configuration

| Command | Description |
|---------|-------------|
| `nomad_resources` | Adds TC cost (275W, 100S) to starting resources |

## AI Information

```rms
ai_info_map_type MAP_TYPE NOMAD MICHI STANDARD
```

Arguments:
- `MAP_TYPE`: Map constant (ARABIA, ISLANDS, etc.)
- `NOMAD`: 1 for nomad-style maps, 0 otherwise
- `MICHI`: 1 for michi-style maps, 0 otherwise
- `STANDARD`: 1 to show builtin map name in Objectives

Example:
```rms
ai_info_map_type ARABIA 0 0 0
ai_info_map_type NOMAD 1 0 0
```

## Visual Effects

### Weather

```rms
weather_type STYLE LIVE_COLOR FOG_COLOR WATER_DIRECTION
```

### Color Correction

```rms
color_correction CC_AUTUMN   /* Autumn colors */
color_correction CC_WINTER   /* Winter/snowy */
color_correction CC_JUNGLE   /* Jungle tint */
color_correction CC_DESERT   /* Desert tint */
```

### Terrain Effects

```rms
terrain_state MODE PARAM1 PARAM2 VALUE
enable_waves 1              /* Enable water waves */
terrain_mask 1              /* Terrain masking */
```

## Game Rules

### Guard State (victory conditions)

```rms
guard_state TYPE_ID RESOURCE_AMOUNT RESOURCE_DELTA FLAGS
```

Flags (combine by adding):
- 1: guard-flag-victory (defeat if no objects remain)
- 2: guard-flag-resource (add resources while objects exist)
- 4: guard-flag-inverse (invert resource condition)

### Research Effects

```rms
effect_amount EFFECT ITEM TYPE VALUE
effect_percent EFFECT ITEM TYPE PERCENT
```

## Gaia Configuration (DE only)

```rms
set_gaia_civilization CIV_ID
```

## Checklist

- [ ] Choose placement mode: `random_placement`, `direct_placement`, or `circle_placement`
- [ ] Set `circle_radius` if using circle placement (0-50)
- [ ] Add `grouped_by_team` for team games
- [ ] Add `nomad_resources` for nomad-style maps
- [ ] Set `ai_info_map_type` for AI compatibility
- [ ] Configure visual effects if desired (weather, color correction)

## Example

```rms
<PLAYER_SETUP>
  random_placement
  ai_info_map_type ARABIA 0 0 0

  if TEAM_GAME
    grouped_by_team
  endif

  if DEATH_MATCH
    /* DM-specific settings */
  endif
```
