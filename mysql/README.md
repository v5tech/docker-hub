# mysql


```bash
docker run --name mysql \
--restart=always \
-p 3306:3306 \
-v `pwd`/data:/var/lib/mysql \
-e MYSQL_ROOT_PASSWORD=root \
-d mysql:5.7 
```