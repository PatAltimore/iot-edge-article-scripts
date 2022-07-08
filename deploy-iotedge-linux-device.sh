#!/bin/bash
# Usage: deploy-iotedge-linux-device.sh <resource group name> <IoT Hub name> <IoT device ID name> <IoT device VM name> <Key Vault name>
# https://github.com/Azure/iotedge-vm-deploy/tree/1.2

# Set up variables based on arguments or defaults
RESOURCE_GROUP="${1:-patricka-IoTEdgeResources}" # First argument or sample value patricka-IoTEdgeResources
IOT_HUB="${2:-patricka-iot-hub}" # Second argument or sample value patricka-iot-hub
IOT_DEVICE="${3:-patricka-iotedge-device}" # Third argument or sample value patricka-iotedge-device
VM_NAME="${4:-patricka-iotedge-vm}" # Fourth argument or sample value patricka-iotedge-vm
KEYVAULT_NAME="${5:-patricka-keyvault}" # Fifth argument or sample value patricka-keyvault

# Generate password and store in keyvault
PASSWORD=$(openssl rand -base64 12)
echo "$(tput setaf 1)Generated password for VM: $PASSWORD$(tput setaf 7)"

az keyvault secret set \
    --vault-name "$KEYVAULT_NAME" \
    --name "$VM_NAME" \
    --value "$PASSWORD"

# Deploy IoT Edge device as a Linux VM
echo "$(tput setaf 3)Creating Linux VM name $VM_NAME...$(tput setaf 7)"
az deployment group create \
--resource-group "$RESOURCE_GROUP" \
--template-uri "https://raw.githubusercontent.com/Azure/iotedge-vm-deploy/1.2/edgeDeploy.json" \
--parameters dnsLabelPrefix="$VM_NAME" \
--parameters adminUsername='azureUser' \
--parameters deviceConnectionString="$(az iot hub device-identity connection-string show --device-id $IOT_DEVICE --hub-name $IOT_HUB -o tsv)" \
--parameters authenticationType='password' \
--parameters adminPasswordOrKey="$PASSWORD"

# Set auto-shutdown
echo "$(tput setaf 3)Setting VM auto-shutdown...$(tput setaf 7)"
az vm auto-shutdown \
--resource-group "$RESOURCE_GROUP" \
--name "$VM_NAME"
--time 0200