#!/bin/bash

adduser teamspeak
cp ts3server.ini /home/teamspeak/
cp ts3db_mysql.ini /home/teamspeak/
su - teamspeak

cd /home/teamspeak/
wget http://ftp.4players.de/pub/hosted/ts3/releases/3.0.7.1/teamspeak3-server_linux-amd64-3.0.7.1.tar.gz
tar xvf teamspeak3-server_linux-amd64-3.0.7.1.tar.gz
mv /home/teamspeak/teamspeak3-server_linux-amd64 /home/teamspeak/core && rm teamspeak3-server_linux-amd64-3.0.7.1.tar.gz

chmod +x /home/teamspeak/core/ts3server_linux_amd64
chmod +x /home/teamspeak/core/ts3server_minimal_runscript.sh

mv /home/teamspeak/ts3server.ini /home/teamspeak/core/ts3server.ini
mv /home/teamspeak/ts3db_mysql.ini /home/teamspeak/core/ts3db_mysql.ini

read -p "Teamspeak mysql password ? " teamspeak_password
MYSQL=`which mysql`
Q1="CREATE DATABASE IF NOT EXISTS teamspeak;"
Q2="GRANT ALL ON teamspeak.* TO 'teamspeak'@'localhost' IDENTIFIED BY '${teamspeak_password}';"
Q3="FLUSH PRIVILEGES;"
SQL="${Q1}${Q2}${Q3}"
$MYSQL -u root -p -e "$SQL"

wget http://archive.debian.org/debian/pool/main/m/mysql-dfsg-5.0/libmysqlclient15off_5.0.51a-24+lenny5_amd64.deb
dpkg -i libmysqlclient15off_5.0.51a-24+lenny5_amd64.deb

# su teamspeak -c '/home/teamspeak/core/ts3server_minimal_runscript.sh inifile=ts3server.ini' &
