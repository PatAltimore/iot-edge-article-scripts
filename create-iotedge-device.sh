# Usage: create-iotedge-device.sh <resource group name> <IoT Hub name> <IoT device ID name>
#
# Download/run:
# curl -ssl https://raw.githubusercontent.com/PatAltimore/iot-edge-article-scripts/master/create-iotedge-device.sh -o create-iotedge-device.sh
# chmod +x create-iotedge-device.sh
# ./create-iotedge-device.sh

# Create resource group
RESOURCE_GROUP="${1:-IoTEdgeResources}" # First argument or sample value IoTEdgeResources
echo "Resource group: $RESOURCE_GROUP"
az group create --name $RESOURCE_GROUP --location westus2

# Create IoT Hub
IOT_HUB="${2:-patrickaIoTHub}" # Second argument or sample value patrickaIoTHub
echo "IoT Hub: $IOT_HUB"
az iot hub create --resource-group $RESOURCE_GROUP --name $IOT_HUB --sku F1 --partition-count 2

# Create IoT device
IOT_DEVICE="${3:-myEdgeDevice}" # Third argument or sample value myEdgeDevice
echo "IoT device id: $IOT_DEVICE"
az iot hub device-identity create --device-id $IOT_DEVICE --edge-enabled --hub-name $IOT_HUB

# Show IoT device connection string
echo "IoT device id $IOT_DEVICE connection string:"
az iot hub device-identity connection-string show --device-id $IOT_DEVICE --hub-name $IOT_HUB --resource-group $RESOURCE_GROUP
