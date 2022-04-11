#!/bin/bash
# Usage: create-iot-hub <resource group name> <IoT Hub name>

# Set up variables based on arguments or defaults
RESOURCE_GROUP="${1:-IoTEdgeResources}" # First argument or sample value IoTEdgeResources
IOT_HUB="${2:-patrickaIoTHub}" # Second argument or sample value patrickaIoTHub

# Create IoT Hub
echo "Creating IoT Hub: $IOT_HUB..."
az iot hub create --resource-group $RESOURCE_GROUP --name $IOT_HUB --sku F1 --partition-count 2
