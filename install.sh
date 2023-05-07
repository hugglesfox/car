#!/bin/bash

# Car installer

apt update
apt upgrade -y

apt install -y \
	chrony \
	dnsmasq \
	docker-compose \
	gpsd \
	hostapd \
	rfcomm

rfkill unblock all

cp config.txt /boot/config.txt
cp cmdline.txt /boot/cmdline.txt

cp etc/chrony.conf /etc/chrony/conf.d/car.conf
cp etc/dhcpcd.conf /etc/dhcpcd.conf
cp etc/dnsmasq.conf /etc/dnsmasq.d/car.conf
cp etc/hostapd.conf /etc/hostapd/hostapd.conf

cp defaults/* /etc/defaults/
cp modules-load.d/* /etc/modules-load.d/
cp systemd/* /etc/systemd/system/
cp udev/* /etc/udev/rules.d/

systemctl daemon-reload

systemctl unmask hostapd

systemctl enable docker
systemctl enable hostapd
systemctl enable rfcomm

echo "192.168.0.1    car" >> /etc/hosts

docker-compose up -d

sudo reboot
