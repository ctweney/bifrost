#Bifrost: Inventory of Interfaces at UC Berkeley

##New Developer Setup

1. Get the code and switch to its directory:

  ```
  git clone https://github.com/ctweney/bifrost.git
  cd bifrost
  ```
1. (Optional) Set Rails to development mode (production is the default in startup scripts):

  ```
  export RAILS_ENV="development"
  ```
1. Edit db/seeds.rb and make yourself an admin with a line like this:

  ```
  Person.create(calnet_uid: '12345', name: 'Your Name').roles << admin
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
1. See the app running at http://localhost:3000/

## Developer workflow

The "./d" script is called from your host machine. It uses "vagrant ssh" to get inside the Vagrant virtual machine,
where it then runs commands inside the docker container using "docker run" scripts located in ./docker/scripts. Going
through "./d" is the preferred way of interacting with the Docker container.

1. Restart rails (runs bundle install, compiles assets, creates/seeds/migrates database if needed):

  ```
  ./d restart
  ```
1. Rebuild rails (takes longer than restart, but everything in the rails Docker container gets refreshed):

  ```
  ./d rebuild
  ```
1. See rails logs:

  ```
  ./d logs
  ```
1. Get a rails console inside the rails docker container:

  ```
  ./d rc
  ```
1. Run an arbitrary shell command inside the rails container:

  ```
  ./d cmd "bundle exec rake something:something"
  ```
1. Shut down the vagrant VM:

  ```
  vagrant halt
  ```
1. Wipe your vagrant VM clean and rebuild from scratch (drastic):

  ```
  vagrant destroy
  vagrant up
  ```

## Operational workflow

Details of how to work with the private Docker repository are at this article, starting at Step 6: https://www.digitalocean.com/community/tutorials/how-to-set-up-a-private-docker-registry-on-ubuntu-14-04

1. Get the magical self-signed cert from Steve Chan

1. Copy ca.crt into /usr/local/share/ca-certificates/api-devops-prod-02.ist.berkeley.edu\:5001/

1. Update the certificate store:

  ```
  sudo update-ca-certificates
  ```
1. Log into the Docker repository (Steve will provide you with credentials):

  ```
  docker login https://api-devops-prod-02.ist.berkeley.edu:5001
  ```
1. Get the latest image:

  ```
  docker pull api-devops-prod-02.ist.berkeley.edu:5001/bifrost
  ```

1. Run it:

  ```
  docker run -p 3000:3000 api-devops-prod-02.ist.berkeley.edu:5001/bifrost
  ```
