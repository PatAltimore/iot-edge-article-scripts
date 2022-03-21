# Usage: deploy-eflow.ps1 <connection string>
# https://docs.microsoft.com/azure/iot-edge/quickstart#install-and-start-the-iot-edge-runtime

Param
(
  [parameter(mandatory=$true, helpmessage="Enter the connection string for the IoT Hub:")]
  [ValidateNotNull()]
  $connectionString
)

# Check if elevated

Write-Host "Checking for elevated privileges..."
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{
    Write-Warning "Insufficient privileges. Run script elevated."
    Exit
}
else
{
    Write-Host "Running elevated." -ForegroundColor Green
}

# Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All

Write-Output "Installing Azure IoT Edge MSI"
$msiPath = $([io.Path]::Combine($env:TEMP, 'AzureIoTEdge.msi'))
$ProgressPreference = 'SilentlyContinue'
Invoke-WebRequest "https://aka.ms/AzEflowMSI" -OutFile $msiPath

Write-Output "Install Azure IoT Edge for Linux on your device"
Start-Process -Wait msiexec -ArgumentList "/i","$([io.Path]::Combine($env:TEMP, 'AzureIoTEdge.msi'))","/qn"

# Get-ExecutionPolicy -List
# Set-ExecutionPolicy -ExecutionPolicy AllSigned -Force

Deploy-Eflow

Provision-EflowVm -provisioningType ManualConnectionString -devConnString $connectionString
