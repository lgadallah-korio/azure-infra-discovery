#!/bin/bash
# Azure Authentication Setup

echo "🔐 Setting up Azure authentication..."

# Check if Azure CLI is installed
if ! command -v az &> /dev/null; then
    echo "❌ Azure CLI not found. Please install it first."
    exit 1
fi

# Login to Azure
echo "Please log in to Azure..."
az login

# List subscriptions
echo "📋 Available subscriptions:"
az account list --output table

# Prompt for subscription
read -p "Enter your subscription ID: " SUBSCRIPTION_ID
az account set --subscription "$SUBSCRIPTION_ID"

# Update config files
sed -i.bak "s/YOUR_SUBSCRIPTION_ID/$SUBSCRIPTION_ID/g" azure-mcp-config.json
sed -i.bak "s/YOUR_SUBSCRIPTION_ID/$SUBSCRIPTION_ID/g" aks-mcp-config.json

echo "✅ Authentication configured for subscription: $SUBSCRIPTION_ID"
echo "⚠️  Please update resource group names in config files manually"
