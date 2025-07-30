#!/bin/bash

# بروزرسانی سیستم
sudo apt update && sudo apt upgrade -y

# نصب محیط دسکتاپ MATE و LightDM
sudo apt install -y ubuntu-mate-core lightdm

# راه‌اندازی LightDM
sudo systemctl start lightdm.service
sudo service lightdm start

# نصب XRDP و اضافه کردن کاربر به گروه مناسب
sudo apt install -y xrdp
sudo systemctl status xrdp
sudo usermod -a -G ssl-cert xrdp
sudo systemctl restart xrdp

# نصب و پیکربندی فایروال UFW برای دسترسی RDP
sudo apt install -y ufw
sudo ufw allow from 192.168.1.0/24 to any port 3389
sudo ufw reload
