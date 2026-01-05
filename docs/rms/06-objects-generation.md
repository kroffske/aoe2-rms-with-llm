# OBJECTS_GENERATION Section

Populates the map with units, resources, buildings, and decorations.

## Section Declaration

```rms
<OBJECTS_GENERATION>
```

## Critical Rule: Order Matters!

Objects are placed sequentially. Later objects may fail to spawn if space is exhausted.

**Recommended order:**
1. Town Center
2. Starting villagers/scout
3. Starting resources (gold, stone near player)
4. Main resources (gold, stone far from player)
5. Food sources (boar, deer, sheep, berries)
6. Relics
7. Fish (if water map)
8. Extra resources
9. Decorations

## Main Command

### create_object

```rms
create_object OBJECT_TYPE {
  /* attributes */
}
```

## Player Object Attributes

| Attribute | Description |
|-----------|-------------|
| `set_place_for_every_player` | Place for each player |
| `set_gaia_object_only` | Gaia ownership (resources, animals) |
| `min_distance_to_players N` | Min distance from player TC |
| `max_distance_to_players N` | Max distance from player TC |

## Grouping Attributes

| Attribute | Description |
|-----------|-------------|
| `number_of_objects N` | Objects per group |
| `number_of_groups N` | Number of groups |
| `group_variance N` | Variance in group size |
| `set_tight_grouping` | Objects touch each other |
| `set_loose_grouping` | Objects spread out |
| `group_placement_radius N` | Spread radius for group |

## Scaling Attributes

| Attribute | Description |
|-----------|-------------|
| `set_scaling_to_map_size` | Scale with map size |
| `set_scaling_to_player_number` | Scale with player count |

## Placement Control

| Attribute | Description |
|-----------|-------------|
| `terrain_to_place_on TYPE` | Only place on this terrain |
| `place_on_specific_land_id N` | Only place on land with ID |
| `find_closest` | Place as close as possible |
| `force_placement` | Ignore placement rules |

## Spacing Attributes

### CRITICAL: Sticky vs Temporary

| Attribute | Behavior |
|-----------|----------|
| `min_distance_group_placement N` | **STICKY** - persists to all later objects! |
| `temp_min_distance_group_placement N` | Temporary - only affects this object |

**Common pitfall**: Using `min_distance_group_placement` early can starve later objects of valid positions!

## Resource Modifiers

| Attribute | Description |
|-----------|-------------|
| `resource_delta N` | Add/subtract from resource amount |

## Forest/Cliff Avoidance (DE only)

| Attribute | Description |
|-----------|-------------|
| `avoid_forest_zone N` | Stay N tiles from forests |
| `place_on_forest_zone` | Place inside forests |
| `avoid_cliff_zone N` | Stay N tiles from cliffs |

## Actor Areas (DE only)

Advanced placement control for complex resource distribution.

| Attribute | Description |
|-----------|-------------|
| `actor_area N` | Create actor area with ID N |
| `actor_area_radius N` | Radius of actor area |
| `actor_area_to_place_in N` | Place inside actor area N |
| `avoid_actor_area N` | Avoid actor area N |
| `avoid_all_actor_areas` | Avoid all actor areas |

## Other Attributes

| Attribute | Description |
|-----------|-------------|
| `base_terrain TYPE` | Alternative terrain targeting |
| `layer_to_place_on TYPE` | Layer-based placement (DE) |
| `second_object TYPE` | Place second object with main (DE) |
| `set_gaia_unconvertible` | Cannot be converted (DE) |
| `max_distance_to_other_zones N` | Zone distance limit |

## Essential Object Constants

### Starting Objects
| Constant | ID | Description |
|----------|---:|-------------|
| `TOWN_CENTER` | 109 | Town Center |
| `VILLAGER` | 83 | Villager |
| `SCOUT` | 448 | Scout Cavalry |

### Resources
| Constant | ID | Description |
|----------|---:|-------------|
| `GOLD` | 66 | Gold mine |
| `STONE` | 102 | Stone mine |
| `FORAGE` | 59 | Berry bush |
| `RELIC` | 285 | Relic |

### Animals
| Constant | ID | Description |
|----------|---:|-------------|
| `SHEEP` | 594 | Sheep |
| `BOAR` | 48 | Wild boar |
| `DEER` | 65 | Deer |
| `WOLF` | 126 | Wolf |
| `TURKEY` | 833 | Turkey |
| `DLC_LLAMA` | 305 | Llama |
| `DLC_COW` | 705 | Cow |
| `DLC_GOAT` | 1060 | Goat |

### Fish
| Constant | ID | Description |
|----------|---:|-------------|
| `FISH` | 53 | Generic fish |
| `SHORE_FISH` | 69 | Shore fish |
| `SALMON` | 456 | Salmon |
| `TUNA` | 457 | Tuna |

### Decorations
| Constant | ID | Description |
|----------|---:|-------------|
| `HAWK` | 96 | Hawk (flying) |
| `SKELETON` | 710 | Skeleton |
| `CACTUS` | 709 | Cactus |
| `PLANTS` | 818 | Plants |

## Checklist

