# Kong-oidc插件整合Keycloak


## 注册service

```bash
curl -s -X POST http://localhost:8001/services \
    -d name=httpbin-service \
    -d url=http://httpbin.org/anything \
    | python -mjson.tool

{
    "ca_certificates": null,
    "client_certificate": null,
    "connect_timeout": 60000,
    "created_at": 1652689176,
    "enabled": true,
    "host": "httpbin.org",
    "id": "da32a8fe-46f9-4062-8f9c-a4b86628cd90",
    "name": "httpbin-service",
    "path": "/anything",
    "port": 80,
    "protocol": "http",
    "read_timeout": 60000,
    "retries": 5,
    "tags": null,
    "tls_verify": null,
    "tls_verify_depth": null,
    "updated_at": 1652689176,
    "write_timeout": 60000
}
```

## 为service注册routes


```bash
curl -s -X POST http://localhost:8001/services/da32a8fe-46f9-4062-8f9c-a4b86628cd90/routes -d "paths[]=/mock" \
  | python -mjson.tool

{
    "created_at": 1652689244,
    "destinations": null,
    "headers": null,
    "hosts": null,
    "https_redirect_status_code": 426,
    "id": "17d6bf3e-8c12-4179-805f-e65099b0a559",
    "methods": null,
    "name": null,
    "path_handling": "v0",
    "paths": [
        "/mock"
    ],
    "preserve_host": false,
    "protocols": [
        "http",
        "https"
    ],
    "regex_priority": 0,
    "request_buffering": true,
    "response_buffering": true,
    "service": {
        "id": "da32a8fe-46f9-4062-8f9c-a4b86628cd90"
    },
    "snis": null,
    "sources": null,
    "strip_path": true,
    "tags": null,
    "updated_at": 1652689244
}
```

## 给service注册oidc插件

```bash
curl -s -X POST http://localhost:8001/services/da32a8fe-46f9-4062-8f9c-a4b86628cd90/plugins \
  -d name=oidc \
  -d config.client_id=kong \
  -d config.client_secret=ef3974cc-5e02-49ff-bffa-cfb92cad9463 \
  -d config.bearer_only=yes \
  -d config.realm=my-realm \
  -d config.introspection_endpoint=http://192.168.201.188:8080/auth/realms/my-realm/protocol/openid-connect/token/introspect \
  -d config.discovery=http://192.168.201.188:8080/auth/realms/my-realm/.well-known/openid-configuration \
  | python -mjson.tool

{
    "config": {
        "bearer_only": "yes",
        "client_id": "kong",
        "client_secret": "ef3974cc-5e02-49ff-bffa-cfb92cad9463",
        "discovery": "http://192.168.201.188:8080/auth/realms/my-realm/.well-known/openid-configuration",
        "filters": null,
        "introspection_endpoint": "http://192.168.201.188:8080/auth/realms/my-realm/protocol/openid-connect/token/introspect",
        "introspection_endpoint_auth_method": null,
        "logout_path": "/logout",
        "realm": "my-realm",
        "recovery_page_path": null,
        "redirect_after_logout_uri": "/",
        "redirect_uri_path": null,
        "response_type": "code",
        "scope": "openid",
        "session_secret": null,
        "ssl_verify": "no",
        "token_endpoint_auth_method": "client_secret_post"
    },
    "consumer": null,
    "created_at": 1652689352,
    "enabled": true,
    "id": "95ff9dea-bc13-443c-981e-f227419a9af4",
    "name": "oidc",
    "protocols": [
        "grpc",
        "grpcs",
        "http",
        "https"
    ],
    "route": null,
    "service": {
        "id": "da32a8fe-46f9-4062-8f9c-a4b86628cd90"
    },
    "tags": null
}
```

## 获取token

```bash
RAWTKN=$(curl -s -X POST \
        -H "Content-Type: application/x-www-form-urlencoded" \
        -d "username=sfeng" \
        -d "password=123456" \
        -d 'grant_type=password' \
        -d "client_id=app" \
        http://192.168.201.188:8080/auth/realms/my-realm/protocol/openid-connect/token \
        |jq .)
```

## 访问应用

```bash
export TKN=$(echo $RAWTKN | jq -r '.access_token')
curl "http://127.0.0.1:8000/mock" -H "Authorization: Bearer $TKN"
```


# 参考文档

https://docs.konghq.com/gateway-oss/2.5.x/admin-api/