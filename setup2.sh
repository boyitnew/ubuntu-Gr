#!/bin/bash

# اسکریپت نصب محیط گرافیکی MATE + XRDP + LightDM روی Ubuntu Server

echo "🔄 بروزرسانی سیستم..."
sudo apt update && sudo apt upgrade -y

echo "🖥️ نصب محیط دسکتاپ MATE و وابستگی‌های X..."
sudo apt install -y ubuntu-mate-core xorg dbus-x11 lightdm

echo "🧠 انتخاب LightDM به‌عنوان مدیر نمایش پیش‌فرض..."
echo "/usr/sbin/lightdm" | sudo tee /etc/X11/default-display-manager

echo "⚙️ فعال‌سازی و راه‌اندازی LightDM..."
sudo systemctl enable lightdm
sudo systemctl restart lightdm

# بررسی وضعیت LightDM
echo "📋 وضعیت lightdm:"
systemctl status lightdm --no-pager

echo "🔒 نصب XRDP برای دسترسی ریموت..."
sudo apt install -y xrdp

echo "🧾 بررسی وضعیت XRDP..."
sudo systemctl enable xrdp
sudo systemctl restart xrdp
systemctl status xrdp --no-pager

echo "👤 اضافه کردن کاربر xrdp به گروه ssl-cert..."
sudo usermod -a -G ssl-cert xrdp

echo "🛡️ نصب و پیکربندی فایروال UFW برای پورت RDP..."
sudo apt install -y ufw
sudo ufw allow from 192.168.1.0/24 to any port 3389 proto tcp
sudo ufw reload
sudo ufw enable

echo "✅ نصب و راه‌اندازی کامل شد! حالا می‌توانید با Remote Desktop به آدرس IP سیستم وصل شوید."
