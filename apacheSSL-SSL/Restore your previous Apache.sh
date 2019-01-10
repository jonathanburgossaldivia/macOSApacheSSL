scriptName="apacheSSL"

httpConfPath="/etc/apache2/httpd.conf"
httpdSslConfPath="/etc/apache2/extra/httpd-ssl.conf"
httpdVhostsConfPath="/etc/apache2/extra/httpd-vhosts.conf"

clear
echo "

* Run this script as root.
* The folder of this script (apacheSSL-SSL) must be on the desktop with the original name.

"

sudo echo || exit 0

if [ ! -d ~/Desktop/${scriptName}-Backup ]; then
	clear
  	echo -e "The backup folder does not exist. \n"
  else
  	sudo cp ~/Desktop/${scriptName}-Backup/httpd.conf $httpConfPath
	sudo cp ~/Desktop/${scriptName}-Backup/httpd-ssl.conf $httpdSslConfPath
	sudo cp ~/Desktop/${scriptName}-Backup/httpd-vhosts.conf $httpdVhostsConfPath
	sudo rm -rf /etc/apache2/ssl/localhost.key
	sudo rm -rf /etc/apache2/ssl/localhost.crt
	sudo rm -rf ~/Desktop/${scriptName}-Backup
	sudo apachectl restart
	open "http://localhost"
fi


