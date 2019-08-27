#!/bin/bash

CMD_HOME=/home/ubuntu/tools
# run on port 9000
docker-compose -f $CMD_HOME/zoonavigator-compose.yml up -d
