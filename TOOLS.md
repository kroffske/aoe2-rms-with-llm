# Visualization Tools

This repository includes experimental tools for RMS preview generation. These are **optional** - documentation and in-game testing are sufficient for map development.

## Why These Tools?

When using AI assistants (Claude Code) for map generation, visual feedback accelerates iteration:
- Generate map preview image directly
- See terrain layout without launching the game
- Faster iteration cycle for complex maps

## Included Tools

### rms-preview

Node.js-based preview generator using Docker.

```bash
./rms-preview/scripts/docker-build.sh
./rms-preview/scripts/rms-preview.sh maps/your_map.rms --players 8 --size large -o output/preview.png
```

### rms-check

Rust-based RMS syntax linter (submodule from SiegeEngineers).

```bash
cd rms-check && cargo build --release
./target/release/rms-check maps/your_map.rms --de
```

### genie-rms-de

Forked JavaScript library for RMS parsing and map generation. Used internally by rms-preview.

## Known Issues and Fixes

These tools are forks with local modifications to fix various issues:

| Tool | Original | Local Fixes |
|------|----------|-------------|
| genie-rms-de | [genie-js/genie-rms](https://github.com/genie-js/genie-rms) | `circle_radius` support, `actor_area` tokens, map sizes up to 240x240, `numPlayers` pipeline fix, custom terrain colors |
| rms-check | [SiegeEngineers/rms-check](https://github.com/SiegeEngineers/rms-check) | Architecture improvements, additional lint rules |

## Current State

**Recommendation:** For serious map development, use in-game Scenario Editor testing. These tools are useful for AI-assisted workflows but have limitations:

- Not all RMS features are supported
- Preview may differ from actual game rendering
- Some terrain types may render with wrong colors

## Contributing

If you need fixes for your use case:
1. Check existing modifications in `genie-rms-de/` and `rms-check/`
2. With Claude Code, rewriting or fixing these tools is straightforward
3. Open an issue if you need specific features

## Licenses

- **rms-check**: GPL-3.0 ([SiegeEngineers/rms-check](https://github.com/SiegeEngineers/rms-check))
- **genie-rms**: MIT ([genie-js/genie-rms](https://github.com/genie-js/genie-rms))
- **rms-preview**: MIT
