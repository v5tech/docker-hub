# dubbokeeper

构建

```bash
docker build -t dubbokeeper .
```

运行

运行之前，需要手动创建数据库 dubbokeeper

数据库建表脚本见 https://github.com/dubboclub/dubbokeeper/blob/master/doc/storage/mysql/sql/application.sql 

```bash
docker run \
  -d \
  --rm \
  --name dubbokeeper \
  -e ZK=10.136.55.242:2181 \
  -e DB_URL=jdbc:mysql://172.16.222.115:3306/dubbokeeper \
  -e DB_USER=root \
  -e DB_PWD=root \
  -p 9080:8080 \
  dubbokeeper
```

阿里云dubbokeeper镜像

```bash
docker run \
  -d \
  --rm \
  --name dubbokeeper \
  -e ZK=10.136.55.242:2181 \
  -e DB_URL=jdbc:mysql://172.16.222.115:3306/dubbokeeper \
  -e DB_USER=root \
  -e DB_PWD=root \
  -p 9080:8080 \
  registry.cn-hangzhou.aliyuncs.com/ameizi/dubbokeeper
```




