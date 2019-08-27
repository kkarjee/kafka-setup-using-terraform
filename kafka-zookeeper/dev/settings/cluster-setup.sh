#!/bin/bash
# IP of zookeeper servers
ipzookeeper1=10.10.4.9
ipzookeeper2=10.10.5.9
ipzookeeper3=10.10.6.9

#zookeeper hostnames
zookeeper1=zookeeper1
zookeeper2=zookeeper2
zookeeper3=zookeeper3

#zooker id
zookeeperidServer1=1
zookeeperidServer2=2
zookeeperidServer3=3

# IP of kafka servers
ipserver1=10.10.4.9
ipserver2=10.10.5.9
ipserver3=10.10.6.9

# broker ids
brokeridserver1=1
brokeridserver2=2
brokeridserver3=3

# kafka hostnames
server1=kafka1
server2=kafka2
server3=kafka3

#ip=$ipserver1
ipaddress=`hostname -I`
ip=`echo $ipaddress | xargs`
echo $ip
################## host entries ##################
# Mac
#sed '/^#__KAFKA_CLUSTER_HOSTS_START/,/^\$/{/^#__KAFKA_CLUSTERS_HOSTS_END/!{/^\$/!d;};}' /etc/hosts > /tmp/hosts.txt

#linux (TODO: sed fix for linux)
sed '/^#__KAFKA_CLUSTER_HOSTS_START/,/^\$/{/^#__KAFKA_CLUSTERS_HOSTS_END/!{/^\$/!d}}' /etc/hosts > /tmp/hosts.txt
echo "#__KAFKA_CLUSTER_HOSTS_START
# kafka
$ipserver1 $server1
$ipserver2 $server2
$ipserver3 $server3

#zookeer
$ipzookeeper1 $zookeeper1
$ipzookeeper2 $zookeeper2
$ipzookeeper3 $zookeeper3
#__KAFKA_CLUSTER_HOSTS_END" | tee -a /tmp/hosts.txt

sudo mv /tmp/hosts.txt /etc/hosts


################## Zookeeper ##################
echo $ip $ipzookeeper1
# zookeeper.properties
zookeeperPropertiesTemplateFile="./template.zookeeper.properties"
if [[ $ip == $ipzookeeper1 || $ip == $ipzookeeper2 || $ip == $ipzookeeper3 ]]
then
        echo "inside..."
	cp "$zookeeperPropertiesTemplateFile" /home/ubuntu/kafka/config/zookeeper.properties
	echo "
server.$zookeeperidServer1=$zookeeper1:2888:3888
server.$zookeeperidServer2=$zookeeper2:2888:3888
server.$zookeeperidServer3=$zookeeper3:2888:3888" | tee -a /home/ubuntu/kafka/config/zookeeper.properties

	echo "1" > /data/zookeeper/myid
	# declare the server's identity
	if [ $ip == "$ipzookeeper1" ]; then
		echo "$zookeeperidServer1" > /data/zookeeper/myid
	fi
	if [ $ip == "$ipzookeeper2" ]; then
		echo "$zookeeperidServer2" > /data/zookeeper/myid
	fi
	if [ $ip == "$ipzookeeper3" ]; then
		echo "$zookeeperidServer3" > /data/zookeeper/myid
	fi
fi


################## Kafka ##################

# kafka server.properties
serverPropertiesTemplateFile="./template.server.properties"
configServerPropertiesPath="/home/ubuntu/kafka/config/server.properties"
zookeeperConnectString="zookeeper.connect=$zookeeper1:2181,$zookeeper2:2181,$zookeeper3:2181/kafka"
case  $ip  in
	"$ipserver1")
	   echo "Writing [server1] server.properties"
	   sed -e "s/\${BROKER_ID}/$brokeridserver1/" -e "s/\${LISTENER_ID}/$server1/"  "$serverPropertiesTemplateFile" > "$configServerPropertiesPath"
	   echo $zookeeperConnectString | tee -a "$configServerPropertiesPath"
	    ;;
	"$ipserver2")
	   echo "Writing [server2] server.properties"
	   sed -e "s/\${BROKER_ID}/$brokeridserver2/" -e "s/\${LISTENER_ID}/$server2/"  "$serverPropertiesTemplateFile" > "$configServerPropertiesPath"
	   echo $zookeeperConnectString | tee -a "$configServerPropertiesPath"
	    ;;
	"$ipserver3")
	   echo "Writing [server3] server.properties"
	   sed -e "s/\${BROKER_ID}/$brokeridserver3/" -e "s/\${LISTENER_ID}/$server3/"  "$serverPropertiesTemplateFile" > "$configServerPropertiesPath"
	   echo $zookeeperConnectString | tee -a "$configServerPropertiesPath"
	    ;;
	*)
esac

