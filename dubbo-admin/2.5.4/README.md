# dubbo-admin

构建

```bash
docker build -t dubbo-admin:2.5.4 .
```

运行

```bash
docker run \
  -it \
  --rm \
  --name dubbo-admin \
  -e ZK=172.16.222.125:2181 \
  -e ROOT_PASSWORD=root \
  -e GUEST_PASSWORD=guest \
  -p 9080:8080 \
  dubbo-admin:2.5.4
```

阿里云dubbo-admin镜像

```bash
docker run \
  -it \
  --rm \
  --name dubbo-admin \
  -e ZK=172.16.222.125:2181 \
  -e ROOT_PASSWORD=root \
  -e GUEST_PASSWORD=guest \
  -p 9080:8080 \
  registry.cn-hangzhou.aliyuncs.com/ameizi/dubbo-admin
```