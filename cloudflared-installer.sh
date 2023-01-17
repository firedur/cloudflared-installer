#!/bin/bash

#cloudlfared installer script by firedur https://firedur.pl

dist=$(lsb_release -is)
codename=$(lsb_release -cs)
if [ "$EUID" -ne 0 ]
  then echo "Please run as root or use sudo!"
  exit
fi

if [ "$dist" = "Ubuntu" ] || [ "$dist" = "Debian" ]; then
        echo "Adding cloudflare gpg key..."
        mkdir -p --mode=0755 /usr/share/keyrings >/dev/null
        curl -fsSL https://pkg.cloudflare.com/cloudflare-main.gpg | tee /usr/share/keyrings/cloudflare-main.gpg >/dev/null
        echo "Adding cloudflare to apt repositories..."
        echo "deb [signed-by=/usr/share/keyrings/cloudflare-main.gpg] https://pkg.cloudflare.com/cloudflared $codename main" >/etc/apt/sources.list.d/cloudflared.list
        echo "Updating packages and installing cloudflared..."
        apt update >/dev/null && apt install cloudflared -y >/dev/null
        echo "Clouflared succesfully installed"
        exit
else
    echo "This script currently supports only Ubuntu/Debian!"
    exit
fi
