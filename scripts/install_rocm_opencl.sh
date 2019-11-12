#!/bin/sh

# First make sure your system is up to date
sudo apt update -y
sudo apt dist-upgrade -y
sudo apt install -y libnuma-dev
#sudo reboot

# Add the ROCm apt repository
wget -qO - http://repo.radeon.com/rocm/apt/debian/rocm.gpg.key | sudo apt-key add -
echo 'deb [arch=amd64] http://repo.radeon.com/rocm/apt/debian/ xenial main' | sudo tee /etc/apt/sources.list.d/rocm.list

# Install the libs
sudo apt install -y rocm-libs rocm-dev miopen-opencl rocm-opencl-dev rocm-utils cxlactivitylogger

# Add yourself to video group
sudo usermod -a -G video $LOGNAME

# Ensure new users are added too
echo 'ADD_EXTRA_GROUPS=1' | sudo tee -a /etc/adduser.conf
echo 'EXTRA_GROUPS=video' | sudo tee -a /etc/adduser.conf

# Use amdgpu drivers in 5.x kernel
echo 'SUBSYSTEM=="kfd", KERNEL=="kfd", TAG+="uaccess", GROUP="video"' | sudo tee /etc/udev/rules.d/70-kfd.rules

#sudo reboot
