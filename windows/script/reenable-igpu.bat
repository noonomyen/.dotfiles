@echo off

pnputil /disable-device "Device instance path"
sleep 1
pnputil /enable-device "Device instance path"
