#!/bin/bash
# Usage: create-iotedge-device.sh <resource group name> <IoT Hub name> <IoT device ID name>

# Set up variables based on arguments or defaults
RESOURCE_GROUP="${1:-patricka-IoTEdgeResources}" # First argument or sample value patricka-IoTEdgeResources
IOT_HUB="${2:-patrickaIoTHub}" # Second argument or sample value patrickaIoTHub
IOT_DEVICE="${3:-myEdgeDevice}" # Third argument or sample value myEdgeDevice

# Create IoT device
echo "$(tput setaf 3)Creating IoT device id: $IOT_DEVICE...$(tput setaf 7)"
az iot hub device-identity create --device-id $IOT_DEVICE --edge-enabled --hub-name $IOT_HUB

# Show IoT device connection string
echo "$(tput setaf 1)IoT device id $IOT_DEVICE connection string:$(tput setaf 7)"
az iot hub device-identity connection-string show --device-id $IOT_DEVICE --hub-name $IOT_HUB --resource-group $RESOURCE_GROUP
