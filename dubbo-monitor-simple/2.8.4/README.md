# dubbo-monitor-simple

构建

```bash
docker build -t dubbo-monitor-simple:2.8.4 .
```

运行

```bash
docker run \
  -d \
  -it \
  --rm \
  --name dubbo-monitor-simple \
  -e ZOOKEEPER=zookeeper://172.16.222.125:2181 \
  -p 9080:8080 \
  dubbo-monitor-simple:2.8.4
```

阿里云dubbo-monitor-simple镜像

```bash
docker run \
  -d \
  -it \
  --rm \
  --name dubbo-monitor-simple \
  -e ZOOKEEPER=zookeeper://172.16.222.125:2181 \
  -p 9080:8080 \
  registry.cn-hangzhou.aliyuncs.com/ameizi/dubbo-monitor-simple:2.8.4
```