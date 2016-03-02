#!/bin/bash

#This is a config script for Ubuntu, customized especially for myself.
#Before running the script, determine the platform is x64 or arm, and the version of ROS.


mkdir ~/Repositories
cd ~/Repositories

#oh-my-zsh
sudo -s
apt-get update
apt-get install vim zsh git-core build-essential autoconf libtool libssl-dev polipo
wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh
chsh -s `which zsh`

#shadowsocks-libev
git clone https://github.com/shadowsocks/shadowsocks-libev.git
cd shadowsocks-libev
./configure && make
sudo make install

sudo cat >/etc/shadowsocks.json <<EOL
{
    "server":"45.117.100.175",
    "server_port":443,
    "local_port":1080,
    "password":"womenyoujiecao",
    "timeout":600,
    "method":"aes-128-cfb"
}
EOL
nohup ss-local -c /etc/shadowsocks.json &&


#polipo
service polipo stop
nohup polipo socksParentProxy=localhost:1080 &&
export http_proxy=localhost:1080


#Chrome
#TO-DO: Detect arm/x64 and figure out Chrome or Chromium
apt-get install libxss1 libappindicator1 libindicator7
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome*.deb

#ROS

#x64 
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 0xB01FA116
sudo apt-get install libgl1-mesa-dev-lts-utopic
#Modify ROS version here.
sudo apt-get install ros-jade-desktop-full

#arm (Could be a little slippery here.)
#sudo update-locale LANG=C LANGUAGE=C LC_ALL=C LC_MESSAGES=POSIX
# sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 0xB01FA116
# sudo apt-get update
# sudo apt-get install ros-jade-ros-base

