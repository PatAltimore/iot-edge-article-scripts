# Usage: az-create-iotedge-windows-resources.sh <resource group name> <IoT Hub name> <IoT device ID name> 
# https://docs.microsoft.com/azure/iot-edge/quickstart

if [ $# -eq 0 ]
  then
    echo "Usage: az-create-iotedge-resources.sh <resource group name> <IoT Hub name> <IoT device ID name>"
    exit 1
fi

echo "Resource group: $1"
az group create --name $1 --location westus2

echo "IoT Hub: $2"
az iot hub create --resource-group $1 --name $2 --sku F1 --partition-count 2

echo "IoT device id: $3"
az iot hub device-identity create --device-id $3 --edge-enabled --hub-name $2 --resource-group $1

echo "IoT device id $3 connection string:"
az iot hub device-identity connection-string show --device-id $3 --hub-name $2 --resource-group $1