# Usage: create-iotedge-linux-resources.sh <resource group name> <IoT Hub name> <IoT device ID name> <IoT device VM name>
# https://docs.microsoft.com/azure/iot-edge/quickstart-linux

# Create resource group
RESOURCE_GROUP="${1:-IoTEdgeResources}" # First argument or sample value IoTEdgeResources
echo "Creating resource group $RESOURCE_GROUP..."
az group create --name $RESOURCE_GROUP --location westus2

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

# Create IoT Edge deployment
PASSWORD=$(</dev/urandom tr -dc _A-Z-a-z-0-9 | head -c12)
echo "Generated password for VM: $PASSWORD"
VM_NAME="${4:-patrickaIoTEdgeVM}" # Fourth argument or sample value patrickaIoTEdgeVM
echo "Creating Linux VM name $VM_NAME..."
./az deployment group create \
--resource-group "$RESOURCE_GROUP" \
--template-uri "https://raw.githubusercontent.com/Azure/iotedge-vm-deploy/1.2/edgeDeploy.json" \
--parameters dnsLabelPrefix="$VM_NAME" \
--parameters adminUsername='azureUser' \
--parameters deviceConnectionString="$(az iot hub device-identity connection-string show --device-id $IOT_DEVICE --hub-name $IOT_HUB -o tsv)" \
--parameters authenticationType='password' \
--parameters adminPasswordOrKey="$PASSWORD"
