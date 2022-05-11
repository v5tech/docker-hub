# elk

已集成好各种插件

## 运行一个临时es环境生成ca证书

运行一个临时的es环境

```bash
docker run -d -p 127.0.0.1:9200:9200 -p 127.0.0.1:9300:9300 -e "discovery.type=single-node" docker.elastic.co/elasticsearch/elasticsearch:7.15.2
```

进入容器

```bash
docker exec -it 9ba3a282beb9 /bin/bash
```

生成ca证书

```bash
bin/elasticsearch-certutil ca
```

将证书拷贝到宿主机

```bash
docker cp 9ba3a282beb9:/usr/share/elasticsearch/elastic-stack-ca.p12 .
```

清理环境

```bash
docker stop 9ba3a282beb9 && docker rm 9ba3a282beb9
```

## 启动elasticsearch

```bash
docker-compose -f docker-compose.yaml up -d elasticsearch
# 进入elasticsearch容器内部
docker-compose exec elasticsearch bash
# 设置用户密码 elastic/elastic
bash-4.4# bin/elasticsearch-setup-passwords interactive
```

## 启动kibana

```bash
docker-compose -f docker-compose.yaml up -d kibana
```

## 启动cerebro

```bash
docker-compose -f docker-compose.yaml up -d cerebro
```