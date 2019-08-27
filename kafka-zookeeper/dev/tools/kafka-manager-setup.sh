#!/bin/bash

CMD_HOME=/home/ubuntu/tools
# run on port 8001
docker-compose -f $CMD_HOME/kafka-manager-compose.yml up -d
