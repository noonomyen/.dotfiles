#!/usr/bin/bash

sudo apt update -y
sudo apt upgrade -y
sudo apt install -y build-essential cmake clang gcc llvm \
               wget curl \
               htop \
               git \
               tar zip unzip \
               python-is-python3 python2.7 python2.7-dev python3 python3-dev python3-venv python3-pip \
               dnsutils \
               traceroute \
               wireshark \
               nmap
