#!/bin/bash
# Usage: quickstart-create-iotedge-linux.sh <resource group name> <IoT Hub name> <IoT device ID name> <IoT device VM name> <Second IoT device ID name> <Second IoT device VM name>
# https://docs.microsoft.com/azure/iot-edge/how-to-connect-downstream-iot-edge-device

# Set up variables based on arguments or defaults
RESOURCE_GROUP="${1:-patricka-IoTEdgeResources}" # First argument or sample value patricka-IoTEdgeResources
IOT_HUB="${2:-patricka-iot-hub}" # Second argument or sample value patricka-iot-hub
IOT_DEVICE="${3:-patricka-iotedge-device}" # Third argument or sample value patricka-iotedge-device
VM_NAME="${4:-patricka-iotedge-vm}" # Fourth argument or sample value patricka-iotedge-vm
IOT_DEVICE2="${5:-patricka-iotedge-device2}" # Fifth argument or sample value patricka-iotedge-device2
VM_NAME2="${6:-patricka-iotedge-vm2}" # Sixth argument or sample value patricka-iotedge-vm2
KEYVAULT_NAME="${5:-patricka-keyvault2}" # Fifth argument or sample value patricka-keyvault

# Call scripts to create resources
source create-iotedgeresources.sh $RESOURCE_GROUP
source create-iot-hub.sh $RESOURCE_GROUP $IOT_HUB
source create-keyvault.sh $RESOURCE_GROUP $KEYVAULT_NAME
source create-iotedge-device.sh $RESOURCE_GROUP $IOT_HUB $IOT_DEVICE
source deploy-iotedge-linux-device.sh $RESOURCE_GROUP $IOT_HUB $IOT_DEVICE $VM_NAME $KEYVAULT_NAME
source create-iotedge-device.sh $RESOURCE_GROUP $IOT_HUB $IOT_DEVICE2
source deploy-iotedge-linux-device.sh $RESOURCE_GROUP $IOT_HUB $IOT_DEVICE2 $VM_NAME2 $KEYVAULT_NAME
