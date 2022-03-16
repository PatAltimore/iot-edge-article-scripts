# Run elevated
# Usage: configure-eflow-dev.ps1
# https://docs.microsoft.com/azure/iot-edge/tutorial-develop-for-linux-on-windows

Write-Output "Verify Docker version"
docker --version

Write-Output "Configure the EFLOW virtual machine Docker engine to accept external connections, and add the appropriate firewall rules."
Invoke-EflowVmCommand "sudo iptables -A INPUT -p tcp --dport 2375 -j ACCEPT"

Write-Output "Create a copy of the EFLOW VM docker.service in the system folder."
Invoke-EflowVmCommand "sudo cp /lib/systemd/system/docker.service /etc/systemd/system/docker.service"

Write-Output "Replace the service execution line to listen for external connections."
Invoke-EflowVmCommand "sudo sed -i 's/-H fd:\/\// -H fd:\/\/ -H tcp:\/\/0.0.0.0:2375/g' /etc/systemd/system/docker.service"

Write-Output "Reload the EFLOW VM services configurations."
Invoke-EflowVmCommand "sudo systemctl daemon-reload"

Write-Output "Reload the Docker engine service."
Invoke-EflowVmCommand "sudo systemctl restart docker.service"

Write-Output "Check that the Docker engine is listening to external connections."
Invoke-EflowVmCommand "sudo netstat -lntp | grep dockerd"

Write-Output "Get the EFLOW VM IP address."
$Mac, $IP_Address = Get-EflowVmAddr -split '\n'

docker -H tcp://$IP_Address:2375 run --rm hello-world
