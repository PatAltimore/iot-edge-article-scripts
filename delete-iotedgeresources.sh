# Usage: delete-iotedgeresources.sh <resource group name>

# Delete resource group
RESOURCE_GROUP="${1:-IoTEdgeResources}" # First argument or sample value IoTEdgeResources
echo "Deleting resource group: $RESOURCE_GROUP"
az group delete --name $RESOURCE_GROUP --yes
