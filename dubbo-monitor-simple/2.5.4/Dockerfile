FROM openjdk:8-jre-alpine

MAINTAINER ameizi <sxyx2008@163.com>

RUN echo "http://mirrors.aliyun.com/alpine/v3.6/main" > /etc/apk/repositories \
    && echo "http://mirrors.aliyun.com/alpine/v3.6/community" >> /etc/apk/repositories \
    && apk update && apk upgrade && apk add bash tzdata --no-cache \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone

ADD dubbo-monitor-simple-2.5.4-SNAPSHOT-assembly.tar.gz /

ADD entrypoint.sh /

RUN mkdir `whoami`/monitor \
    && mv /dubbo-monitor-simple-2.5.4-SNAPSHOT /dubbo-monitor-simple-2.5.4 \
    && chmod +x /entrypoint.sh

EXPOSE 8080

ENTRYPOINT ["/entrypoint.sh"]