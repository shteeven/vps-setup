## FOR THE UDACITY GRADER

#### Info
- IP addr: 52.36.104.94
- Port: 2200
- Login: ssh -i ~/.ssh/vps_rsa grader@52.36.104.94 -p 2200
- Complete url: http://ec2-52-36-104-94.us-west-2.compute.amazonaws.com/

## Synopsis

THIS PROJECT IS DESIGNED FOR A UDACITY NANODEGREE ASSIGNMENT. It can be modded to fit many others; use it as you wish, but know that some steps have been taken care of by Udacity, and are not covered in this README.

A fast, simple and secure set-up for running your Flask application on a VPS. This set up assumes you are on a Unix system (only tested on Mac OSX) and have a VPS set up with Amazon, or other like service that runs an Ubuntu 14.04 system. It will work with others, but this is the only tested OS.

This script still requires work to make it more universal, but for now, it works with the catalog-app I have made. There are some steps that are project specific, and I have placed those in a VPS folder within that specific project. This keeps things more modular; you can use the catalog-app VPS folder as an example, [here][1].

## Summary of Packages and Changes
If you wish for a more detailed view of the changes, please review the run_main.sh; I have put comments on most actions.

#### Installed and initialized packages:
- Cron - setting up CRON operations to update/upgrade the system packages weekly
- Fail2Ban - monitor and block brute-force attackers
- Apache2 - serve content and manage requests; configured to block requests to the .git dir
- Libapache2_mod_wsgi - allow WSGI apps to process requests that meet criteria in the Apache config files
- Postgresql - database for storing app data; is set to deny remote connections; create user 'catalog' (this operation should move to the project specific VPS folder)
- Pip - package installation and management

#### Modify and/or enable:
- Add User - add new user, 'grader'; give user sudo ability and a secure password
- Upgrade - update and upgrade all packages that initially come with the system
- Time and Date - change time zone to UTC
- SSH - change ssh_config to accept SSH from port 2200 and disallow root login
- Firewall - set ufw to deny all incoming requests except ssh, 2200, ntp, and www ports
- RSA Pub Key - copy, and grant permissions to user, the user provided RSA key to $HOME/authorized_keys


## Installation
- Open two terminals: one for local and one for later work with the VPS.
#### LOCAL TERMINAL
- Create a folder to store keys: '~/.ssh/vps_rsa':
```sh
$ touch ~/.ssh/vps_rsa
```
- Generate an SSH key locally and save it to '/Users/YOUR_HOME/.ssh/vps_rsa' (enter a password if you wish):
```sh
$ ssh-keygen
```
- Secure your .ssh dir and rsa key file:
```sh
$ chmod 700 ~/.ssh
```
```sh
$ chmod 600 ~/.ssh/vps_rsa
```
-  View the contents of '~/.ssh/vps_rsa.pub':
```sh
$ cat ~/.ssh/vps_rsa.pub
```
- Leave this window open and copy and paste the vps_rsa contents when prompted by the script.
#### VPS TERMINAL
- Download and put RSA key file in ~/.ssh/:
```sh
$ mv ~/Downloads/udacity_key.rsa ~/.ssh/
```
- Change its file permissions with:
```sh
$ chmod 600 ~/.ssh/udacity_key.rsa
```
- SSH into the VPS with:
```sh
$ ssh –i ~/.ssh/udacity_key.rsa root@YOUR.VPS.IP.ADDR
```
, putting your VPS ip address after 'root@'.
- Update package repos:
```sh
$ apt-get update
```
- Install git with:
```sh
$ apt-get install git-all
```
- Clone this repo to your VPS:
```sh
$ git clone https://github.com/shteeven/vps-setup.git
```
- After cloning, enter the following commands:
```sh
$ cd vps-setup
```,
```sh
$ chmod +x run_main.sh
```,
```sh
$ ./run_main.sh
```
- Enter any information for which you are prompted.
- After script has finished, update the oauth providers to accept login requests from the new URL, which should look something like this: http://ec2-XX-XX-XX-XX.us-west-2.compute.amazonaws.com/ with the XXs being your VPS ip address.
- Once finished, you will have to login as the newly created user from the port chosen; it should look similar to this: `ssh –i ~/.ssh/vps_rsa grader@XX.XX.XX.XXX -p 2200`
- Enjoy the app.


## This and Thats

#### Fail2ban
For viewing the status of banned ips, enter `sudo fail2ban-client status apache`.
To un-ban an ip address after fail2ban has blocked it, enter `sudo fail2ban-client set apache unbanip XX.XX.XXX.XXX`.


[1]: https://github.com/shteeven/catalog-app/tree/master/vps
