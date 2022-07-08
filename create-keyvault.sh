#!/bin/bash
# Usage: create-keyvault.sh <resource group name> <Key Vault name>
# https://github.com/Azure/iotedge-vm-deploy/tree/1.2

# Set up variables based on arguments or defaults
RESOURCE_GROUP="${1:-patricka-IoTEdgeResources}" # First argument or sample value patricka-IoTEdgeResources
KEYVAULT_NAME="${2:-patricka-keyvault}" # Second argument or sample value patricka-keyvault

printf "$(tput setaf 3)Creating Key Vault '%s'.$(tput setaf 7)...\n" $KEYVAULT_NAME

az keyvault create \
    --name "$KEYVAULT_NAME" \
    --resource-group "$RESOURCE_GROUP" \
    --location 'EastUS'
