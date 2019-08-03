# Use Asuswrt Merlin as a transparent proxy

## Intro

This project is for config you asus router (merlin based) to serve as a transparent forward proxy.

**NOTE**: This is a modified solution with v2ray as both client and server.

## Prerequisites

- A VPS which can server as a v2ray server. (Or third party service)
- A router which support opkg package manager. (we use Merlin, I think OpenWRT can satisfied too after some hack)
- A local ssh client which can login to router.

## Install on router

- Clone this repo to your computer.
- Add the `config.json` file in `router/opt/etc` folder. The file is a standard v2ray config file. You should put your routing rules inside this config file.
- Run `./v2ray+dnsmasq+dnscrypt2 admin@192.168.50.1`. You may replace `admin` and `192.168.50.1` for your needs. Login with SSH key is required.
