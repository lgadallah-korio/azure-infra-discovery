#!/bin/bash
# Test MCP server connections and Claude Code

echo "🧪 Testing Azure MCP connection..."
if npx @azure/mcp subscription list > /dev/null 2>&1; then
    echo "✅ Azure MCP server working"
    echo "📋 Available subscriptions:"
    npx @azure/mcp subscription list
else
    echo "❌ Azure MCP server connection failed - check Azure CLI login"
    echo "💡 Try: az login"
fi

echo ""
echo "🧪 Testing GitHub Copilot-style MCP integration..."
if [ -f "./scripts/copilot-mcp.sh" ]; then
    echo "✅ GitHub Copilot-style MCP wrapper found"
    echo "💡 Test natural language queries with:"
    echo "   ./scripts/copilot-mcp.sh 'List my AKS clusters'"
else
    echo "❌ GitHub Copilot-style MCP wrapper not found"
fi

echo ""
echo "🧪 Testing AKS connectivity..."
if kubectl cluster-info > /dev/null 2>&1; then
    echo "✅ Kubernetes connection working"
else
    echo "❌ AKS connection failed - run: az aks get-credentials"
fi
