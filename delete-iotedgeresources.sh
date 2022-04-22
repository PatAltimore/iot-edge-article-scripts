#!/bin/bash
# Usage: delete-IoTEdgeResources.sh <resource group name>

# Delete resource group
RESOURCE_GROUP="${1:-patricka-IoTEdgeResources}" # First argument or sample value patricka-IoTEdgeResources
echo "$(tput setaf 3)Deleting resource group: $RESOURCE_GROUP$(tput setaf 7)"
az group delete --name $RESOURCE_GROUP --yes
