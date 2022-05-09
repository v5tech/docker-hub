# swagger

```bash
docker run \
-d \
--name swagger-ui \
-p 7070:8080 \
-e BASE_URL=/swagger \
-e SWAGGER_JSON=/swagger.json \
-v $(pwd)/swagger.json:/swagger.json \
swaggerapi/swagger-ui
```
