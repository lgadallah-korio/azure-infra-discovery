#!/bin/bash
# Create infrastructure snapshot

TIMESTAMP=$(date +%Y%m%d_%H%M%S)
SNAPSHOT_DIR="exports/snapshot_$TIMESTAMP"

echo "📸 Creating infrastructure snapshot: $SNAPSHOT_DIR"
mkdir -p "$SNAPSHOT_DIR"

# Export Azure resources
echo "Exporting Azure resources..."
az resource list --output json > "$SNAPSHOT_DIR/azure_resources.json"

# Export AKS state if connected
if kubectl cluster-info > /dev/null 2>&1; then
    echo "Exporting Kubernetes state..."
    kubectl get all --all-namespaces -o yaml > "$SNAPSHOT_DIR/k8s_resources.yaml"
    kubectl get nodes -o yaml > "$SNAPSHOT_DIR/k8s_nodes.yaml"
fi

# Create snapshot summary
cat > "$SNAPSHOT_DIR/README.md" << EOL
# Infrastructure Snapshot: $TIMESTAMP

## Contents
- \`azure_resources.json\` - All Azure resources
- \`k8s_resources.yaml\` - Kubernetes resources (if available)  
- \`k8s_nodes.yaml\` - AKS node information

## Discovery Status
[Copy current status from docs/DISCOVERY.md]

## Next Steps
[Add your next steps]
EOL

echo "✅ Snapshot saved to: $SNAPSHOT_DIR"
echo "💡 Consider committing this snapshot to git"
