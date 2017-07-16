FROM python:2.7-alpine3.6

MAINTAINER ameizi <sxyx2008@163.com>

RUN echo "http://mirrors.aliyun.com/alpine/v3.6/main" > /etc/apk/repositories \
    && echo "http://mirrors.aliyun.com/alpine/v3.6/community" >> /etc/apk/repositories \
    && apk update && apk upgrade && apk add tzdata git --no-cache \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && git clone https://github.com/ireaderlab/zkdash.git

WORKDIR /zkdash

RUN pip install --trusted-host pypi.douban.com -i http://pypi.douban.com/simple -r requirements.txt

ADD conf.yml /zkdash/conf/
ADD *.sh /zkdash/

EXPOSE 8765

CMD ["/zkdash/run.sh"]