
# Keycloak

```bash
docker run -d --name keycloak \
    -p 8080:8080 \
    -e KEYCLOAK_USER=admin \
    -e KEYCLOAK_PASSWORD=admin \
    jboss/keycloak:latest
```
