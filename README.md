# Azure Infrastructure Discovery Project

This workspace contains all tools and documentation for reverse-engineering Azure infrastructure to Terraform.

## Quick Start
1. Run `./scripts/setup.sh` to configure environment
2. Configure Azure authentication in `configs/`
3. Start discovery with natural language queries using GitHub Copilot-style integration
4. Track progress in `docs/DISCOVERY.md`

## Natural Language Queries (Recommended)
Use the GitHub Copilot-style wrapper for natural language infrastructure discovery:
```bash
./scripts/copilot-mcp.sh "List my AKS clusters"
./scripts/copilot-mcp.sh "What resources are in my vozni-test-rg resource group?"
./scripts/copilot-mcp.sh "Show me the configuration of my vozni-test-aks cluster"
./scripts/copilot-mcp.sh "Give me Terraform best practices for Azure"
```

## Direct MCP Commands (Alternative)
```bash
npx @azure/mcp aks cluster list
npx @azure/mcp group list
npx @azure/mcp azureterraformbestpractices
```

## Structure
- `docs/` - Documentation and findings
- `configs/` - MCP and tool configurations  
- `queries/` - Saved queries and results
- `exports/` - Infrastructure snapshots
- `terraform/` - Generated Terraform code
- `scripts/` - Automation helpers

