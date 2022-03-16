# Usage: deploy-eflow.ps1 <connection string>
# https://docs.microsoft.com/azure/iot-edge/quickstart#install-and-start-the-iot-edge-runtime

Param
(
  [parameter(mandatory=$true, helpmessage="Enter the connection string for the IoT Hub:")]
  [ValidateNotNull()]
  $connectionString
)

# Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All

Write-Output "Installing Azure IoT Edge MSI"
$msiPath = $([io.Path]::Combine($env:TEMP, 'AzureIoTEdge.msi'))
$ProgressPreference = 'SilentlyContinue'
Invoke-WebRequest "https://aka.ms/AzEflowMSI" -OutFile $msiPath

Write-Output "Starting Azure IoT Edge on Windows"
Start-Process -Wait msiexec -ArgumentList "/i","$([io.Path]::Combine($env:TEMP, 'AzureIoTEdge.msi'))","/qn"

# Get-ExecutionPolicy -List
# Set-ExecutionPolicy -ExecutionPolicy AllSigned -Force

Deploy-Eflow

Provision-EflowVm -provisioningType ManualConnectionString -devConnString "connectionString": $connectionString

