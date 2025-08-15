#!/bin/bash
# Configure Claude Code with Azure MCP server

echo "🤖 Setting up Claude Code with Azure MCP server..."

# Check if Claude Code is available
if ! command -v claude &> /dev/null; then
    echo "❌ Claude Code not found. Installing..."
    npm install -g @anthropic-ai/claude-code
fi

# Create Claude Code configuration directory
mkdir -p ~/.claude-code

# Configure Claude Code to use Azure MCP server
cat > ~/.claude-code/config.json << EOL
{
  "mcpServers": {
    "azure": {
      "command": "npx",
      "args": ["@azure/mcp", "server", "start"]
    }
  },
  "defaultModel": "claude-3-sonnet-20240229"
}
EOL

echo "✅ Claude Code configured with Azure MCP server"
echo "💡 You can now use natural language queries like:"
echo "   claude 'List my AKS clusters'"
echo "   claude 'What resources are in my vozni-test-rg resource group?'"
echo "   claude 'Show me Terraform best practices for Azure'"
