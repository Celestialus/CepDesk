
#!/data/data/com.termux/files/usr/bin/bash

# CepDesk v0.2.0

clear

echo "================================"
echo "           CepDesk"
echo "          v0.2.0"
echo "================================"
echo ""
echo "Kurulum turunu secin:"
echo ""
echo "[1] Native Desktop"
echo "[2] PRoot-Distro"
echo ""

while true
do
    read -rp "Seciminiz: " secim

    case "$secim" in

        1)
            echo ""
            echo "Native Desktop kurulumu baslatiliyor..."
            break
            ;;

        2)
            echo ""
            echo "PRoot-Distro kurulumu secildi."
            break
            ;;

        *)
            echo "Hatali secim! 1 veya 2 girin."
            ;;

    esac
done


# Native Desktop kurulumu

native_install() {

    echo "Gerekli dosyalar indiriliyor..."

    pkg update -y
    pkg install git x11-repo termux-x11-nightly pulseaudio wget -y

    echo "Masaustu ortami kuruluyor..."

    pkg install xfce4 -y

    echo "Tarayici ve Tur-Repo kuruluyor..."

    pkg install tur-repo -y
    pkg update -y
    pkg install chromium -y

    echo "Native Desktop kurulumu tamamlandi!"
}


# PRoot-Distro kurulumu

proot_install() {

    echo "Gerekli paketler kuruluyor..."

    pkg update -y
    pkg install x11-repo termux-x11-nightly pulseaudio proot-distro -y

    echo ""
    echo "Debian kuruluyor..."

    proot-distro install debian

    echo ""
    echo "Debian kurulumu tamamlandi!"
    echo "Giris yapmak icin:"
    echo "proot-distro login debian"
}


# Secime gore kurulumu baslat

case "$secim" in

    1)
        native_install
        ;;

    2)
        proot_install
        ;;

esac

echo ""
echo "CepDesk kurulumu tamamlandi!"
