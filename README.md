#Inventory of Interfaces

##Installation

1. Install Vagrant https://www.vagrantup.com/downloads.html
1. Install VirtualBox  https://www.virtualbox.org/wiki/Downloads
1. Install vagrant-vbguest (to keep guest additions up to date):
  ```
  vagrant plugin install vagrant-vbguest
  ```
1. Start vagrant:
  ```
  vagrant up
  ```
  Your first “vagrant up” will take a half hour or so, as it has to download a lot of materials (OS, Rubies, etc etc)
  Your firewall may hassle you to grant permission to necessary daemons (/etc/nfsd and others). Answer Yes, or else your NFS mount from host to guest will not work.
  You may also get prompted to enter your admin password (again, so NFS will work). Do so.

