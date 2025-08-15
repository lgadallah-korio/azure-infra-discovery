# Azure Infrastructure Discovery Project

This workspace contains all tools and documentation for reverse-engineering Azure infrastructure to Terraform.

## Quick Start
1. Run `./scripts/setup.sh` to configure environment
2. Configure Azure authentication in `configs/`
3. Start discovery with natural language queries using Claude Code
4. Track progress in `docs/DISCOVERY.md`

## Natural Language Queries (Recommended)
Use Claude Code for natural language infrastructure discovery:
```bash
claude "List my AKS clusters"
claude "What resources are in my vozni-test-rg resource group?"
claude "Show me the configuration of my vozni-test-aks cluster"
claude "Give me Terraform best practices for Azure"
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