- [ ] Place objects in priority order (TC first!)
- [ ] Use `set_place_for_every_player` for player resources
- [ ] Use `set_gaia_object_only` for resources/animals
- [ ] Set `min_distance_to_players` and `max_distance_to_players`
- [ ] Use `temp_min_distance_group_placement` instead of sticky version
- [ ] Use `terrain_to_place_on` to restrict placement
- [ ] Use `set_tight_grouping` for resource piles
- [ ] Scale appropriately with `set_scaling_to_map_size`

## Example: Standard Starting Resources

```rms
<OBJECTS_GENERATION>

/* Town Center - FIRST! */
create_object TOWN_CENTER {
  set_place_for_every_player
  min_distance_to_players 0
  max_distance_to_players 0
}

/* Starting villagers */
create_object VILLAGER {
  set_place_for_every_player
  min_distance_to_players 3
  max_distance_to_players 6
  number_of_objects 3
}

/* Scout */
create_object SCOUT {
  set_place_for_every_player
  min_distance_to_players 7
  max_distance_to_players 9
  number_of_objects 1
}

/* Main gold (7 tiles) */
create_object GOLD {
  set_place_for_every_player
  set_gaia_object_only
  min_distance_to_players 12
  max_distance_to_players 16
  number_of_objects 7
  number_of_groups 1
  set_tight_grouping
  temp_min_distance_group_placement 3
}

/* Secondary gold */
create_object GOLD {
  set_place_for_every_player
  set_gaia_object_only
  min_distance_to_players 18
  max_distance_to_players 26
  number_of_objects 4
  number_of_groups 1
  set_tight_grouping
  temp_min_distance_group_placement 3
}

/* Stone (5 tiles) */
create_object STONE {
  set_place_for_every_player
  set_gaia_object_only
  min_distance_to_players 14
  max_distance_to_players 18
  number_of_objects 5
  number_of_groups 1
  set_tight_grouping
  temp_min_distance_group_placement 3
}

/* Berries */
create_object FORAGE {
  set_place_for_every_player
  set_gaia_object_only
  min_distance_to_players 8
  max_distance_to_players 12
  number_of_objects 6
  number_of_groups 1
  set_tight_grouping
}

/* Boars */
create_object BOAR {
  set_place_for_every_player
  set_gaia_object_only
  min_distance_to_players 16
  max_distance_to_players 22
  number_of_objects 1
  number_of_groups 2
  temp_min_distance_group_placement 10
}

/* Sheep (under TC) */
create_object SHEEP {
  set_place_for_every_player
  set_gaia_object_only
  min_distance_to_players 0
  max_distance_to_players 6
  number_of_objects 4
}

/* Deer */
create_object DEER {
  set_place_for_every_player
  set_gaia_object_only
  min_distance_to_players 14
  max_distance_to_players 22
  number_of_objects 4
  number_of_groups 1
  set_loose_grouping
}

/* Straggler trees */
create_object OAKTREE {
  set_place_for_every_player
  set_gaia_object_only
  min_distance_to_players 4
  max_distance_to_players 8
  number_of_objects 5
  set_loose_grouping
  temp_min_distance_group_placement 2
}

/* Relics */
create_object RELIC {
  set_gaia_object_only
  number_of_objects 5
  min_distance_to_players 25
  temp_min_distance_group_placement 20
}

/* Wolves */
create_object WOLF {
  set_gaia_object_only
  number_of_objects 2
  set_scaling_to_map_size
  min_distance_to_players 40
  temp_min_distance_group_placement 12
}
```

## Example: Fish (Water Map)

```rms
/* Deep water fish */
create_object TUNA {
  set_gaia_object_only
  number_of_objects 3
  number_of_groups 8
  set_scaling_to_map_size
  terrain_to_place_on DEEP_WATER
  temp_min_distance_group_placement 8
}

/* Shore fish */
create_object SHORE_FISH {
  set_place_for_every_player
  set_gaia_object_only
  min_distance_to_players 10
  max_distance_to_players 25
  number_of_objects 3
  number_of_groups 2
  set_loose_grouping
  terrain_to_place_on SHALLOW
}
```

## Terrain Limitations for `terrain_to_place_on`

**Some terrains do NOT support resource placement!**

| Terrain | Resources | Notes |
|---------|-----------|-------|
| `ROAD` | **NO** | Cannot place gold, stone, or other resources |
| `ICE` | **NO** | Buildings and resources cannot be placed |
| `WATER`, `DEEP_WATER` | Fish only | Land resources fail |
| `BEACH` | Limited | Some resources may fail |
| `GRASS`, `DIRT`, `SNOW` | **YES** | Standard terrains work fine |
| `DIRT_SNOW`, `GRASS_SNOW` | **YES** | Snow variants work |
| `DESERT`, `PALM_DESERT` | **YES** | Desert variants work |

**Workaround for ROAD**: Use a different terrain (like `DIRT` or `DIRT_SNOW`) for resource placement, even if it doesn't match visually.

## Common Issues

1. **TC not placed**: Wrong order or missing space
2. **Resources missing**: Space exhausted by earlier objects
3. **Inconsistent resources**: Not using `set_place_for_every_player`
4. **Resources too spread**: Need `set_tight_grouping`
5. **Later objects failing**: Using sticky `min_distance_group_placement`
6. **Resources not spawning on terrain**: Some terrains (ROAD, ICE) don't support resources
