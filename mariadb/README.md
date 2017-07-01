# mariadb

```bash
docker run -d --name mariadb -p 3306:3306 \
    -v /var/mysql/data:/var/lib/mysql \
    -e MYSQL_ROOT_PASSWORD=root \
    mariadb:latest
```