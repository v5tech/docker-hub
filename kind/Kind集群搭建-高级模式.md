# Kind集群搭建-高级模式

### 创建集群

```bash
kind create cluster --config kind-calico.yaml
```

### 安装Calico网络

```bash
kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml
```

### 安装LoadBalancer - Metallb

```bash
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.12.1/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.12.1/manifests/metallb.yaml
kubectl get pods -n metallb-system --watch
```

查看`kind`网络IP

```bash
docker network inspect -f '{{.IPAM.Config}}' kind
```

根据上面的IP范围，修改并应用metallb-configmap.yaml

```
kubectl apply -f https://kind.sigs.k8s.io/examples/loadbalancer/metallb-configmap.yaml
```

进行测试

```bash
kubectl apply -f https://kind.sigs.k8s.io/examples/loadbalancer/usage.yaml
LB_IP=$(kubectl get svc/foo-service -o=jsonpath='{.status.loadBalancer.ingress[0].ip}')
for _ in {1..10}; do
  curl ${LB_IP}:5678
done
```

### 安装 Ingress NGINX

首先为`kind-control-plane`节点去除污点

```bash
kubectl taint node kind-control-plane node-role.kubernetes.io/master-
kubectl taint node kind-control-plane node-role.kubernetes.io/control-plane-
```

为`kind-control-plane`节点添加污点

```bash
kubectl taint node kind-control-plane node-role.kubernetes.io/master:NoSchedule
kubectl taint node kind-control-plane node-role.kubernetes.io/control-plane:NoSchedule
```

安装 Ingress NGINX

```bash
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml
```

应用测试案例

```bash
kubectl apply -f https://kind.sigs.k8s.io/examples/ingress/usage.yaml
# should output "foo"
curl localhost/foo
# should output "bar"
curl localhost/bar
```

### 安装 KubePi

```bash
kubectl apply -f https://raw.githubusercontent.com/KubeOperator/KubePi/master/docs/deploy/kubectl/kubepi.yaml
kubectl apply -f ingress.yaml -n kube-system
```