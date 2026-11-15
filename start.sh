 
#!/data/data/com.termux/files/usr/bin/bash

# Termux:X11 oturumunu başlat
termux-x11 :0 &

# Biraz bekle
sleep 3

# XFCE masaüstünü başlat
export DISPLAY=:0
dbus-launch --exit-with-session xfce4-session
