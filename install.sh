#!/bin/bash

# Car installer

apt update
apt upgrade -y

apt install -y \
	chrony \
	dnsmasq \
	docker-compose \
	gpsd \
	hostapd

rfkill unblock all

systemctl unmask hostapd
systemctl enable hostapd

systemctl enable docker

cp config.txt /boot/config.txt
cp cmdline.txt /boot/cmdline.txt

cp gps.conf /etc/modules-load.d/gps.conf
cp 50-gps.rules /etc/udev/rules.d/50-gps.rules
cp gpsd /etc/default/gpsd
cp chrony.conf /etc/chrony/conf.d/car.conf

cp hostapd.conf /etc/hostapd/hostapd.conf
cp dnsmasq.conf /etc/dnsmasq.d/car.conf
cp dhcpcd.conf /etc/dhcpcd.conf

echo "192.168.0.1    car" >> /etc/hosts

docker-compose up -d

sudo reboot
