#!/bin/bash
# Configure GitHub Copilot-style MCP integration

echo "🤖 Setting up GitHub Copilot-style MCP integration..."

# Check if Node.js and npx are available
if ! command -v node &> /dev/null; then
    echo "❌ Node.js not found. Please install Node.js first."
    exit 1
fi

if ! command -v npx &> /dev/null; then
    echo "❌ npx not found. Please install Node.js with npm."
    exit 1
fi

# Check if Azure CLI is available
if ! command -v az &> /dev/null; then
    echo "❌ Azure CLI not found. Please install Azure CLI first."
    exit 1
fi

# Test Azure MCP server
echo "🧪 Testing Azure MCP server..."
if npx @azure/mcp --help > /dev/null 2>&1; then
    echo "✅ Azure MCP server is available"
else
    echo "❌ Azure MCP server not found. It will be installed during setup."
fi

# Test Kubernetes MCP server
echo "🧪 Testing Kubernetes MCP server..."
if timeout 10 npx mcp-server-kubernetes --help > /dev/null 2>&1; then
    echo "✅ Kubernetes MCP server is available"
else
    echo "❌ Kubernetes MCP server not found. It will be installed during setup."
fi

# Check GitHub CLI (optional)
if command -v gh &> /dev/null; then
    echo "✅ GitHub CLI is available for enhanced GitHub integration"
    if gh auth status > /dev/null 2>&1; then
        echo "✅ GitHub CLI is authenticated"
    else
        echo "💡 GitHub CLI is available but not authenticated. Run 'gh auth login' for enhanced features."
    fi
else
    echo "💡 GitHub CLI not found. Install with 'gh' for enhanced GitHub integration (optional)."
fi

echo ""
echo "✅ GitHub Copilot-style MCP integration configured successfully!"
echo ""
echo "🚀 You can now use natural language queries like:"
echo "   ./scripts/copilot-mcp.sh 'List my AKS clusters'"
echo "   ./scripts/copilot-mcp.sh 'What resources are in my resource group?'"
echo "   ./scripts/copilot-mcp.sh 'Show me Terraform best practices for Azure'"
echo ""
echo "💡 For help and more examples:"
echo "   ./scripts/copilot-mcp.sh --help"
echo ""
echo "🔧 Direct MCP commands are also available:"
echo "   npx @azure/mcp --help"
echo "   npx mcp-server-kubernetes --help"