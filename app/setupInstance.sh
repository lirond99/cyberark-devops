#!/bin/bash

# Sleep until instance is ready
until [[ -f /var/lib/cloud/instance/boot-finished ]]; do
    sleep 1
done

# Application setup
sudo apt update -y && sudo apt upgrade -y;
sudo apt install python3-pip python3-venv;

cd /home/ubuntu/app/;
sudo mv hellocyberark.service /etc/systemd/system/hellocyberark.service;

python3 -m venv venv
source venv/bin/activate

pip install -r requirements.txt

sudo systemctl daemon-reload
sudo systemctl start hellocyberark
sudo systemctl enable hellocyberark