#Gerekli Dosyaları İndirir Hemen!
echo "Gerekli Dosyalar İndiriliyor..."
pkg update -y && pkg upgrade -y
pkg install git && pkg install wget -y
pkg install x11-repo -y
pkg install termux-x11-nightly -y
pkg install pulseaudio -y
pkg install wget -y

echo "Gerekli Dosyalar İndirildi!"
#Masaüstü Ortamı Kuruluyor Hemen!
echo "Masaüstü Ortamı Kuruluyor..."

pkg install xfce4 -y

echo "Masaüstü Ortamı Kuruldu!"
#Tarayıcı ve Tur-Repo Kuruluyor Hemen!
echo "Tarayıcı ve Tur-Repo Kuruluyor..."
pkg install chromium -y
pkg install tur-repo -y

echo "Tarayıcı ve Tur-Repo Kuruldu!"

echo "Kurulum Tamamlandı!"
