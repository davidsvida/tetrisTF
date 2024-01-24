#!/bin/bash

URL='https://github.com/davidsvida/tetrisjs/archive/refs/heads/main.zip'
ART_NAME='tetrisjs-main'
TEMPDIR="/tmp/webfiles"
PACKAGE="apache2 wget unzip"
SVC="apache2"

echo "Running setup on Ubuntu"
echo "Installing packages..."
sudo apt update
sudo apt install -y $PACKAGE

echo "Starting and enabling HTTPD service..."
sudo systemctl start $SVC
sudo systemctl enable $SVC

echo "Starting artifact deployment..."
mkdir -p $TEMPDIR
cd $TEMPDIR

wget -q $URL -O "$ART_NAME.zip"
unzip -q "$ART_NAME.zip"

echo "Deploying new files..."
sudo rm -rf /var/www/html/*
sudo cp -r $ART_NAME/* /var/www/html/
sudo chown -R www-data:www-data /var/www/html/
sudo find /var/www/html -type d -exec chmod 755 {} \;
sudo find /var/www/html -type f -exec chmod 644 {} \;


echo "Restarting HTTPD service..."
sudo systemctl restart $SVC

echo "Removing temporary files..."
rm -rf $TEMPDIR
echo "Setup complete."
