#!/bin/bash
zookeeper1=zookeeper1
zookeeper2=zookeeper2
zookeeper3=zookeeper3
kafka1=kafka1
kafka2=kafka2
kafka3=kafka3
ipzookeeper1="10.10.4.9"
ipzookeeper2="10.10.5.9"
ipzookeeper3="10.10.6.9"
ikafka1="10.10.4.9"
ikafka2="10.10.5.9"
ikafka3="10.10.6.9"

sudo apt-get update

# Install packages to allow apt to use a repository over HTTPS:
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

# Add Docker’s official GPG key:
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# set up the stable repository.
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

# install docker
sudo apt-get update
sudo apt-get install -y docker-ce docker-compose

# give ubuntu permissions to execute docker
sudo usermod -aG docker $(whoami)

# Add hosts entries
sudo su
echo "$ipkafka1 $kafka1
$ipzookeeper1 $zookeeper1
$kafka2 $kafka2
$ipzookeeper2 $zookeeper2
$kafka3 $kafka3
$ipzookeeper3 $zookeeper3" | sudo tee --append /etc/hosts
# log out
exit
