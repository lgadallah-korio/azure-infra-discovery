#!/bin/bash
# GitHub Copilot-style MCP CLI Wrapper
# Translates natural language queries to MCP commands

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to display help
show_help() {
    echo -e "${BLUE}GitHub Copilot-style MCP CLI Wrapper${NC}"
    echo ""
    echo "Usage: $0 \"natural language query\""
    echo ""
    echo "Examples:"
    echo "  $0 \"List my AKS clusters\""
    echo "  $0 \"What resources are in my resource group?\""
    echo "  $0 \"Show me Terraform best practices for Azure\""
    echo "  $0 \"List all Azure subscriptions\""
    echo "  $0 \"Get AKS cluster configuration\""
    echo ""
    echo "This tool translates natural language queries into MCP server commands."
    echo "It provides the same functionality as the previous Claude CLI integration."
}

# Function to execute MCP command with error handling
execute_mcp_command() {
    local cmd="$1"
    local description="$2"
    
    echo -e "${BLUE}🤖 Executing: ${description}${NC}"
    echo -e "${YELLOW}Command: ${cmd}${NC}"
    echo ""
    
    if eval "$cmd"; then
        echo ""
        echo -e "${GREEN}✅ Query completed successfully${NC}"
    else
        echo ""
        echo -e "${RED}❌ Query failed. Please check your Azure authentication and MCP server setup.${NC}"
        echo -e "${YELLOW}💡 Try running: ./scripts/test-connections.sh${NC}"
        return 1
    fi
}

# Function to parse natural language query and translate to MCP command
parse_query() {
    local query="$(echo "$1" | tr '[:upper:]' '[:lower:]')"
    
    # Help queries (no Azure auth needed)
    if [[ "$query" =~ (help|usage|how to|what can) ]]; then
        show_help
        return 0
    fi
    
    # Check if this is a query that needs Azure authentication
    local needs_azure=false
    if [[ "$query" =~ (list|show|get|configuration|config|describe|resources in|what.*in|terraform.*best|best.*terraform).*(aks|cluster|resource group|rg|subscription|vnet|virtual network|network|storage|account|resource|all|practice|practices) ]] ||
       [[ "$query" =~ (aks|cluster|resource group|rg|subscription|vnet|virtual network|network|storage|account|resource|all).*(list|show|get|configuration|config|describe|resources) ]]; then
        needs_azure=true
    fi
    
    # Check Azure authentication only if needed
    if [ "$needs_azure" = true ]; then
        if ! az account show > /dev/null 2>&1; then
            echo -e "${RED}❌ Not authenticated to Azure. Please run 'az login'.${NC}"
            return 1
        fi
    fi
    
    # AKS/Kubernetes related queries
    if [[ "$query" =~ (list|show|get).*(aks|cluster) ]] || [[ "$query" =~ (aks|cluster).*(list|show|get) ]]; then
        execute_mcp_command "npx @azure/mcp aks cluster list" "Listing AKS clusters"
        
    elif [[ "$query" =~ (configuration|config|describe).*(aks|cluster) ]] || [[ "$query" =~ (aks|cluster).*(configuration|config|describe) ]]; then
        execute_mcp_command "npx @azure/mcp aks cluster describe" "Getting AKS cluster configuration"
        
    # Resource Group queries
    elif [[ "$query" =~ (resources in|what.*in).*(resource group|rg) ]] || [[ "$query" =~ (resource group|rg).*(resources|list) ]]; then
        execute_mcp_command "npx @azure/mcp group list" "Listing resource groups and their resources"
        
    elif [[ "$query" =~ (list|show|get).*(resource group|rg) ]]; then
        execute_mcp_command "npx @azure/mcp group list" "Listing resource groups"
        
    # Subscription queries
    elif [[ "$query" =~ (list|show|get).*(subscription) ]]; then
        execute_mcp_command "npx @azure/mcp subscription list" "Listing Azure subscriptions"
        
    # Terraform best practices
    elif [[ "$query" =~ terraform.*best.*(practice|practices) ]] || [[ "$query" =~ best.*(practice|practices).*terraform ]]; then
        execute_mcp_command "npx @azure/mcp azureterraformbestpractices" "Getting Terraform best practices for Azure"
        
    # Virtual Network queries
    elif [[ "$query" =~ (list|show|get).*(vnet|virtual network|network) ]]; then
        execute_mcp_command "npx @azure/mcp network vnet list" "Listing virtual networks"
        
    # Storage queries
    elif [[ "$query" =~ (list|show|get).*(storage|account) ]]; then
        execute_mcp_command "npx @azure/mcp storage account list" "Listing storage accounts"
        
    # General resource queries
    elif [[ "$query" =~ (list|show|get).*(resource|all) ]]; then
        execute_mcp_command "npx @azure/mcp resource list" "Listing all Azure resources"
        
    else
        echo -e "${YELLOW}🤔 I'm not sure how to handle that query. Here are some examples:${NC}"
        echo ""
        show_help
        echo ""
        echo -e "${BLUE}📝 Your query: \"$1\"${NC}"
        echo -e "${YELLOW}💡 Try rephrasing your query or use one of the examples above.${NC}"
        echo ""
        echo -e "${BLUE}🔧 You can also run MCP commands directly:${NC}"
        echo "  npx @azure/mcp --help"
        echo "  npx mcp-server-kubernetes --help"
        return 1
    fi
}

# Main script logic
main() {
    # Check if query is provided
    if [ $# -eq 0 ] || [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
        show_help
        exit 0
    fi
    
    # Handle help queries without Azure authentication
    local query="$(echo "$1" | tr '[:upper:]' '[:lower:]')"
    if [[ "$query" =~ (help|usage|how to|what can) ]]; then
        show_help
        exit 0
    fi
    
    # Check dependencies
    if ! command -v npx &> /dev/null; then
        echo -e "${RED}❌ npx not found. Please install Node.js.${NC}"
        exit 1
    fi
    
    if ! command -v az &> /dev/null; then
        echo -e "${RED}❌ Azure CLI not found. Please install Azure CLI.${NC}"
        exit 1
    fi
    
    local query="$1"
    echo -e "${BLUE}🚀 GitHub Copilot-style Azure Infrastructure Discovery${NC}"
    echo -e "${BLUE}Query: \"${query}\"${NC}"
    echo ""
    
    parse_query "$query"
}

# Run the main function with all arguments
main "$@"