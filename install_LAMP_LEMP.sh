#!/bin/bash

# Provjera da li je korisnik root
if [[ $EUID -ne 0 ]]; then
    echo "Molimo pokreni skriptu kao root ili koristi sudo!"
    exit 1
fi

clear

echo "==========================================="
echo "       Minimalni LAMP / LEMP Installer"
echo "==========================================="
echo ""
echo "Izaberi šta želiš instalirati:"
echo "1) LAMP (Apache + MySQL + PHP)"
echo "2) LEMP (NGINX + MySQL + PHP)"
echo "3) Deinstalacija"
echo "0) Izlaz"
echo ""
read -rp "Unesi izbor [0-3]: " izbor

if [[ "$izbor" == "1" ]]; then
    echo "Instalacija LAMP stack-a..."
    sudo apt update && sudo apt upgrade -y
    sudo apt install -y apache2 mysql-server php libapache2-mod-php php-mysql || { echo "Instalacija LAMP-a nije uspjela!"; exit 1; }
    sudo systemctl enable apache2
    sudo systemctl enable mysql
    sudo apt autoremove -y
    sudo systemctl restart apache2
    echo "<?php phpinfo(); ?>" | sudo tee /var/www/html/info.php

    IP_ADRESA=$(hostname -I | awk '{print $1}')
    echo -e "\n LAMP instalacija završena! Otvori http://${IP_ADRESA}/info.php"

elif [[ "$izbor" == "2" ]]; then
    echo "Instalacija LEMP stack-a..."
    sudo apt update && sudo apt upgrade -y
    sudo apt install -y nginx mysql-server php-fpm php-mysql || { echo "Instalacija LEMP-a nije uspjela!"; exit 1; }
    sudo systemctl enable nginx
    sudo systemctl enable mysql
    sudo systemctl restart nginx
    sudo mkdir -p /var/www/html
    echo "<?php phpinfo(); ?>" | sudo tee /var/www/html/info.php

    PHP_VERSION=$(php -r 'echo PHP_MAJOR_VERSION.".".PHP_MINOR_VERSION;')

    sudo bash -c "cat > /etc/nginx/sites-available/default" <<EOF
server {
    listen 80 default_server;
    listen [::]:80 default_server;

    root /var/www/html;
    index index.php index.html index.htm;

    server_name _;

    location / {
        try_files \$uri \$uri/ =404;
    }

    location ~ \.php\$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/run/php/php${PHP_VERSION}-fpm.sock;
    }

    location ~ /\.ht {
        deny all;
    }
}
EOF

    sudo apt autoremove -y
    sudo nginx -t && sudo systemctl reload nginx

    IP_ADRESA=$(hostname -I | awk '{print $1}')
    echo -e "\n LEMP instalacija završena! Otvori http://${IP_ADRESA}/info.php"

elif [[ "$izbor" == "3" ]]; then
    echo "Deinstalacija..."
    sudo systemctl stop apache2 nginx mysql
    sudo apt remove --purge -y apache2 nginx mysql-server php libapache2-mod-php php-mysql php-fpm
    sudo apt update -y
    sudo apt upgrade -y
    sudo apt autoremove -y
    sudo rm -rf /var/www/html/info.php
    echo -e "\n Deinstalacija završena!"

elif [[ "$izbor" == "0" ]]; then
    echo "Izlaz..."
    exit 0
else
    echo "Nevažeći unos. Pokreni skriptu ponovo i izaberi 1, 2 ili 3."
    exit 1
fi
