#!/bin/bash

################################
# Get data from user
################################

echo "Please enter the git repo URL: "

default_git_repo="https://github.com/shteeven/catalog-app.git"
echo "Please enter git repo URL: MUST BE SAME AS REPO's NAME!!! ($default_git_repo)"
read input_git_repo
[[ $input_git_repo = '' ]] && git_repo="$default_git_repo" || git_repo="$input_git_repo"
echo "You entered: $git_repo"

default_app_name="catalog-app"
echo "Please enter app name: MUST BE SAME AS REPO's NAME!!! ($default_app_name)"
read input_app_name
[[ $input_app_name = '' ]] && app_name="$default_app_name" || app_name="$input_app_name"
echo "You entered: $app_name"

default_username="grader"
echo "Please enter username: ($default_username)"
read input_username
[[ $input_username = '' ]] && username="$default_username" || username="$input_username"
echo "You entered: $username"

default_port="2200"
echo "Please enter desired ssh port: ($default_port)"
read input_port
[[ $input_port = '' ]] && ssh_port="$default_port" || ssh_port="$input_port"
echo "You entered: $ssh_port"

################################
# Create new user and give appropriate permissions
################################
# create user
adduser ${username}
# give sudo access
cat > /etc/sudoers.d/${username} << EOF1
$username ALL=(ALL) NOPASSWD: ALL
EOF1
# switch users
su - ${username}
echo "still running"

#################################
## Update and Upgrade current packages
#################################
#sudo apt-get update
#sudo apt-get upgrade
#
## for admin work later
#sudo apt-get install finger
#
#################################
## Update timezone
#################################
#sudo timedatectl set-timezone UTC
#
#################################
## Update port number and set up firewall
#################################
#regex='^Port 22$'
#file="/etc/ssh/sshd_config"
#
#if [ -f "$file" ] ; then
#	sed -i 's/$regex/Port $ssh_port/' $file
#else
#	echo "/etc/ssh/sshd_config could not be found."
#	echo "Please manually change Port 22 to desired number, then comment out all commands above and try running again."
#fi
#
## block all ports by default
#sudo ufw default deny incoming
#sudo ufw default allow outgoing
#
## open needed ports
#sudo ufw allow ssh
#sudo ufw allow ${ssh_port}/tcp
#sudo ufw allow www
#sudo ufw enable
#
#################################
## Install apache and prepare server for application
#################################
#sudo apt-get install apache2
#sudo apt-get install postgresql postgresql-contrib
## is this necessary???
#sudo apt-get install memcached
#
#sudo apt-get install libapache2-mod-wsgi python-dev python-pip build-essential
#sudo pip install --upgrade pip
#
#conf_regex="\[app_name\]"
#conf_file="/root/vps-setup/000-default.conf"
#if [ -f "$conf_file" ] ; then
#	sudo sed -i 's/$conf_regex/$app_name/' $conf_file
#fi
#
#sudo cp -f $conf_file /etc/apache2/sites-enabled/
#
#################################
## Install application and dependencies
#################################
#app_dir="/var/www/$app_name"
#sudo mkdir ${app_dir}
#cd ${app_dir}
#sudo git clone ${git_repo}
#cd ${app_name}/vps
#sudo chmod +x run_vps.sh
#
#sudo ./run_vps.sh
#
#################################
## Set up PSQL
#################################
#sudo -u postgres -i
#psql -c "CREATE USER catalog WITH PASSWORD 'catalog' CREATEDB LOGIN;"
#psql -c "CREATE ROLE catalog WITH CREATEDB;"
#su - grader
#


