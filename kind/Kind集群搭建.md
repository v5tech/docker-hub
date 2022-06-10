# Kind集群搭建


### 创建集群

```bash
kind create cluster --config kind.yaml
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
# DaoCloud镜像加速脚本
wget -O image-filter.sh https://github.com/DaoCloud/public-image-mirror/raw/main/hack/image-filter.sh && chmod +x image-filter.sh
wget https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml
cat deploy.yaml | ./image-filter.sh | kubectl apply -f -
```

应用测试案例

```bash
kubectl apply -f https://kind.sigs.k8s.io/examples/ingress/usage.yaml
```

### 安装 KubePi

```bash
kubectl apply -f https://raw.githubusercontent.com/KubeOperator/KubePi/master/docs/deploy/kubectl/kubepi.yaml
kubectl apply -f kubepi-ingress.yaml
```

### 安装 metrics-server

```bash
# DaoCloud镜像加速脚本
wget -O image-filter.sh https://github.com/DaoCloud/public-image-mirror/raw/main/hack/image-filter.sh && chmod +x image-filter.sh
wget https://raw.githubusercontent.com/ameizi/vagrant-kubernetes-cluster/master/metrics/metrics.yaml
sed -i 's#registry.aliyuncs.com/k8sxio/metrics-server:v0.4.3#k8s.gcr.io/metrics-server/metrics-server:v0.4.5#' metrics.yaml
cat metrics.yaml | ./image-filter.sh | kubectl apply -f -
```