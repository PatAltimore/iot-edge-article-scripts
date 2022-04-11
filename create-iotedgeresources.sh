#!/bin/bash
# Usage: create-iotedge-device.sh <resource group name>

# Create resource group
RESOURCE_GROUP="${1:-IoTEdgeResources}" # First argument or sample value IoTEdgeResources
echo "Creating resource group: $RESOURCE_GROUP..."
az group create --name $RESOURCE_GROUP --location westus2
