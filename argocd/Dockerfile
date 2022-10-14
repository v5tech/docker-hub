FROM alpine:3.16

MAINTAINER ameizi <sxyx2008@163.com>

USER root

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.sjtug.sjtu.edu.cn/g' /etc/apk/repositories \
    && apk update && apk add tzdata git unzip vim --no-cache \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone

ADD argocd /usr/local/bin

CMD ["argocd version --client"]