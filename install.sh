#Gerekli Dosyaları İndirir Hemen!
echo "Gerekli Dosyalar İndiriliyor..."
pkg install git -y
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
pkg install tur-repo -y
pkg update -y
pkg install chromium -y

echo "Tarayıcı ve Tur-Repo Kuruldu!"

echo "Kurulum Tamamlandı!"
