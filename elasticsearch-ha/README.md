# elasticsearch-ha

Elasticsearch集群高可用。

Elasticsearch集群天生就是一个高可用的集群，具体查看其相关配置文件。

使用haproxy、keepalived实现nginx的高可用。通过nginx反向代理Elasticsearch的9200端口以实现HTTP REST API高可用。

```bash
docker-compose up
```

使用haproxy实现nginx集群负载均衡 http://localhost:8000

使用haproxy实现Elasticsearch集群负载均衡 http://localhost:9200

haproxy监控面板 http://localhost:9200

使用haproxy代理nginx入口 http://localhost

具体在生产环境应使用keepalived的虚IP来访问nginx的9200端口，以实现Elasticsearch REST API高可用。