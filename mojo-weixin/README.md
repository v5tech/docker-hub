# Mojo-Weixin

构建

```bash
docker build -t ameizi/mojo-weixin .
```

运行

```bash
docker run -it --env MOJO_WEIXIN_LOG_ENCODING=utf8 -p 3000:3000 -v /tmp:/tmp ameizi/mojo-weixin
```