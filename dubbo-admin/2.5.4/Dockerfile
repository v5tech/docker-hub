FROM openjdk:8-jre-alpine

MAINTAINER ameizi <sxyx2008@163.com>

RUN echo "http://mirrors.aliyun.com/alpine/v3.6/main" > /etc/apk/repositories \
    && echo "http://mirrors.aliyun.com/alpine/v3.6/community" >> /etc/apk/repositories \
    && apk update && apk upgrade && apk add bash tzdata --no-cache \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && wget http://apache.website-solution.net/tomcat/tomcat-7/v7.0.79/bin/apache-tomcat-7.0.79.tar.gz \
    && tar zxf apache-tomcat-7.0.79.tar.gz \
    && rm -fr apache-tomcat-7.0.79.tar.gz \
    && mv apache-tomcat-7.0.79 tomcat-7.0.79 \
    && rm -fr tomcat-7.0.79/webapps/* \
    && mkdir /tomcat-7.0.79/webapps/ROOT

ADD dubbo-admin-2.5.4-SNAPSHOT.war /tomcat-7.0.79/webapps
ADD entrypoint.sh /

RUN unzip -q /tomcat-7.0.79/webapps/dubbo-admin-2.5.4-SNAPSHOT.war -d /tomcat-7.0.79/webapps/ROOT \
    && rm -fr /tomcat-7.0.79/webapps/dubbo-admin-2.5.4-SNAPSHOT.war \
    && chmod +x /entrypoint.sh

EXPOSE 8080

ENTRYPOINT ["/entrypoint.sh"]
