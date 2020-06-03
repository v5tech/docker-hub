# nacos 整合 seata、mysql、sentinel、sentinel-dashboard

环境版本：

nacos-server:1.2.1

seata-server:1.2.0

mysql:5.7

sentinel:1.7.1

** 启动前请务必修改.env 中的 HOST_IP 为宿主机 IP **

1、启动 mysql

```bash
docker-compose up -d mysql
```

2、启动 nacos

```bash
docker-compose up -d nacos-server
```

3、待 nacos 服务正常启动后，在宿主机执行以下脚本向 nacos 注册中心注册 seata 配置

```bash
sh ./scripts/config-center/nacos/nacos-config.sh -h localhost -p 8848 -g SEATA_GROUP
```

4、启动 seata

```bash
docker-compose up -d seata-server
```

5、启动 sentinel dashboard

```bash
docker run --rm --name sentinel -p 8280:8280 foxiswho/sentinel:1.7.1
```

https://hub.docker.com/r/foxiswho/sentinel

https://hub.docker.com/r/bladex/sentinel-dashboard
