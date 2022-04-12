# Usage: create-iotedge-linux.sh <resource group name> <IoT Hub name> <IoT device ID name> <IoT device VM name>
# https://docs.microsoft.com/azure/iot-edge/quickstart-linux

# Create resource group
RESOURCE_GROUP="${1:-patricka-IoTEdgeResources}" # First argument or sample value patricka-IoTEdgeResources
echo "Creating resource group $RESOURCE_GROUP..."
az group create --name $RESOURCE_GROUP --location westus2

# Create IoT Hub
IOT_HUB="${2:-patricka-iot-hub}" # Second argument or sample value patricka-iot-hub
echo "Creating IoT Hub $IOT_HUB..."
az iot hub create --resource-group $RESOURCE_GROUP --name $IOT_HUB --sku F1 --partition-count 2

# Create IoT device
IOT_DEVICE="${3:-patricka-iotedge-device}" # Third argument or sample value patricka-iotedge-device
echo "Creating IoT device id $IOT_DEVICE..."
az iot hub device-identity create --device-id $IOT_DEVICE --edge-enabled --hub-name $IOT_HUB --resource-group $RESOURCE_GROUP

# Show IoT device connection string
echo "IoT device id $IOT_DEVICE connection string:"
az iot hub device-identity connection-string show --device-id $IOT_DEVICE --hub-name $IOT_HUB --resource-group $RESOURCE_GROUP

# Deploy IoT Edge device as a Linux VM
PASSWORD=$(tr -dc -- '_A-Za-z0-9' < /dev/urandom | head -c 12)
echo "Generated password for VM: $PASSWORD"
VM_NAME="${4:-patricka-iotedge-vm}" # Fourth argument or sample value patricka-iotedge-vm
echo "Creating Linux VM name $VM_NAME..."
az deployment group create \
--resource-group "$RESOURCE_GROUP" \
--template-uri "https://raw.githubusercontent.com/Azure/iotedge-vm-deploy/1.2/edgeDeploy.json" \
--parameters dnsLabelPrefix="$VM_NAME" \
--parameters adminUsername='azureUser' \
--parameters deviceConnectionString="$(az iot hub device-identity connection-string show --device-id $IOT_DEVICE --hub-name $IOT_HUB $IOT_HUB -o tsv)" \
--parameters authenticationType='password' \
--parameters adminPasswordOrKey="$PASSWORD"
