# Check: MCP Server configuration

## What it checks

Project should have `.mcp.json` for MCP server integration.

**Status:** Recommended (ask user)

## How to check

```
ls .mcp.json 2>/dev/null
```

## Template to add

Create `.mcp.json` in project root:

```json
{
  "mcpServers": {
    "sequential-thinking": {
      "command": "mcp-server-sequential-thinking"
    }
  }
}
```

## Available MCP servers

| Server | Purpose |
|--------|---------|
| `sequential-thinking` | Step-by-step reasoning for complex problems |

More servers may be added in the future.

## Questions to ask user

- Do you want to enable MCP servers?
- Which servers to include?
