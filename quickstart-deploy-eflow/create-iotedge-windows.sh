# Usage: create-iotedge-windows.sh <resource group name> <IoT Hub name> <IoT device ID name> 
# https://docs.microsoft.com/azure/iot-edge/quickstart

# Create resource group
RESOURCE_GROUP="${1:-patricka-IoTEdgeResources}" # First argument or sample value patricka-IoTEdgeResources
echo "Creating resource group $RESOURCE_GROUP..."
az group create --name $RESOURCE_GROUP --location westus

# Create IoT Hub
IOT_HUB="${2:-patrickaIoTHub}" # Second argument or sample value patrickaIoTHub
echo "Creating IoT Hub $IOT_HUB..."
az iot hub create --resource-group $RESOURCE_GROUP --name $IOT_HUB --sku F1 --partition-count 2

# Create IoT device
IOT_DEVICE="${3:-myEdgeDevice}" # Third argument or sample value myEdgeDevice
echo "Creating IoT device id $IOT_DEVICE..."
az iot hub device-identity create --device-id $IOT_DEVICE --edge-enabled --hub-name $IOT_HUB --resource-group $RESOURCE_GROUP

# Show IoT device connection string
echo "IoT device id $IOT_DEVICE connection string:"
az iot hub device-identity connection-string show --device-id $IOT_DEVICE --hub-name $IOT_HUB --resource-group $RESOURCE_GROUP