# Debugging RMS Maps

## Placing Objects on Forest Terrain

**Problem**: Need to place objects (relics, gold) on forest terrain, but forest auto-fills with trees and objects don't spawn.

**Solution**: Use unique placeholder terrain + trees as objects:

```rms
/* 1. LAND_GENERATION: use unique terrain (NOT forest!) */
create_land {
  terrain_type GRASS_SNOW  /* unique, not used elsewhere on map */
  number_of_tiles 9
  base_size 1
  land_position 57 43
}

/* 2. OBJECTS_GENERATION: place objects FIRST */
create_object RELIC {
  set_gaia_object_only
  number_of_objects 15
  terrain_to_place_on GRASS_SNOW
  temp_min_distance_group_placement 5
}

/* 3. THEN place trees as objects (NOT terrain!) */
create_object SNOW_PINE_TREE {
  set_gaia_object_only
  number_of_objects 1
  number_of_groups 1000  /* uniform distribution */
  terrain_to_place_on GRASS_SNOW
}
```

**Why this works**:
- Forest terrain (SNOW_FOREST, PINE_FOREST, etc.) auto-generates trees
- Regular terrain (GRASS_SNOW, DIRT3, etc.) does not
- Objects placed in script order: relics first, then trees
- `number_of_groups` distributes trees uniformly, no gaps

**Important**:
- Use terrain that's **not used anywhere else** on the map
- `set_tight_grouping` creates tree cluster in one spot
- `number_of_objects 1` + `number_of_groups N` = uniform fill

## Debugging Techniques

### 1. Test Blocks with Different Terrains

**Problem**: Don't understand where coordinates point to.

**Solution**: Place 4 blocks with DIFFERENT terrains at corners:

```rms
/* Each corner - different color */
create_land { terrain_type GRASS number_of_tiles 30 base_size 3 land_position 90 10 zone 2 }       /* GREEN - TOP */
create_land { terrain_type DESERT number_of_tiles 30 base_size 3 land_position 10 10 zone 2 }      /* YELLOW - LEFT */
create_land { terrain_type SNOW_FOREST number_of_tiles 30 base_size 3 land_position 90 90 zone 2 } /* DARK GREEN - RIGHT */
create_land { terrain_type WATER number_of_tiles 30 base_size 3 land_position 10 90 zone 2 }       /* BLUE - BOTTOM */
```

**Result for 220x220 rhombus map**:
- GRASS (90, 10) = TOP corner
- DESERT (10, 10) = LEFT corner
- SNOW_FOREST (90, 90) = RIGHT corner
- WATER (10, 90) = BOTTOM corner

### 2. Edges vs Corners

**Problem**: Blocks at (97, 50), (50, 3) etc. are **edge midpoints**, not corners!

**Solution**: Rhombus corners are on **diagonals**: (90, 10), (10, 10), (90, 90), (10, 90)

### 3. Incremental Building

**Problem**: Complex shape doesn't work — unclear what's broken.

**Solution**: Build **piece by piece**:
1. Start with Row 1 only (1 block)
2. Test in game
3. Add Row 2, test
4. Continue...

### 4. Different Terrains for Tiers

**Problem**: Tree tiers blend together — can't tell which is which.

**Solution**:
```rms
/* Tier 1 - light */
create_land { terrain_type GRASS ... }

/* Tier 2 - dark */
create_land { terrain_type SNOW_FOREST ... }
```

### 5. Disappearing Lands

**Problem**: Lands don't appear in game.

**Checklist**:
1. `number_of_tiles` too small? Try 9-20
2. `base_size 0` not working? Use `base_size 1`
3. `connection_generation` uses `replace_terrain`? Remove it!
4. Lands conflict with `create_player_lands`? Check zones

### 6. Game Screenshots

**Workflow**:
```bash
# 1. In game: F12 (Steam screenshot)

# 2. Extract minimap:
source .env
python3 scripts/extract-minimap.py output/screenshot.png

# 3. View result
```

### 7. genie-rms Preview vs Game

**genie-rms limitations**:
- Does NOT support `direct_placement`
- May render some terrains incorrectly
- Map sizes may differ

**Rule**: Final test ALWAYS in game!

## Common Errors

### "Lands disappear"
```rms
/* BAD - too small */
create_land { number_of_tiles 1 base_size 1 ... }

/* GOOD */
create_land { number_of_tiles 9 base_size 1 ... }
```

### "Gaps between blocks"
```rms
/* BAD - spacing 3 */
land_position 50 50
land_position 53 50

/* GOOD - spacing 1 */
land_position 50 50
land_position 51 50
```

### "Tree deleted on load"
```rms
/* BAD */
create_connect_all_players_land {
  replace_terrain SNOW_FOREST SNOW  /* deletes tree! */
}

/* GOOD */
create_connect_all_players_land {
  terrain_cost SNOW_FOREST 50  /* paths go around tree */
}
```

### "Shape crooked / shifted"
- Check coordinates of each block
- Use different terrains for debug
- Remember: directions on rhombus differ from square!

## Terrain Placement Restrictions

Some terrains don't allow certain objects:

| Terrain | Resources | Trees | Notes |
|---------|-----------|-------|-------|
| ROAD, ROAD2 | NO | NO | Can't place anything |
| ICE | NO | NO | Only decorations |
| BEACH | Limited | NO | Some objects work |
| WATER | NO | NO | Water only |
| GRASS, DIRT, SNOW | YES | YES | Full support |
