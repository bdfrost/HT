#!/bin/bash
pushd $home/HT
git pull
sudo ln -s /home/bfrost/HT/docker-compose.yml /opt/
sudo ln -s /home/bfrost/HT/compose /opt/compose
docker-compose -f /opt/docker-compose.yml up -d
popd