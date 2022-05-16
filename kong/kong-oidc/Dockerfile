FROM kong:alpine

LABEL description="Alpine + Kong + kong-oidc plugin"

USER root

RUN echo "http://mirrors.aliyun.com/alpine/v3.15/main" > /etc/apk/repositories \
    && echo "http://mirrors.aliyun.com/alpine/v3.15/community" >> /etc/apk/repositories \
    && apk update && apk add tzdata git unzip luarocks --no-cache \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && luarocks install --pin lua-resty-jwt \
    && luarocks install kong-oidc

USER kong