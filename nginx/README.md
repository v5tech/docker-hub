# nginx

```bash
docker run \
-d \
-p 80:80 \
-v `pwd`/nginx.conf:/etc/nginx/nginx.conf \
--name nginx \
nginx:latest
```