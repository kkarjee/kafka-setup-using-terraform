#!/usr/bin/env bash

cp ebs-vol.sh settings/ebs-vol.sh
cp cluster-setup.sh settings/cluster-setup.sh

# zookeeper
cp zookeeper/zookeeper settings/zookeeper
cp zookeeper/template.zookeeper.properties settings/template.zookeeper.properties

# kafka
cp kafka/kafka settings/kafka
cp kafka/template.server.properties settings/template.server.properties

# bundle settings
tar -cvf settings.tar settings
# bundle tools settings
tar -cvf tools.tar tools
