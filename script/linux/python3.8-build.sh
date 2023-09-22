#!/usr/bin/bash

sudo apt-get install -y libssl-dev zlib1g-dev \
                        libbz2-dev libreadline-dev \
                        libsqlite3-dev libncurses5-dev \
                        libncursesw5-dev xz-utils tk-dev \
                        liblzma-dev tk-dev

sudo mkdir /opt/python
cd /opt/python

sudo wget https://www.python.org/ftp/python/3.8.18/Python-3.8.18.tgz
sudo tar xzf Python-3.8.18.tgz
cd Python-3.8.18

sudo ./configure --prefix=/opt/python/3.8.18/ \
                 --enable-optimizations \
                 --with-lto \
                 --with-computed-gotos \
                 --with-system-ffi \
                 --enable-shared

sudo make -j "$(nproc)"
sudo make altinstall

sudo rm "/opt/python/3.8.18/bin/"{pip,pip3}

sudo ln -s /opt/python/3.8.18/lib/* /usr/lib
sudo ln -s /opt/python/3.8.18/lib/pkgconfig/* /usr/lib/pkgconfig
sudo ln -s /opt/python/3.8.18/bin/*3.8 /usr/local/bin

sudo /opt/python/3.8.18/bin/python3.8 -m pip install --upgrade pip setuptools wheel
