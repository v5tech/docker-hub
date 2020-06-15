
# DevOps CI／CD


通过 maven 检测代码

```bash
mvn clean verify sonar:sonar -Dsonar.host.url=http://localhost:9000 -Dsonar.login=admin -Dsonar.password=admin
```

或使用`token`


```bash
mvn clean verify sonar:sonar -Dsonar.host.url=http://localhost:9000 -Dsonar.login=d3f42a0a0b249b53995ba56b8ced417eab3efd4f
```