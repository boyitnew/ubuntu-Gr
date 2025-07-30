#!/bin/bash

# به‌روزرسانی سیستم
sudo apt update && sudo apt upgrade -y

# نصب محیط دسکتاپ MATE و اجزای لازم بدون lightdm
sudo apt install -y ubuntu-mate-core mate-desktop-environment xorg dbus-x11 policykit-1 xserver-xorg-video-dummy

# حذف lightdm در صورت وجود (برای جلوگیری از خطا)
sudo apt purge -y lightdm
sudo apt autoremove -y

# نصب XRDP و تنظیمات آن
sudo apt install -y xrdp xorgxrdp
sudo usermod -aG ssl-cert xrdp
echo "mate-session" > ~/.xsession
chmod +x ~/.xsession
sudo systemctl enable xrdp
sudo systemctl restart xrdp

# اجازه دادن به پورت RDP در فایروال
sudo apt install -y ufw
sudo ufw allow 3389/tcp
sudo ufw --force enable

# دانلود و نصب Google Chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install -y ./google-chrome-stable_current_amd64.deb || sudo apt --fix-broken install -y

# تمیزکاری نهایی
rm -f google-chrome-stable_current_amd64.deb

# پایان
echo "✅ نصب تمام شد! حالا می‌تونی با Remote Desktop وصل شی و Chrome رو اجرا کنی."
