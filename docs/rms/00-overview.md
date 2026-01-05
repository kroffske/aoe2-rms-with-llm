# RMS Overview - Definitive Edition

## File Structure

RMS files are plain text with `.rms` extension. The game processes sections sequentially from top to bottom.

## Section Order

Sections must appear in this order:

```
<PLAYER_SETUP>           /* Player configuration, global rules */
<LAND_GENERATION>        /* Landmasses and water bodies */
<ELEVATION_GENERATION>   /* Hills and height variations */
<CLIFF_GENERATION>       /* Cliff generation (optional) */
<TERRAIN_GENERATION>     /* Surface features: forests, patches */
<CONNECTION_GENERATION>  /* Paths between areas */
<OBJECTS_GENERATION>     /* Units, resources, decorations */
```

## Basic Syntax

### Commands with Blocks
```rms
command {
  attribute argument
  attribute argument
}
```

### Commands with Arguments
```rms
command argument1 argument2
```

### Constants
```rms
#const MY_TERRAIN 14    /* Define numeric constant */
#define MY_FLAG         /* Define boolean flag */
#undefine MY_FLAG       /* Remove definition */
```

### Comments
```rms
/* This is a comment */
/* Multi-line
   comment */
```

## Conditional Logic

### If Statements
```rms
if CONDITION
  /* code */
elseif OTHER_CONDITION
  /* code */
else
  /* code */
endif
```

### Map Size Conditions
- `TINY_MAP`, `SMALL_MAP`, `MEDIUM_MAP`, `LARGE_MAP`, `HUGE_MAP`, `GIGANTIC_MAP`

### Player Count Conditions
- `1_PLAYER_GAME` through `8_PLAYER_GAME`

### Team Conditions
- `0_TEAM_GAME` through `4_TEAM_GAME`
- `PLAYER1_TEAM0` through `PLAYER8_TEAM4`
- `TEAM0_SIZE0` through `TEAM4_SIZE8`

### Game Mode Conditions
- `DEATH_MATCH`, `REGICIDE`, `KING_OT_HILL`, `WONDER_RACE`
- `CAPTURE_RELIC`, `DEFEND_WONDER`, `RANDOM_MAP`, `TURBO_RANDOM_MAP`

### Version Conditions
- `UP_AVAILABLE` - UserPatch 1.4+
- `UP_EXTENSION` - UserPatch 1.5+ or DE

## Controlled Randomness

```rms
start_random
  percent_chance 40
    /* 40% chance this executes */
  percent_chance 30
    /* 30% chance this executes */
  percent_chance 30
    /* 30% chance this executes */
end_random
```

Note: If percentages don't sum to 100, there's a chance none execute.

## Include Files

```rms
#include_drs random_map.def    /* Include builtin definitions */
#include "my_file.inc"         /* Include custom file */
```

## DE Compatibility Header

Add at the top of your script:
```rms
/* Compatibility: Definitive Edition */
```

## DE-Only Features

These commands only work in Definitive Edition:

### ELEVATION_GENERATION
- `enable_balanced_elevation` - Fixes southern hill bias

### OBJECTS_GENERATION
- `actor_area`, `actor_area_radius`, `actor_area_to_place_in`
- `avoid_actor_area`, `avoid_all_actor_areas`
- `avoid_forest_zone`, `place_on_forest_zone`, `avoid_cliff_zone`
- `second_object`
- `set_gaia_unconvertible`

### PLAYER_SETUP
- `set_gaia_civilization`

## Common Pitfalls

1. **Section Order**: Sections must appear in correct order
2. **base_terrain Mismatch**: Commands must target existing terrain
3. **zone 99**: Crashes the game - never use
4. **Sticky Spacing**: `min_distance_group_placement` persists across commands
5. **Object Order**: Place critical objects first (TC, resources)
6. **Elevation Range**: `base_elevation` must be 0-7
7. **Position Range**: `land_position` X: 0-100, Y: 0-99
