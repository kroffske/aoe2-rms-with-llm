# Standard Resources - Definitive Edition

> Extracted from Zetnus's Definitive RMS Guide. These are DE standard values.

## Starting Units (Per Player)

| Object | Count | Distance | Notes |
|--------|-------|----------|-------|
| TOWN_CENTER | 1 | 0 | `max_distance_to_players 0` |
| VILLAGER | 3 | ~6 tiles | Auto-adjusts for civ bonuses |
| SCOUT | 1 | ~7-9 tiles | Auto becomes Eagle/Camel for civs |

---

## Starting Resources (Per Player)

### Food Sources

| Object | Count | Min Distance | Group Size | Notes |
|--------|-------|--------------|------------|-------|
| FORAGE | 6 | 10 | 1 group | Berries |
| SHEEP | 4 | ~7 | 1 group | Under TC |
| SHEEP | 2+2 | 14-24 | 2 groups | Far sheep (variable) |
| BOAR | 1+1 | 16 | 2 individual | Use `find_closest` |
| DEER | 3-4 | 14-24 | 1 group | Variable distance |

**Variants:**
- SHEEP → COW/WATER_BUFFALO: use 3 instead of 4
- BOAR → ELEPHANT/RHINO: same placement
- DEER → OSTRICH/IBEX: same placement

### Gold

| Count | Min Distance | Notes |
|-------|--------------|-------|
| 7 | 10 | Main gold (tight grouping) |
| 4 | 18 | Secondary gold |
| 4 | 21 | Tertiary gold |

### Stone

| Count | Min Distance | Notes |
|-------|--------------|-------|
| 5 | 12 | Main stone |
| 4 | 16 | Secondary stone |

### Trees (Stragglers)

| Count | Distance | Notes |
|-------|----------|-------|
| 2 | 4-5 | Very close |
| 3 | 6-8 | Slightly further |

### Predators

| Count | Min Distance |
|-------|--------------|
| 1 | 34 |

---

## Scattered Resources (Map-wide)

### Relics

| Map Size | Count |
|----------|-------|
| Tiny | 5 |
| Small | 5 |
| Medium | 5 |
| Large | 7 |
| Huge | 8 |
| Gigantic+ | Unlimited |

### Extra Gold (40+ tiles from players)

| Map Size | Groups | Per Group |
|----------|--------|-----------|
| Tiny | 2 | 3 |
| Small | 2 | 3 |
| Medium | 3 | 3 |
| Large | 3 | 3 |
| Huge | 4 | 4 |
| Gigantic | 5 | 4 |
| Ludicrous | 26 | 4 |

### Extra Stone (40+ tiles from players)

| Map Size | Groups | Per Group |
|----------|--------|-----------|
| Tiny | 2 | 2 |
| Small | 2 | 2 |
| Medium | 3 | 3 |
| Large | 3 | 4 |
| Huge | 4 | 4 |
| Gigantic+ | Unlimited | 4 |

### Extra Berries

Large+ maps only, 40+ tiles from players.

### Other

| Object | Scaling | Notes |
|--------|---------|-------|
| Predators | 2 groups | `set_scaling_to_map_size`, 40+ tiles |
| Shore fish | Unlimited | `temp_min_distance_group_placement 6` |
| Deep fish | Scaled | `min_distance_group_placement 4-8` |
| Straggler trees | 30 | `set_scaling_to_map_size` |
| Birds | 4 | `set_scaling_to_map_size` |

---

## Example Code

### Starting Gold (7+4+4)

```rms
/* Main gold - 7 tiles */
create_object GOLD {
  set_place_for_every_player
  set_gaia_object_only
  number_of_objects 7
  number_of_groups 1
  set_tight_grouping
  min_distance_to_players 10
  max_distance_to_players 14
  find_closest
  temp_min_distance_group_placement 3
}

/* Secondary gold - 4 tiles */
create_object GOLD {
  set_place_for_every_player
  set_gaia_object_only
  number_of_objects 4
  number_of_groups 1
  set_tight_grouping
  min_distance_to_players 18
  max_distance_to_players 24
  temp_min_distance_group_placement 3
}

/* Tertiary gold - 4 tiles */
create_object GOLD {
  set_place_for_every_player
  set_gaia_object_only
  number_of_objects 4
  number_of_groups 1
  set_tight_grouping
  min_distance_to_players 21
  max_distance_to_players 28
  temp_min_distance_group_placement 3
}
```

### Starting Stone (5+4)

```rms
/* Main stone - 5 tiles */
create_object STONE {
  set_place_for_every_player
  set_gaia_object_only
  number_of_objects 5
  number_of_groups 1
  set_tight_grouping
  min_distance_to_players 12
  max_distance_to_players 16
  find_closest
  temp_min_distance_group_placement 3
}

/* Secondary stone - 4 tiles */
create_object STONE {
  set_place_for_every_player
  set_gaia_object_only
  number_of_objects 4
  number_of_groups 1
  set_tight_grouping
  min_distance_to_players 16
  max_distance_to_players 22
  temp_min_distance_group_placement 3
}
```

### Relics by Map Size

```rms
if TINY_MAP
  #const RELIC_COUNT 5
elseif SMALL_MAP
  #const RELIC_COUNT 5
elseif MEDIUM_MAP
  #const RELIC_COUNT 5
elseif LARGE_MAP
  #const RELIC_COUNT 7
elseif HUGE_MAP
  #const RELIC_COUNT 8
else
  #const RELIC_COUNT 999
endif

create_object RELIC {
  set_gaia_object_only
  number_of_objects RELIC_COUNT
  min_distance_to_players 25
  temp_min_distance_group_placement 20
}
```

---

## Notes

- `find_closest` ensures resources spawn at minimum distance
- Tournament maps often place first sheep group under player control
- Variable distances (14-24) should be randomized in bands to ensure fairness
- Island maps place extra resources per-player to ensure equal distribution
