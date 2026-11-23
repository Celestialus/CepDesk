#!/data/data/com.termux/files/usr/bin/bash

# CepDesk v0.2.1

clear

echo "================================"
echo "         CepDesk"
echo "         v0.2.1"
echo "================================"
echo ""
echo "Kurulum turunu secin:"
echo ""
echo "[1] Native Desktop (Termux XFCE)"
echo "[2] PRoot-Distro (Debian XFCE)"
echo ""

while true
do
    read -rp "Seciminiz: " secim < /dev/tty

    case "$secim" in
        1)
            echo ""
            echo "Native Desktop kurulumu baslatiliyor..."
            break
            ;;
        2)
            echo ""
            echo "PRoot-Distro (Debian XFCE) kurulumu baslatiliyor..."
            break
            ;;
        *)
            echo "Hatali secim! 1 veya 2 girin."
            ;;
    esac
done

# Native Desktop kurulumu
native_install() {
    echo "Gerekli dosyalar ve repolar indiriliyor..."
    pkg update -y && pkg upgrade -y -o Dpkg::Options::="--force-confold" || { echo "Paket guncelleme hatasi!"; exit 1; }
    pkg install -y x11-repo tur-repo || { echo "Repo kurulum hatasi!"; exit 1; }
    pkg update -y

    echo "Masaustu ortami ve ses sistemi kuruluyor..."
    pkg install -y git wget pulseaudio termux-x11-nightly dbus xfce4 xfce4-terminal || { echo "XFCE kurulum hatasi!"; exit 1; }

    echo "Tarayici (Chromium) kuruluyor..."
    pkg install -y chromium || echo "Uyari: Chromium kurulamadi, daha sonra elle kurabilirsiniz."

    echo "native" > "$HOME/.cepdesk_mode"
    echo "Native Desktop kurulumu tamamlandi!"
}

# PRoot-Distro kurulumu
proot_install() {
    echo "Gerekli Termux paketleri kuruluyor..."
    pkg update -y && pkg upgrade -y -o Dpkg::Options::="--force-confold" || { echo "Paket guncelleme hatasi!"; exit 1; }
    pkg install -y x11-repo || { echo "x11-repo kurulum hatasi!"; exit 1; }
    pkg update -y
    pkg install -y termux-x11-nightly pulseaudio proot-distro || { echo "Temel paket kurulum hatasi!"; exit 1; }

    if [ -d "$PREFIX/var/lib/proot-distro/installed-rootfs/debian" ]; then
        echo "Debian zaten kurulu, mevcut kurulum uzerine devam ediliyor..."
    else
        echo ""
        echo "Debian kuruluyor..."
        proot-distro install debian || { echo "Debian kurulum hatasi!"; exit 1; }
    fi

    echo ""
    echo "Debian icine XFCE masaustu kuruluyor (bu islem biraz surebilir)..."
    proot-distro login debian -- bash -c "
        export DEBIAN_FRONTEND=noninteractive
        apt-get update -y && apt-get upgrade -y
        apt-get install -y xfce4 xfce4-goodies dbus-x11 sudo wget curl
        apt-get clean
    " || { echo "Debian XFCE kurulum hatasi!"; exit 1; }

    echo "proot" > "$HOME/.cepdesk_mode"
    echo ""
    echo "Debian XFCE kurulumu tamamlandi!"
    echo "Terminale girmek icin: proot-distro login debian"
}

case "$secim" in
    1) native_install ;;
    2) proot_install ;;
esac

if [ -f "./start.sh" ]; then
    chmod +x ./start.sh
fi

echo ""
echo "CepDesk kurulumu tamamlandi! Baslatmak icin: ./start.sh"
