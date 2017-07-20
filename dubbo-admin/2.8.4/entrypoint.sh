#!/bin/sh

sed -Ei "s|127.0.0.1:2181|$ZK|" /tomcat-7.0.79/webapps/ROOT/WEB-INF/dubbo.properties

sed -Ei "s|dubbo.admin.root.password=.*|dubbo.admin.root.password=$ROOT_PASSWORD|" /tomcat-7.0.79/webapps/ROOT/WEB-INF/dubbo.properties

sed -Ei "s|dubbo.admin.guest.password=.*|dubbo.admin.guest.password=$GUEST_PASSWORD|" /tomcat-7.0.79/webapps/ROOT/WEB-INF/dubbo.properties

/tomcat-7.0.79/bin/catalina.sh run