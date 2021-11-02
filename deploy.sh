#!/bin/bash
pushd $home/HT
git pull
cp docker-compose.yml /opt/
docker-compose -f /opt/docker-compose.yml up -d
popd