#Inventory of Interfaces

##Installation

1. Get the code and switch to its directory:

  ```
  git clone https://github.com/ctweney/invint.git
  cd invint
  ```

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
1. Initialize the database:

  ```
  ./d cmd "rake db:create db:schema:load db:seed"
  ```
1. Restart rails:

  ```
  ./d restart
  ```

## Development workflow
1. Rebuild rails (when Gemfile changes, etc):

  ```
  ./d rebuild
  ```
1. See rails logs inside the docker container:

  ```
  vagrant ssh
  docker logs rails
  ```
1. See what's going on inside docker container:

  ```
  vagrant ssh
  docker ps
  ```

