
启动服务


```bash
$ docker-compose up
$ docker exec -t node1 consul members
Node   Address          Status  Type    Build  Protocol  DC   Segment
node1  172.21.0.2:8301  alive   server  1.8.4  2         dc1  <all>
node2  172.21.0.3:8301  alive   server  1.8.4  2         dc1  <all>
node3  172.21.0.4:8301  alive   server  1.8.4  2         dc1  <all>
ndoe4  172.21.0.5:8301  alive   client  1.8.4  2         dc1  <default>
```

集群的使用


```bash
$ docker exec -t node4 consul kv put foo "Hello foo"
$ docker exec -t node4 consul kv put foo/foo1 "Hello foo1"
$ docker exec -t node4 consul kv put foo/foo2 "Hello foo2"
$ docker exec -t node4 consul kv put foo/foo21 "Hello foo21"

$ docker exec -t node4 consul kv get foo
Hello foo

$ docker exec -t node4 consul kv get -detailed foo/foo1
CreateIndex      141
Flags            0
Key              foo/foo1
LockIndex        0
ModifyIndex      141
Session          -
Value            Hello foo1

$ docker exec -t node4 consul kv get -keys -separator="" foo
foo
foo/foo1
foo/foo2
foo/foo21

$ docker exec -t node4 consul kv get not-a-real-key
Error! No key exists at: not-a-real-key
```

consul基本概念

* server模式和client模式

server模式和client模式是consul节点的类型；client不是指的用户客户端。

server模式提供数据持久化功能。

client模式不提供持久化功能，并且实际上他也不工作，只是把用户客户端的请求转发到server模式的节点。所以可以把client模式的节点想象成LB(load balance)，只负责请求转发。

通常server模式的节点需要配置成多个例如3个，5个。而client模式节点个数没有限制。

* server模式启动的命令行参数

```
-server：表示当前使用的server模式；如果没有指定，则表示是client模式。
-node：指定当前节点在集群中的名称。
-config-dir：指定配置文件路径，定义服务的；路径下面的所有.json结尾的文件都被访问；缺省值为：/consul/config。
-data-dir： consul存储数据的目录；缺省值为：/consul/data。
-datacenter：数据中心名称，缺省值为dc1。
-ui：使用consul自带的web UI界面 。
-join：加入到已有的集群中。
-enable-script-checks： 检查服务是否处于活动状态，类似开启心跳。
-bind： 绑定服务器的ip地址。
-client： 客户端可访问ip，缺省值为：“127.0.0.1”，即仅允许环回连接。
-bootstrap-expect：在一个datacenter中期望的server节点数目，consul启动时会一直等待直到达到这个数目的server才会引导整个集群。这个参数的值在同一个datacenter的所有server节点上必须保持一致。
```

这里说明一下，另外一个参数-bootstrap，用来控制一个server是否运行在bootstrap模式：当一个server处于bootstrap模式时，它可以选举自己为leader；注意在一个datacenter中只能有一个server处于bootstrap模式。所以这个参数一般只能用在只有一个server的开发环境中，在有多个server的cluster产品环境中，不能使用这个参数，否则如果多个server都标记自己为leader那么会导致数据不一致。另外该标记不能和-bootstrap-expect同时指定。
