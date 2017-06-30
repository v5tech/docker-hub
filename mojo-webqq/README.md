# Mojo-Webqq

构建

```bash
docker build -t ameizi/mojo-webqq .
```

运行

```bash
docker run -it --env MOJO_WEBQQ_LOG_ENCODING=utf8 -p 5000:5000 -v /tmp:/tmp ameizi/mojo-webqq
```