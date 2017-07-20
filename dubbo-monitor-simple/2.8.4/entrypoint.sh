#!/bin/sh

sed -Ei "s|multicast://224.5.6.7:1234|$ZOOKEEPER|" /dubbo-monitor-simple-2.8.4/conf/dubbo.properties

/dubbo-monitor-simple-2.8.4/bin/start.sh

bash