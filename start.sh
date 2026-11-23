#!/data/data/com.termux/files/usr/bin/bash

# Eski Termux-X11 ve PulseAudio sureclerini temizle
pkill -9 -f "termux[.-]x11" 2>/dev/null || true
pulseaudio --kill 2>/dev/null || true

# Ses sunucusunu baslat
pulseaudio --start --load="module-native-protocol-tcp auth-ip-acl=127.0.0.1 auth-anonymous=1" --exit-idle-time=-1

# X11 sunucusunu baslat
export XDG_RUNTIME_DIR="${TMPDIR:-/data/data/com.termux/files/usr/tmp}"
termux-x11 :0 >/dev/null 2>&1 &

sleep 3

# Termux:X11 uygulamasini one getir
am start --user 0 -n com.termux.x11/com.termux.x11.MainActivity >/dev/null 2>&1
sleep 1

export PULSE_SERVER=127.0.0.1

# Kurulum modunu belirle (varsayilan: native)
MODE="native"
if [ -f "$HOME/.cepdesk_mode" ]; then
    MODE=$(cat "$HOME/.cepdesk_mode")
fi

if [ "$MODE" = "proot" ]; then
    echo "PRoot-Distro (Debian XFCE) baslatiliyor..."
    proot-distro login debian --shared-tmp -- env DISPLAY=:0 PULSE_SERVER=127.0.0.1 dbus-launch --exit-with-session startxfce4 >/dev/null 2>&1 &
else
    echo "Native Desktop (Termux XFCE) baslatiliyor..."
    env DISPLAY=:0 dbus-launch --exit-with-session xfce4-session >/dev/null 2>&1 &
fi

exit 0d
