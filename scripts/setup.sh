#!/bin/bash
# Complete environment setup

echo "🚀 Setting up Azure Infrastructure Discovery Environment"

# Check dependencies
echo "📦 Checking dependencies..."
command -v node >/dev/null 2>&1 || { echo "❌ Node.js required"; exit 1; }
command -v az >/dev/null 2>&1 || { echo "❌ Azure CLI required"; exit 1; }

# Install MCP servers and Claude Code
echo "📥 Installing MCP servers and Claude Code..."
npm install -g @azure/mcp
npm install -g mcp-server-kubernetes
npm install -g @anthropic-ai/claude-code

# Configure Claude Code with MCP server
echo "🤖 Configuring Claude Code..."
if [ -f "./scripts/configure-claude-code.sh" ]; then
    ./scripts/configure-claude-code.sh
else
    echo "⚠️  Claude Code configuration script not found"
fi

# Configure authentication
echo "🔐 Checking Azure authentication..."
if az account show > /dev/null 2>&1; then
    echo "✅ Already authenticated to Azure"
    CURRENT_SUB=$(az account show --query id -o tsv)
    echo "📋 Current subscription: $CURRENT_SUB"
    
    # Update config files with current subscription
    if [ -f "configs/azure-mcp-config.json" ]; then
        sed -i.bak "s/YOUR_SUBSCRIPTION_ID/$CURRENT_SUB/g" configs/azure-mcp-config.json
    fi
    if [ -f "configs/aks-mcp-config.json" ]; then
        sed -i.bak "s/YOUR_SUBSCRIPTION_ID/$CURRENT_SUB/g" configs/aks-mcp-config.json
    fi
    echo "✅ Configuration files updated with current subscription"
else
    echo "🔐 Configuring Azure authentication..."
    cd configs && ./auth-setup.sh && cd ..
fi

# Test connections
echo "🧪 Testing connections..."
./scripts/test-connections.sh

echo "✅ Setup complete! Check docs/DISCOVERY.md to start exploring."
