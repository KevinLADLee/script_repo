#!/bin/bash

#This is a config script for Ubuntu, customized especially for myself.
#Before running the script, determine the platform is x64 or arm, and the version of ROS.
#Before running, sudo -s and apt-get update

mkdir ~/Repositories
cd ~/Repositories
export http_proxy=http://10.20.1.71:19877/ https_proxy=http://10.20.1.71:19877/
#oh-my-zsh
#sudo -s
#apt-get update
sudo apt-get -y install vim zsh git-core build-essential autoconf libtool libssl-dev polipo
wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh
chsh -s `which zsh`

#shadowsocks-libev
git clone https://github.com/shadowsocks/shadowsocks-libev.git
cd shadowsocks-libev
./configure && make
sudo make install

sudo cat >/etc/shadowsocks.json <<EOL
{
    "server":"103.200.112.175",
    "server_port":7388,
    "local_port":1080,
    "password":"womenyoujiecao",
    "timeout":600,
    "method":"aes-256-cfb"
}
EOL
sudo ss-local -c /etc/shadowsocks.json &


#polipo
sudo service polipo stop
polipo socksParentProxy=localhost:1080 &
export http_proxy=http://localhost:1080/ https_proxy=https://localhost:1080/


#Chrome
#TO-DO: Detect arm/x64 and figure out Chrome or Chromium
#x64
sudo apt-get install libxss1 libappindicator1 libindicator7
wget -O google-chrome-stable.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome*.deb
#arm
#sudo apt-get install chromium-browser


#ROS

#x64 
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 0xB01FA116
#sudo apt-get install libgl1-mesa-dev-lts-utopic
#Modify ROS version here.
sudo apt-get update
sudo apt-get install -y ros-indigo-desktop-full

#Network Speed Monitor
sudo add-apt-repository ppa:nilarimogard/webupd8
sudo apt-get update
sudo apt-get install -y indicator-netspeed

#arm (Could be a little slippery here.)
#sudo update-locale LANG=C LANGUAGE=C LC_ALL=C LC_MESSAGES=POSIX
# sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 0xB01FA116
# sudo apt-get update
# sudo apt-get install ros-jade-ros-base

