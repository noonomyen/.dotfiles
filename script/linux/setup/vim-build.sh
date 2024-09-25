#!/usr/bin/bash

set -e

sudo mkdir -p /opt/vim
cd /opt/vim

sudo apt remove -y vim vim-runtime gvim vim-tiny vim-common vim-gui-common
# libgtk2.0-dev <-> libgtk-3-dev
sudo apt-get install -y libncurses5-dev libgtk-3-dev libatk1.0-dev \
                        libcairo2-dev libx11-dev libxpm-dev libxt-dev ruby-dev \
                        lua5.4-dev python3.12-dev python2.7-dev libperl-dev tcl-dev

sudo wget https://github.com/vim/vim/archive/refs/tags/v9.1.0727.tar.gz -O v9.1.0727.tar.gz

sudo tar -xf v9.1.0727.tar.gz
cd vim-9.1.0727

sudo bash ./configure \
    --enable-option-checking \
    --enable-luainterp=yes \
    --enable-mzschemeinterp \
    --enable-perlinterp=yes \
    --enable-python3interp=yes \
    --enable-pythoninterp=yes \
    --enable-tclinterp=yes \
    --enable-rubyinterp=yes \
    --enable-cscope \
    --enable-terminal \
    --enable-multibyte \
    --enable-xim \
    --enable-fontset \
    --enable-gui=gtk3 \
    --with-luajit \
    --with-python-command=python2.7 \
    --with-python-config-dir=/usr/lib/python2.7/config-x86_64-linux-gnu \
    --with-python3-command=python3.12 \
    --with-python3-stable-abi=3.12 \
    --with-python3-config-dir=/usr/lib/python3.12/config-3.12-x86_64-linux-gnu \
    --with-features=huge \
    --with-compiledby=noonomyen \
    --prefix=/opt/vim \
    --enable-fail-if-missing

sudo make -j $(nproc)
sudo make install

sudo update-alternatives --install /usr/bin/editor editor /opt/vim/bin/vim 30
sudo update-alternatives --set editor /opt/vim/bin/vim
sudo update-alternatives --install /usr/bin/vi vi /opt/vim/bin/vim 30
sudo update-alternatives --set vi /opt/vim/bin/vim

sudo ln -s /opt/vim/bin/* /usr/local/bin
