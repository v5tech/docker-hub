# portainer

Docker可视化管理

```bash
docker run -d --name portainer -p 9000:9000 \
    -v /var/run/docker.sock:/var/run/docker.sock \
    portainer/portainer
```