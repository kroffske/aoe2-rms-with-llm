# CLIFF_GENERATION Section

Generates cliffs on the map. This section uses top-level attributes (no command blocks).

## Section Declaration

```rms
<CLIFF_GENERATION>
```

## Attributes

All attributes are set at the section level:

| Attribute | Description |
|-----------|-------------|
| `min_number_of_cliffs N` | Minimum cliffs on entire map |
| `max_number_of_cliffs N` | Maximum cliffs on entire map |
| `min_length_of_cliff N` | Minimum length per cliff (tiles) |
| `max_length_of_cliff N` | Maximum length per cliff (tiles) |
| `cliff_curliness N` | % chance of direction change per tile |
| `min_distance_cliffs N` | Minimum distance between cliffs |
| `min_terrain_distance N` | Minimum distance from terrain edges |

## Example

```rms
<CLIFF_GENERATION>
min_number_of_cliffs 5
max_number_of_cliffs 15
min_length_of_cliff 3
max_length_of_cliff 10
cliff_curliness 10
min_distance_cliffs 4
min_terrain_distance 2
```

## Scaling by Map Size

Cliff generation does NOT auto-scale. Use conditionals:

```rms
<CLIFF_GENERATION>

if TINY_MAP
  min_number_of_cliffs 3
  max_number_of_cliffs 6
elseif SMALL_MAP
  min_number_of_cliffs 5
  max_number_of_cliffs 10
elseif LARGE_MAP
  min_number_of_cliffs 10
  max_number_of_cliffs 20
else
  min_number_of_cliffs 7
  max_number_of_cliffs 14
endif

min_length_of_cliff 3
max_length_of_cliff 8
cliff_curliness 15
min_distance_cliffs 5
```

## Checklist

- [ ] Set min/max cliff counts
- [ ] Set min/max cliff lengths
- [ ] Configure curliness for shape variety
- [ ] Set minimum distances for spacing
- [ ] Scale by map size if needed

## Notes

- Cliffs block unit movement
- Cliffs can make areas inaccessible
- Use sparingly for competitive maps
- Ensure connection paths exist if using heavy cliffs
