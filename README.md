# IoT Edge scripts

Bash scripts to generate resources for IoT Edge quickstarts and tutorials.

## Download an individual script

```bash
curl -ssl https://raw.githubusercontent.com/PatAltimore/iot-edge-article-scripts/main/create-iotedge-device.sh -o create-iotedge-device.sh
```

## Run

```bash
chmod +x create-iotedge-device.sh
./create-iotedge-device.sh
```

If you run the scripts in Azure Cloud Shell or Linux, you could get *unable to find resources*
errors or complaints about `\r`. Try removing the carriage returns from the scripts using the
`dos2unix` command.

```bash
dos2unix *.sh
```
