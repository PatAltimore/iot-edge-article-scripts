#!/bin/bash
# Usage: deploy-iotedge-linux-device.sh <resource group name> <IoT Hub name> <IoT device ID name> <IoT device VM name>
# https://docs.microsoft.com/azure/iot-edge/quickstart-linux

# Set up variables based on arguments or defaults
RESOURCE_GROUP="${1:-IoTEdgeResources}" # First argument or sample value IoTEdgeResources
IOT_HUB="${2:-patricka-iot-hub}" # Second argument or sample value patricka-iot-hub
IOT_DEVICE="${3:-patricka-iotedge-device}" # Third argument or sample value patricka-iotedge-device
VM_NAME="${4:-patricka-iotedge-vm}" # Fourth argument or sample value patricka-iotedge-vm

# Deploy IoT Edge device as a Linux VM
PASSWORD=$(tr -dc -- '_A-Za-z0-9' < /dev/urandom | head -c 12)
echo "Generated password for VM: $PASSWORD"

echo "Creating Linux VM name $VM_NAME..."
az deployment group create \
--resource-group "$RESOURCE_GROUP" \
--template-uri "https://raw.githubusercontent.com/Azure/iotedge-vm-deploy/1.2/edgeDeploy.json" \
--parameters dnsLabelPrefix="$VM_NAME" \
--parameters adminUsername='azureUser' \
--parameters deviceConnectionString="$(az iot hub device-identity connection-string show --device-id $IOT_DEVICE --hub-name $IOT_HUB -o tsv)" \
--parameters authenticationType='password' \
--parameters adminPasswordOrKey="$PASSWORD"
