#!/bin/sh

if [ -z "$ZK" ]; then
  echo "You must set the ZK environment variable"
  exit 1
fi

if [ -z "$DB_URL" ]; then
  echo "You must set the DB_URL environment variable"
  exit 1
fi

if [ -z "$DB_USER" ]; then
  echo "You must set the DB_USER environment variable"
  exit 1
fi

if [ -z "$DB_PWD" ]; then
  echo "You must set the DB_PWD environment variable"
  exit 1
fi

sed -Ei "s|localhost:2181|$ZK|g" /tomcat-7.0.79/webapps/ROOT/WEB-INF/classes/dubbo.properties

sed -Ei "s|common-monitor|dubbokeeper|" /tomcat-7.0.79/webapps/ROOT/WEB-INF/classes/dubbo.properties

sed -Ei "s|localhost:2181|$ZK|" /dubbokeeper/mysql-dubbokeeper-server/conf/dubbo-mysql.properties

sed -Ei "s|dubbo.monitor.mysql.url=.*|dubbo.monitor.mysql.url=$DB_URL|" /dubbokeeper/mysql-dubbokeeper-server/conf/dubbo-mysql.properties

sed -Ei "s|dubbo.monitor.mysql.username=.*|dubbo.monitor.mysql.username=$DB_USER|" /dubbokeeper/mysql-dubbokeeper-server/conf/dubbo-mysql.properties

sed -Ei "s|dubbo.monitor.mysql.password=.*|dubbo.monitor.mysql.password=$DB_PWD|" /dubbokeeper/mysql-dubbokeeper-server/conf/dubbo-mysql.properties

/dubbokeeper/mysql-dubbokeeper-server/bin/start-mysql.sh &

/tomcat-7.0.79/bin/catalina.sh run 
