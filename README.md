## Synopsis

A fast, simple and secure set-up for running your Flask application on a vps. This set up assumes you are on a Unix system and have a VPS set up with Amazon, Heroku, or other like service that runs an Ubuntu 14.04 system. It will work with others, but this is the only tested version.

This script still requires to make it more universal, but for now, it works with my catalog-app

## Installation

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
- After script has finished, update the oauth providers to accept login requests from the new URL, which should look something like this:
http://ec2-XX-XX-XX-XX.us-west-2.compute.amazonaws.com/ with the XXs being your VPS ip address.
- Enjoy the app.

Pre-reqs:




