#!/bin/bash
# Usage: quickstart-create-iotedge-linux.sh <resource group name> <IoT Hub name> <IoT device ID name> <IoT device VM name> <Key Vault name>
# https://docs.microsoft.com/azure/iot-edge/quickstart-linux
# https://github.com/Azure/iot-edge-config/blob/main/src/azure-iot-edge-installer.sh

# Set up variables based on arguments or defaults
RESOURCE_GROUP="${1:-patricka-IoTEdgeResources}" # First argument or sample value patricka-IoTEdgeResources
IOT_HUB="${2:-patricka-iot-hub}" # Second argument or sample value patricka-iot-hub
IOT_DEVICE="${3:-patricka-iotedge-device}" # Third argument or sample value patricka-iotedge-device
VM_NAME="${4:-patricka-iotedge-vm}" # Fourth argument or sample value patricka-iotedge-vm
KEYVAULT_NAME="${5:-patricka-keyvault}" # Fifth argument or sample value patricka-keyvault

# Call scripts to create resources
source create-iotedgeresources.sh $RESOURCE_GROUP
source create-iot-hub.sh $RESOURCE_GROUP $IOT_HUB
source create-keyvault.sh $RESOURCE_GROUP $KEYVAULT_NAME
source create-iotedge-device.sh $RESOURCE_GROUP $IOT_HUB $IOT_DEVICE
source deploy-iotedge-linux-device.sh $RESOURCE_GROUP $IOT_HUB $IOT_DEVICE $VM_NAME $KEYVAULT_NAME
