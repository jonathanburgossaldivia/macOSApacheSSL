scriptName="apacheSSL"

httpConfPath="/etc/apache2/httpd.conf"
httpdSslConfPath="/etc/apache2/extra/httpd-ssl.conf"
httpdVhostsConfPath="/etc/apache2/extra/httpd-vhosts.conf"

clear
echo "

* Run this script as root.
* The folder of this script must be on the desktop with the original name.

"

sudo echo || exit 0


if [ -d ~/Desktop/${scriptName}-Backup ]; then
	clear
  	echo -e "You have already executed this script ... \n"
fi


sudo apachectl start

mkdir ~/Desktop/${scriptName}-Backup

sudo mv $httpConfPath ~/Desktop/${scriptName}-Backup
sudo mv $httpdSslConfPath ~/Desktop/${scriptName}-Backup
sudo mv $httpdVhostsConfPath ~/Desktop/${scriptName}-Backup

sudo cp ~/Desktop/${scriptName}-SSL/apacheWithSSL/httpd.conf $httpConfPath
sudo cp ~/Desktop/${scriptName}-SSL/apacheWithSSL/httpd-ssl.conf $httpdSslConfPath
sudo cp ~/Desktop/${scriptName}-SSL/apacheWithSSL/httpd-vhosts.conf $httpdVhostsConfPath

sudo mkdir /etc/apache2/ssl
sudo openssl genrsa -out /etc/apache2/ssl/localhost.key 2048
sudo openssl req -new -x509 -key /etc/apache2/ssl/localhost.key \
-out /etc/apache2/ssl/localhost.crt -days 3650 -subj /CN=localhost
sudo security add-trusted-cert -d -r trustRoot \
-k /Library/Keychains/System.keychain /etc/apache2/ssl/localhost.crt

sudo apachectl restart

open "https://localhost"
