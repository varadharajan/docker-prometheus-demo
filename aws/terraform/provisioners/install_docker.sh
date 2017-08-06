#!/bin/bash

sudo apt-get update
sudo apt-get install -y --no-install-recommends linux-image-extra-$(uname -r) linux-image-extra-virtual

# Install docker
sudo apt-get install -y --no-install-recommends apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://apt.dockerproject.org/gpg | sudo apt-key add -
sudo add-apt-repository "deb https://apt.dockerproject.org/repo/ ubuntu-$(lsb_release -cs) main"
sudo apt-get update
sudo apt-get -y install docker-engine make rake awscli
sudo apt-get -y upgrade docker-engine

# Configure Docker Daemon
sudo cat <<EOF > /etc/docker/daemon.json
{
  "hosts": [
    "fd://",
    "tcp://0.0.0.0:2375"
  ]
}
EOF

sudo sed -i "s/ExecStart=.*/ExecStart=\/usr\/bin\/dockerd/g" /lib/systemd/system/docker.service

sudo systemctl daemon-reload
sudo systemctl restart docker