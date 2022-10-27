#!/bin/bash
# Usage: create-test-device.sh <IoT device ID name>
# Use defaults to create test device

# Set up variables based on arguments or defaults
RESOURCE_GROUP="patricka-iotedgeresources"
IOT_HUB="patricka-iot-hub"
IOT_DEVICE="${1:-patricka-device1}" # First argument or sample value patricka-iotedge-device
VM_NAME="${IOT_DEVICE}-vm"
KEYVAULT_NAME="patricka-keyvault"

# Call scripts to create resources
source create-iotedge-device.sh $RESOURCE_GROUP $IOT_HUB $IOT_DEVICE
source deploy-iotedge-linux-device-ssh.sh $RESOURCE_GROUP $IOT_HUB $IOT_DEVICE $VM_NAME $KEYVAULT_NAME
