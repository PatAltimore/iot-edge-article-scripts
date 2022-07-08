#!/bin/bash
# Usage: create-iotedge-device.sh <resource group name>

# Create resource group
RESOURCE_GROUP="${1:-patricka-IoTEdgeResources}" # First argument or sample value patricka-IoTEdgeResources
echo "$(tput setaf 3)Creating resource group: $RESOURCE_GROUP...$(tput setaf 7)"
az group create --name $RESOURCE_GROUP --location eastus
