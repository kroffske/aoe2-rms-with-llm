# Game Mode Support

> Extracted from Zetnus's Definitive RMS Guide for quick reference.

## Overview

| Mode | Required | Key Changes |
|------|----------|-------------|
| Regicide | **YES** | Add KING or instant defeat |
| Nomad | Recommended | `nomad_resources`, no starting TC |
| Death Match | Optional | Remove food resources |
| Empire Wars | Manual | Pre-built feudal base |
| Battle Royale | Complex | Capturable buildings, shrinking map |

---

## Regicide

**CRITICAL:** Players without a KING lose instantly.

Starting resources: 500 wood/food, 0 gold, 150 stone.

### Required Objects

```rms
/* REGICIDE MODE */
if REGICIDE
  create_object KING {
    set_place_for_every_player
    min_distance_to_players 4
    max_distance_to_players 6
  }

  create_object CASTLE {
    set_place_for_every_player
    min_distance_to_players 8
    max_distance_to_players 12
  }

  /* Extra villagers (castle provides housing) */
  create_object VILLAGER {
    set_place_for_every_player
    number_of_objects 7
    min_distance_to_players 3
    max_distance_to_players 6
  }
endif
```

### Variations
- Some maps give WATCH_TOWER instead of CASTLE
- Nomad regicide maps may skip buildings

---

## Nomad

Nomad is a map style, not a game mode. Players start without TC and must build one.

### Required Setup

```rms
<PLAYER_SETUP>
ai_info_map_type CUSTOM 1 0 0    /* isNomad = 1 */
nomad_resources                   /* Adds 275W + 100S for TC */
```

### Checklist
- [ ] Set `ai_info_map_type` with isNomad = 1
- [ ] Add `nomad_resources`
- [ ] Do NOT place starting TOWN_CENTER
- [ ] Do NOT place SCOUT (will kill villagers)
- [ ] Do NOT place predators (WOLF, etc.)
- [ ] Consider `force_nomad_treaty` (prevents early fights)

---

## Death Match

Players start with: 20000 wood/food, 10000 gold, 5000 stone.

### Remove These Objects
```rms
if DEATH_MATCH
  /* Skip these - players won't gather them */
  /* FORAGE, SHEEP, DEER, BOAR, WOLF, straggler trees, SHORE_FISH */
endif
```

Keep GOLD, STONE, and forests (for chopping).

---

## Empire Wars (DE Only)

Feudal age start with 28 economic population. **Must be coded manually.**

### Standard Empire Wars Start

| Object | Count | Placement |
|--------|-------|-----------|
| TOWN_CENTER | 1 | Player start |
| SCOUT | 1 | Slightly further than usual |
| VILLAGER (total) | 28 | Distributed across resources |
| FARM | 2 | Around TC, 1 villager each |
| MILL | 1 | Next to berries, 4 villagers |
| MINING_CAMP | 1 | Next to gold, 4 villagers |
| LUMBER_CAMP | 3 | Closest forests, 4 villagers each |
| SHEEP | 1 | Under TC |
| VILLAGER (idle) | 6 | Under TC |
| BLACKSMITH | 1 | Near TC |
| HOUSE | 6 | Forming pseudo-wall |
| BARRACKS | 1 | Near TC |

### Removed in Empire Wars
- Far sheep groups
- Boar
- Straggler trees near TC

---

## Sudden Death

Players cannot build new TCs. Defeat if TC is lost.

```rms
/* Optional: mark TC importance */
create_object FLAG_A {
  set_place_for_every_player
  min_distance_to_players 0
  max_distance_to_players 3
  number_of_objects 4
}
```

---

## King of the Hill

Monument spawns automatically at map center. Controlling it grants resource trickle.

No special scripting required unless modifying trickle rates.

---

## Infinite Resources (DE Only)

Remove all resources except for visual appeal. **Keep relics** (Lithuanians bonus).

---

## Battle Royale (DE Only)

Complex mode with shrinking map and capturable buildings.

### Key Features
- Map gradually corrupts from edges
- Gaia buildings can be captured
- Players start with 0 stone
- TC can pack into cart

### Disable Problematic Techs
```rms
<PLAYER_SETUP>
#const SPIES 408
#const FLEMISH_REVOLUTION 755
#const FIRST_CRUSADE 756

effect_amount DISABLE_TECH SPIES ATTR_DISABLE 408
effect_amount DISABLE_TECH FLEMISH_REVOLUTION ATTR_DISABLE 755
effect_amount DISABLE_TECH FIRST_CRUSADE ATTR_DISABLE 756
```

---

## Antiquity Mode (DE Only)

Lobby setting that allows trade to generate wood. Check with:

```rms
if ANTIQUITY_MODE
  /* Generate oysters as water-based gold source */
endif
```
