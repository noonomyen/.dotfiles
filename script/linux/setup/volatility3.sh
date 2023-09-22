#!/usr/bin/bash

cd /opt

sudo apt install -y build-essential git libdistorm3-dev yara libraw1394-11 libcapstone-dev capstone-tool tzdata

sudo git clone https://github.com/volatilityfoundation/volatility3.git
cd /opt/volatility3
sudo git checkout v2.4.1

sudo python3.11 -m pip install -r requirements.txt
sudo python3.11 setup.py build
sudo python3.11 setup.py install
