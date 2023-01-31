FROM openjdk:8u342-jdk

ENV JAVA_HOME="/usr/local/openjdk-8" \
    DORIS_HOME="/opt/doris"

ADD ./resource/apache-doris-fe-1.1.5-bin.tar.gz /opt/
ADD ./resource/sources.list /etc/apt/sources.list
ADD ./resource/entrypoint.sh /opt/entrypoint.sh

WORKDIR /opt

RUN apt-get update && \
    apt-get install -y default-mysql-client net-tools iproute2 vim wget curl && \
    apt-get clean && \
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "Asia/Shanghai" > /etc/timezone && \
    mv apache-doris-fe-1.1.5-bin doris && \
    chmod +x /opt/entrypoint.sh

ENTRYPOINT ["/opt/entrypoint.sh"]