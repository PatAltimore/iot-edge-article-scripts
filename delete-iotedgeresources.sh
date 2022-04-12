#!/bin/bash
# Usage: delete-IoTEdgeResources.sh <resource group name>

# Delete resource group
RESOURCE_GROUP="${1:-patricka-IoTEdgeResources}" # First argument or sample value patricka-IoTEdgeResources
echo "Deleting resource group: $RESOURCE_GROUP"
az group delete --name $RESOURCE_GROUP --yes
