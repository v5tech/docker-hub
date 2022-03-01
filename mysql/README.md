# mysql


```bash
docker run --name mysql \
--restart=always \
-p 3306:3306 \
-v `pwd`/data:/var/lib/mysql \
-e MYSQL_ROOT_PASSWORD=root \
-d mysql:5.7 
```

docker-compose.yaml

```yml
version: "3.6"

services:
  mysql:
    image: mysql:5.7.27
    container_name: mysql
    command: --character-set-server=utf8mb4 --collation-server=utf8mb4_unicode_ci --lower-case-table-names=1
    ports:
      - "3306:3306"
    environment:
      # 设置 mysql root用户密码
      - MYSQL_ROOT_PASSWORD=root
      # 修复导入脚本时的中文乱码
      - LANG=C.UTF-8
    volumes:
      # 挂载 mysql 数据目录
      - ./data:/var/lib/mysql
```
