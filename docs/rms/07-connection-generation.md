# CONNECTION_GENERATION Section

Creates guaranteed paths between map areas. Essential for team games and complex geography.

## Section Declaration

```rms
<CONNECTION_GENERATION>
```

## Connection Commands

| Command | Description |
|---------|-------------|
| `create_connect_all_players_land` | Connect all players to each other |
| `create_connect_teams_lands` | Connect team members |
| `create_connect_same_land_zones` | Connect lands in same zone |
| `create_connect_all_lands` | Connect all lands |
| `create_connect_to_nonplayer_land` | Connect to neutral lands |

## Attributes

| Attribute | Description |
|-----------|-------------|
| `replace_terrain OLD NEW` | Replace terrain along path |
| `terrain_cost TYPE N` | Cost to path through terrain |
| `terrain_size TYPE W H` | Path width/height on terrain |
| `default_terrain_replacement TYPE` | Default terrain for paths |

## How Connections Work

Connections find paths between lands and optionally modify terrain along those paths.

### replace_terrain

Replaces one terrain with another along the path:

```rms
create_connect_teams_lands {
  replace_terrain WATER SHALLOW    /* Bridge with shallows */
  replace_terrain FOREST GRASS     /* Clear forests */
}
```

### terrain_cost

Higher cost = pathfinder avoids this terrain:

```rms
create_connect_all_players_land {
  terrain_cost WATER 100           /* Avoid water */
  terrain_cost FOREST 15           /* Slightly avoid forests */
  terrain_cost GRASS 1             /* Prefer grass */
}
```

### terrain_size

Width of the path on each terrain type:

```rms
create_connect_teams_lands {
  terrain_size WATER 3 0           /* 3-tile wide shallows */
  terrain_size FOREST 2 0          /* 2-tile clearing */
  default_terrain_replacement ROAD
}
```

## Example: Team Connection

```rms
<CONNECTION_GENERATION>

create_connect_teams_lands {
  replace_terrain WATER SHALLOW
  terrain_cost WATER 50
  terrain_cost GRASS 1
  terrain_size WATER 4 0
  terrain_size GRASS 2 0
}
```

## Example: Roads Between All Players

```rms
<CONNECTION_GENERATION>

create_connect_all_players_land {
  replace_terrain GRASS ROAD
  replace_terrain DIRT ROAD
  terrain_cost WATER 1000          /* Don't cross water */
  terrain_cost FOREST 20
  terrain_size GRASS 2 0
  terrain_size DIRT 2 0
}
```

## Example: Clear Forest Paths

```rms
<CONNECTION_GENERATION>

create_connect_all_lands {
  replace_terrain FOREST GRASS
  replace_terrain PINE_FOREST GRASS
  terrain_cost FOREST 5
  terrain_cost PINE_FOREST 5
  terrain_size FOREST 3 0
  terrain_size PINE_FOREST 3 0
}
```

## Checklist

- [ ] Choose appropriate connection type for map style
- [ ] Set `terrain_cost` to guide pathfinder
- [ ] Use `replace_terrain` to create passable paths
- [ ] Set `terrain_size` for path width
- [ ] Consider team connections for team maps
- [ ] Test that all players can reach each other

## When to Use Connections

| Map Type | Connection Strategy |
|----------|---------------------|
| Team Islands | `create_connect_teams_lands` with shallows |
| Black Forest | `create_connect_all_players_land` to clear paths |
| Arena | Usually not needed (open center) |
| Arabia | Usually not needed (open map) |
| Michi | `create_connect_teams_lands` through forest |

## Common Issues

1. **No visible path**: Missing `replace_terrain`
2. **Path goes through water**: `terrain_cost` for water too low
3. **Path too narrow**: `terrain_size` values too small
4. **Teammates can't reach each other**: Wrong connection command
