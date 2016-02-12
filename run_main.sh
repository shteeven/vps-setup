#!/bin/bash

################################
# Get data from user
################################

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

################################
# Update and Upgrade current packages
################################
apt-get update
apt-get upgrade

# for admin work later
apt-get install finger

################################
# Update timezone
################################
timedatectl set-timezone UTC

################################
# Update port number and set up firewall
################################
regex='^Port 22$'
regex_rootlogin='^PermitRootLogin .*$'
file="/etc/ssh/sshd_config"

# change ssh port and disable root user login
if [ -f "$file" ] ; then
	sed -i.bak "s|${regex}|Port ${ssh_port}|" $file
	sed -i.bak "s|${regex_rootlogin}|PermitRootLogin no|" $file
else
	echo "/etc/ssh/sshd_config could not be found."
	echo "Please manually change Port 22 to desired number, then comment out all commands above and try running again."
fi

# block all incoming ports by default
ufw default deny incoming
ufw default allow outgoing

# open needed ports
ufw allow ssh
ufw allow ${ssh_port}/tcp
ufw allow ntp
ufw allow www
ufw enable

# block repeat password attempts
apt-get install nginx sendmail iptables-persistent
apt-get install fail2ban

# copy limit rates
cp /root/vps-setup/files/nginx.conf /etc/nginx/conf.d/nginx.conf

# copy fail2ban triggers
cp /root/vps-setup/files/jail.local /etc/fail2ban/jail.local

# copy ban actions
cp /root/vps-setup/files/ufw.conf /etc/fail2ban/action.d/ufw.conf

# copy filter limits
cp /root/vps-setup/files/filter-nginx-req-limit.conf /etc/fail2ban/filter.d/nginx-req-limit.conf

# copy jail limits
cp /root/vps-setup/files/jail-nginx-req-limit.conf /etc/fail2ban/jail.d/nginx-req-limit.conf

# finish fail2ban setup
service fail2ban reload
service nginx reload

################################
# Install apache and prepare server for application
################################
apt-get install apache2
apt-get install postgresql postgresql-contrib
# is this necessary???
apt-get install memcached

apt-get install libapache2-mod-wsgi python-dev python-pip build-essential
pip install --upgrade pip

conf_regex="application_name"
conf_reg_username="user_name"
conf_file="/root/vps-setup/files/000-default.conf"
if [ -f "$conf_file" ] ; then
	sed -i.bak "s|${conf_reg_username}|${username}|g" $conf_file
	sed -i.bak "s|${conf_regex}|${app_name}|g" $conf_file
fi
cat $conf_file

cp -f $conf_file /etc/apache2/sites-enabled/

################################
# Install application and dependencies
################################
app_dir="/var/www"
cd ${app_dir}
git clone ${git_repo}
cd ${app_dir}/$app_name/vps/
chmod +x run_vps.sh

./run_vps.sh

################################
# Set up PSQL
################################

sudo -u postgres psql -c "CREATE USER catalog WITH PASSWORD 'catalog' CREATEDB LOGIN;"
sudo -u postgres psql -c "REVOKE CONNECT ON DATABASE catalog FROM PUBLIC;"
sudo -u postgres psql -c "GRANT CONNECT ON DATABASE catalog TO catalog;"

service apache2 restart

echo "YOU WILL HAVE TO LOGIN AS ${username}"
echo "ssh -i ~/.ssh/udacity_key.rsa ${username}@XX.XX.XXX.XXX"
sshd restart




