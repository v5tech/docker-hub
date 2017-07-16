# zkdash

https://github.com/ireaderlab/zkdash

掌阅科技zkdash。zkdash是一个zookeeper的管理界面。

本地构建

```bash
docker build -t zkdash .
```

在开始之前需要先创建数据库

使用本地构建好的镜像

```bash
docker run \
  -d \
  --name zkdash \
  -e DB_NAME=zkdash \
  -e DB_HOST=192.168.31.228 \
  -e DB_PORT=3306 \
  -e DB_USER=root \
  -e DB_PWD=root \
  -v /data/logs/zkdash:/data/logs/zkdash \
  -p 8765:8765 \
  zkdash
```

使用构建好且上传到阿里云的镜像

```bash
docker run \
  -d \
  --name zkdash \
  -e DB_NAME=zkdash \
  -e DB_HOST=192.168.31.228 \
  -e DB_PORT=3306 \
  -e DB_USER=root \
  -e DB_PWD=root \
  -v /data/logs/zkdash:/data/logs/zkdash \
  -p 8765:8765 \
  registry.cn-hangzhou.aliyuncs.com/ameizi/zkdash
```
