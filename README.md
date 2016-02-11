## Synopsis

A fast, simple and secure set-up for running you Flask application on a vps. This set up assumes you are on a Unix system and have a VPS set up with Amazon, Heroku, or other like service that runs an Ubuntu 14.04 system. It will work with others, but this is the only tested version. This installation also requires git to be installed on the host system.

## Installation

Pre-reqs:
GIT must be installed on the host system. The user must have sudo access on host system.
•	Download and put RSA key file in ~/.ssh/
•	Change its file permissions with chmod 600 ~/.ssh/udacity_key.rsa
•	SSH into the VPS with ssh –i ~/.ssh/udacity_key.rsa root@52.36.126.254
•	Install git with apt-get install git-all
•	Clone repo with git clone https://github.com/shteeven/vps-setup.git
•	Change permission of setup file with chmod
•	Create user ‘grader’ with adduser grader
•	Give sudo permissions with mkdir ~/etc/sudoers.d/graders
•	Log into ‘grader’ with su – grader
•	Update all system packages with sudo apt-get update
•	Upgrade all system packages with sudo apt-get upgrade
•	Remove unused packages with sudo apt-get autoremove
•	Install system-wide requirements with
o	sudo apt-get install git-all
o	git clone


All depencies for the frontend are either contained within the repo or have links to their CDN. For the backend, you must first install [VirtualBox](https://www.virtualbox.org/), then [Vagrant](https://www.vagrantup.com/). Once these requirements are fulfilled, open terminal. From terminal, `cd` into Catalog Apps directory:
```sh
$ cd /catalog-app-master
```
Run vagrant up and wait for the virtual environment to be installed:
```sh
$ vagrant up
```
SSH into the vagrant environment:
```sh
$ vagrant ssh
```
Once in, cd to host folder:
```sh
$ cd ../../vagrant
```
Then run application.py to start the server:
```sh
$ python application.py
```
After this, the application is ready to use. In your browser, go to `localhost:8000`

## Known issues

There are many, but having the State 'refresh' when a new param is introduced is on the top of my list of fixes. The ability to edit profile info: coming soon.

## Contributors

Some code has been taken an modified from online tutorials:
Login services courtesy of Gert Hengeveld at [Medium](https://medium.com/opinionated-angularjs/techniques-for-authentication-in-angularjs-applications-7bbf0346acec)
Assistance in writing HTML and css styles provided by [Neven Hadjer](https://github.com/nevenhajder)