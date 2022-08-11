echo "********************** Performing update ************************"
apt-get update
echo "******************* Installing XFCE4 environment *************"
apt-get install kali-defaults kali-root-login desktop-base xfce4 xfce4-places-plugin xfce4-goodies
apt-get install lightdm
dpkg-reconfigure lightdm
echo "******************* Installing Wifite*************"
apt-get install wifite 
echo " "
echo "****************Enabling autologin***************"
cp lightdm.conf /etc/lightdm/lightdm.conf
cp lightdm-autologin /etc/pam.d/lightdm-autologin
echo "****************Setting up interfaces***************"
cp interfaces /etc/network/interfaces
echo " "
echo "****************Setting up wpa_supplicant***************"
cp wpa_supplicant.conf /etc/wpa_supplicant/wpa_supplicant.conf
echo " "
echo "****************Setting up sshd_config (Mosh)***************"
cp sshd_config /etc/ssh/sshd_config
echo " "
echo "****************Create auto***************"
echo "#!/bin/bash
echo "Enter folder name:"
read namef
echo "Enter time work:"
read timew
sudo systemctl stop NetworkManager.service
sudo systemctl stop wpa_supplicant.service
echo "systemctl done"
echo "hcxdumptool start"
sudo hcxdumptool -i wlan1 -o dumpfile.pcapng --active_beacon --tot=$timew --enable_status=15
echo "hcxdumptool done"
sudo systemctl start wpa_supplicant.service
sudo systemctl start NetworkManager.service
echo "systemctl start"
sudo hcxpcapngtool -o hash.hc22000 -E essidlist dumpfile.pcapng
echo "hcxpcapngtool done"
mkdir $namef
echo "Folder create"
mv -v /home/kali/dumpfile.pcapng /home/kali/$namef
mv -v /home/kali/hash.hc22000 /home/kali/$namef
mv -v /home/kali/essidlist /home/kali/$namef
echo "move files to folder is done"
echo "Script is done"
echo "System log out"
shutdown now" > /home/kali/auto
echo " "
chmod 775 /home/kali/auto
echo " "
echo "END of Script... shutdown now!"
echo " "
shutdown now