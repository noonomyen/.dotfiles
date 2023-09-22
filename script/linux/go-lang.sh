#!/usr/bin/bash

sudo mkdir /opt/go
cd /opt/go

sudo wget https://go.dev/dl/go1.21.1.linux-amd64.tar.gz -O go1.21.1.linux-amd64.tar.gz
sudo tar -xf go1.21.1.linux-amd64.tar.gz
sudo mv go/* .
sudo rm -rf go

sudo ln -s /opt/go/bin/* /usr/local/bin
