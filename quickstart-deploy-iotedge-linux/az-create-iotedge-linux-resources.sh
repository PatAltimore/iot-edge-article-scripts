# Usage: az-create-iotedge-linux-resources.sh <resource group name> <IoT Hub name> <IoT device ID name> <IoT device VM name>
# https://docs.microsoft.com/azure/iot-edge/quickstart-linux

: '
if [ $# -eq 0 ] then
    echo 'Usage: az-create-iotedge-linux-resources.sh <resource group name> <IoT Hub name> <IoT device ID name> <IoT device VM name>'
    echo 'Setting default values...'
    echo 'az-create-iotedge-linux-resources.sh IoTEdgeResources patrickaIoTHub myEdgeDevice patrickaDeviceVM'
    $1='IoTEdgeResources'
    $2='patrickaIoTHub'
    $3='myEdgeDevice'
    $4='patrickaDeviceVM'
fi
'

# Create resource group
echo "Resource group name: $1"
az group create --name $1 --location westus2

# Create IoT Hub

echo "IoT Hub name: $2"
az iot hub create --resource-group $1 --name $2 --sku F1 --partition-count 2

# Create IoT device
echo "IoT device id name: $3"
az iot hub device-identity create --device-id $3 --edge-enabled --hub-name $2 --resource-group $1

# Show IoT device connection string
echo "IoT device id $3 connection string:"
az iot hub device-identity connection-string show --device-id $3 --hub-name $2 --resource-group $1

# Create IoT Edge deployment
PASSWORD=$(</dev/urandom tr -dc _A-Z-a-z-0-9 | head -c12)
echo "Generated password for VM: $PASSWORD"

echo "Linux VM name: $4"
az deployment group create \
--resource-group IoTEdgeResources \
--template-uri "https://raw.githubusercontent.com/Azure/iotedge-vm-deploy/1.2/edgeDeploy.json" \
--parameters dnsLabelPrefix="$4" \
--parameters adminUsername='azureUser' \
--parameters deviceConnectionString=$(az iot hub device-identity connection-string show --device-id myEdgeDevice --hub-name patricka-iot-hub -o tsv) \
--parameters authenticationType='password' \
--parameters adminPasswordOrKey="$PASSWORD"
