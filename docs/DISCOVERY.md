# Infrastructure Discovery Log

## Project Overview
- **Goal**: Reverse-engineer Azure infrastructure to Terraform
- **Scope**: AKS-based web application with networking, security, identity
- **Timeline**: [Add your timeline]

## Current Infrastructure Inventory

### Discovered Resources
| Resource Type | Name | Resource Group | Notes | Terraform Status |
|---------------|------|----------------|-------|------------------|
| AKS Cluster   |      |                |       | ⏳ Pending      |
| Load Balancer |      |                |       | ⏳ Pending      |
| VNet          |      |                |       | ⏳ Pending      |
| NSG           |      |                |       | ⏳ Pending      |
| B2C Tenant    |      |                |       | ⏳ Pending      |

### Resource Relationships
```
[Draw/describe connections between resources]
Load Balancer -> AKS Services
VNet -> Subnets -> AKS Nodes
NSGs -> Subnets
B2C -> Applications
```

## Discovery Sessions

### How to Run Queries
Use the GitHub Copilot-style wrapper for natural language queries:
```bash
./scripts/copilot-mcp.sh "List my AKS clusters"
./scripts/copilot-mcp.sh "What resources are in my resource group?"
./scripts/copilot-mcp.sh "Show me Terraform best practices for Azure"
```

### Session 1: [Date]
**Queries Run:**
- 

**Key Findings:**
- 

**Next Steps:**
- 

## Questions & Assumptions
- [ ] What's the traffic flow for the web application?
- [ ] Which environments exist (dev/staging/prod)?
- [ ] Are there any undocumented dependencies?

## Terraform Generation Progress
- [ ] VNet and subnets
- [ ] Network Security Groups  
- [ ] AKS cluster configuration
- [ ] Load balancer setup
- [ ] Identity and B2C integration
- [ ] Complete end-to-end validation
