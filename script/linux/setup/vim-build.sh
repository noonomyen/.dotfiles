#!/usr/bin/bash

sudo mkdir /opt/vim
cd /opt/vim

sudo apt remove -y vim vim-runtime gvim vim-tiny vim-common vim-gui-common
sudo apt-get install -y libncurses5-dev libgtk2.0-dev libatk1.0-dev \
                        libcairo2-dev libx11-dev libxpm-dev libxt-dev ruby-dev

sudo wget https://github.com/vim/vim/archive/refs/tags/v9.0.1910.tar.gz -O v9.0.1910.tar.gz

sudo tar -xf v9.0.1910.tar.gz
cd vim-9.0.1910

sudo ./configure --enable-cscope \
            --enable-fontset \
            --enable-luainterp \
            --enable-multibyte \
            --enable-mzschemeinterp \
            --enable-option-checking \
            --enable-perlinterp \
            --enable-python3interp \
            --enable-pythoninterp \
            --enable-rubyinterp \
            --enable-tclinterp \
            --enable-terminal \
            --enable-gui=gtk2 \
            --enable-gpm \
            --with-python3-config-dir=/usr/lib/python3.11/config-3.11-x86_64-linux-gnu \
            --with-compiledby=noonomyen \
            --prefix=/opt/vim

sudo make -j $(nproc)
sudo make install

sudo update-alternatives --install /usr/bin/editor editor /opt/vim/bin/vim 1
sudo update-alternatives --set editor /opt/vim/bin/vim
sudo update-alternatives --install /usr/bin/vi vi /opt/vim/bin/vim 1
sudo update-alternatives --set vi /opt/vim/bin/vim

sudo ln -s /opt/vim/bin/* /usr/local/bin
