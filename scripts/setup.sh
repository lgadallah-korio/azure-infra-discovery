#!/bin/bash
# Complete environment setup

echo "🚀 Setting up Azure Infrastructure Discovery Environment"

# Check dependencies
echo "📦 Checking dependencies..."
command -v node >/dev/null 2>&1 || { echo "❌ Node.js required"; exit 1; }
command -v az >/dev/null 2>&1 || { echo "❌ Azure CLI required"; exit 1; }

# Install MCP servers
echo "📥 Installing MCP servers..."
npm install -g @azure/mcp
npm install -g mcp-server-kubernetes

# Configure GitHub Copilot-style MCP integration
echo "🤖 Configuring GitHub Copilot-style MCP integration..."
if [ -f "./scripts/configure-copilot-mcp.sh" ]; then
    ./scripts/configure-copilot-mcp.sh
else
    echo "⚠️  GitHub Copilot MCP configuration script not found"
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
