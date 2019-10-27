#!/bin/bash

#elevate privileges to su
sudo su
# yum install wget -y  # install wget for redhat 7 on EC2

# yum update install git, php, apache, cmake, dev tools
wget https://s3-us-west-1.amazonaws.com/vader-lab/gridlabd-dependencies/install-base.sh
sh install-base.sh

# MySQL Install server, connector, and libs
wget https://s3-us-west-1.amazonaws.com/vader-lab/gridlabd-dependencies/install-mysql.sh
sh install-mysql.sh

#copy gridlab source and install lib-xercesc
wget https://s3-us-west-1.amazonaws.com/vader-lab/gridlabd-dependencies/install-libxercesc.sh
sh install-libxercesc.sh


# install armadillo - linear algebra library
cd /home/ec2-user
wget https://s3-us-west-1.amazonaws.com/vader-lab/gridlabd-dependencies/install-armadillo.sh
sh install-armadillo.sh

# clone IEEE123 model in www folder
cd /var/www/html
git clone https://github.com/dchassin/ieee123-aws
cp -R ieee123-aws/* .
rm -rf ieee123-aws/
mkdir data output
chmod -R 777 data output config
chown -R apache.apache .

#install gridlabd
cd /home/ec2-user/gridlabd/source
autoreconf -isf
./customize configure
make install
export PATH=/usr/local/bin:$PATH
gridlabd --validate

# edit httpd.conf file and add index.php
nano /etc/httpd/conf/httpd.conf

# install my web sql
# cd var/www/html
# wget http://downloads.sourceforge.net/project/mywebsql/stable/mywebsql-3.4.zip

#### this  needs to happen last ####
cd /etc
nano my.cnf
#----- text below without leading #
#[client]
#port=3306
#socket=/tmp/mysql.sock

#[mysqld]
#port=3306
#datadir=/var/lib/mysql
#socket=/tmp/mysql.sock
#-----
chmod 755 my.cnf #777 is not allowed - world writable. mysqld won't restart
# DONT DO THIS
#chown -R apache.apache .
##########################
service mysqld restart
mysql
# Create user gridlabd_ro and gridlabd in mysql database
#CREATE USER 'gridlabd'@'localhost' IDENTIFIED BY 'gridlabd';
#GRANT ALL PRIVILEGES ON *.* TO 'gridlabd'@'localhost' WITH GRANT OPTION;
#FLUSH PRIVILEGES;
#CREATE USER 'gridlabd_ro'@'%' IDENTIFIED BY 'gridlabd';
#GRANT SELECT ON *.* TO 'gridlabd_ro'@'%';
#FLUSH PRIVILEGES;
# --------------------------------

#start apache service
service httpd start
systemctl start httpd # on RHEL 7 only

#install armadillo - C++ linear algebra library
cd /home/ec2-user
wget http://sourceforge.net/projects/arma/files/armadillo-7.800.1.tar.xz
tar xf armadillo-7.800.1.tar.xz
rm -f armadillo-7.800.1.tar.xz
cd armadillo-7.800.1
cmake .
make install

#install MySql Server
cd /home/ec2-user
yum install https://dev.mysql.com/get/mysql57-community-release-el7-9.noarch.rpm -y
yum install mysql56-server -y # for Amazon linux

#install MySql Connector
wget https://dev.mysql.com/get/Downloads/Connector-C/mysql-connector-c-6.1.9-linux-glibc2.5-x86_64.tar.gz
tar xf mysql-connector-c-6.1.9-linux-glibc2.5-x86_64.tar.gz
#rm mysql-connector-c-6.1.9-linux-glibc2.5-x86_64.tar.gz
cd mysql-connector-c-6.1.9-linux-glibc2.5-x86_64/
cp bin/* /usr/local/bin
cp -R include/* /usr/local/include
cp -R lib/* /usr/local/lib
yum install mysql-libs -y

#test MySQL Service
service mysqld start
service mysqld stop

#yum install mysql -y #remove this later
