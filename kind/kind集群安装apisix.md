# kind集群安装apisix

## helm安装apisix

```bash
helm repo add apisix https://charts.apiseven.com
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
kubectl create ns ingress-apisix

helm install apisix apisix/apisix \
  --set gateway.type=NodePort \
  --set ingress-controller.enabled=true \
  --set dashboard.enabled=true \
  --namespace ingress-apisix \
  --set ingress-controller.config.apisix.serviceNamespace=ingress-apisix \
  --set ingress-controller.config.apisix.serviceName=apisix-admin

kubectl get service --namespace ingress-apisix
```

## 创建ingress访问gateway、dashboard

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: apisix-gateway-ingress
  namespace: ingress-apisix
spec:
  rules:
  - host: gateway.apisix.com
    http:
      paths:
      - backend:
          service:
            name: apisix-gateway
            port:
              number: 80
        path: /
        pathType: Prefix
---
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: apisix-dashboard-ingress
  namespace: ingress-apisix
spec:
  rules:
  - host: dashboard.apisix.com
    http:
      paths:
      - backend:
          service:
            name: apisix-dashboard
            port:
              number: 80
        path: /
        pathType: Prefix
```

* http://gateway.apisix.com
* http://dashboard.apisix.com admin/admin

## 实战

创建whoami应用

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: whoami
spec:
  selector:
    matchLabels:
      app: whoami
  replicas: 2
  template:
    metadata:
      labels:
        app: whoami
    spec:
      containers:
      - name: whoami
        image: containous/whoami
        ports:
        - containerPort: 80
---
apiVersion: v1
kind: Service
metadata:
  name: whoami
  labels:
    app: whoami
spec:
  ports:
  - port: 80
    protocol: TCP
  selector:
    app: whoami
```

### 配置路由代理-使用apisix的方式

apisix-route.yml

```yaml
apiVersion: apisix.apache.org/v2beta3
kind: ApisixRoute
metadata:
  name: whoami-route
spec:
  http:
  - name: whoami
    match:
      paths:
      - "/whoami"
    backends:
     - serviceName: whoami
       servicePort: 80
```

### 配置路由代理-使用ingress的方式

apisix-ingress.yml

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: whoami-ingress
spec:
  # apisix-ingress-controller is only interested in Ingress
  # resources with the matched ingressClass name, in our case,
  # it's apisix.
  ingressClassName: apisix
  rules:
  - http:
      paths:
        - path: /whoami
          pathType: Prefix
          backend:
            service:
              name: whoami
              port:
                number: 80
```

# 参考文档

* https://apisix.apache.org/zh/docs/ingress-controller/deployments/k3s-rke/
* https://blog.csdn.net/weixin_45583158/article/details/122248177
* https://www.jianshu.com/p/f24a677d2405
* https://api7.ai/blog/traffic-split-in-apache-apisix-ingress-controller
