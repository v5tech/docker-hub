FROM openjdk:8-jdk-alpine

MAINTAINER ameizi <sxyx2008@163.com>

RUN echo "http://mirrors.aliyun.com/alpine/v3.6/main" > /etc/apk/repositories \
    && echo "http://mirrors.aliyun.com/alpine/v3.6/community" >> /etc/apk/repositories \
    && apk update && apk upgrade && apk add curl bash tzdata --no-cache \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && wget http://apache.website-solution.net/maven/maven-3/3.5.0/binaries/apache-maven-3.5.0-bin.tar.gz \
    && tar zxf apache-maven-3.5.0-bin.tar.gz \
    && mv apache-maven-3.5.0 maven \
    && rm -fr apache-maven-3.5.0-bin.tar.gz /maven/LICENSE /maven/NOTICE /maven/README.txt \
    && echo "export M2_HOME=/maven" >> /etc/profile \
    && echo "export PATH=/maven/bin:$PATH" >> /etc/profile \
    && source /etc/profile \
    && wget http://apache.website-solution.net/tomcat/tomcat-7/v7.0.79/bin/apache-tomcat-7.0.79.tar.gz \
    && tar zxf apache-tomcat-7.0.79.tar.gz \
    && rm -fr apache-tomcat-7.0.79.tar.gz \
    && mv apache-tomcat-7.0.79 tomcat-7.0.79 \
    && rm -fr tomcat-7.0.79/webapps/* \
    && curl https://codeload.github.com/dubboclub/dubbokeeper/zip/master -o dubbokeeper.zip \
    && unzip -q dubbokeeper.zip \
    && rm -fr dubbokeeper.zip \
    && cd /dubbokeeper-master \
    && ./install-mysql.sh \
    && cd / \
    && mkdir dubbokeeper \
    && cp -fr /dubbokeeper-master/target/mysql-dubbokeeper-server /dubbokeeper \
    && chmod +x /dubbokeeper/mysql-dubbokeeper-server/bin/*.sh \
    && cp dubbokeeper-master/target/mysql-dubbokeeper-ui/dubbokeeper-ui-1.0.1.war /tomcat-7.0.79/webapps/ \
    && mkdir /tomcat-7.0.79/webapps/ROOT \
    && unzip -q dubbokeeper-master/target/mysql-dubbokeeper-ui/dubbokeeper-ui-1.0.1.war -d /tomcat-7.0.79/webapps/ROOT/ \
    && rm -fr /tomcat-7.0.79/webapps/dubbokeeper-ui-1.0.1.war \
    && rm -fr /dubbokeeper-master/ \
    && rm -fr ~/.m2/

ADD entrypoint.sh /

RUN chmod +x /entrypoint.sh

EXPOSE 8080

ENTRYPOINT ["/entrypoint.sh"]
