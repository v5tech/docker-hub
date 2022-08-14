#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

echo "[TASK 0] Setting TimeZone"
timedatectl set-timezone Asia/Shanghai

echo "[TASK 1] Setting DNS"
cat >/etc/systemd/resolved.conf <<EOF
[Resolve]
DNS=8.8.8.8
FallbackDNS=223.5.5.5
EOF
systemctl daemon-reload
systemctl restart systemd-resolved.service
mv /etc/resolv.conf /etc/resolv.conf.bak
ln -s /run/systemd/resolve/resolv.conf /etc/resolv.conf

echo "[TASK 2] Setting Ubuntu System Mirrors"
cat >/etc/apt/sources.list<<EOF
deb https://mirrors.aliyun.com/ubuntu/ focal main restricted universe multiverse
deb https://mirrors.aliyun.com/ubuntu/ focal-security main restricted universe multiverse
deb https://mirrors.aliyun.com/ubuntu/ focal-updates main restricted universe multiverse
deb https://mirrors.aliyun.com/ubuntu/ focal-backports main restricted universe multiverse
EOF
apt update -qq >/dev/null 2>&1

echo "[TASK 3] Disable and turn off SWAP"
sed -i '/swap/d' /etc/fstab
swapoff -a

echo "[TASK 4] Stop and Disable firewall"
systemctl disable --now ufw >/dev/null 2>&1

echo "[TASK 5] Install docker-ce"
apt-get -y install apt-transport-https ca-certificates curl
# curl -fsSL https://mirrors.aliyun.com/docker-ce/linux/ubuntu/gpg | sudo apt-key add -
# add-apt-repository "deb [arch=amd64] https://mirrors.aliyun.com/docker-ce/linux/ubuntu $(lsb_release -cs) stable"
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://mirrors.tuna.tsinghua.edu.cn/docker-ce/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get -y update
apt-get -y install docker-ce docker-ce-cli containerd.io docker-compose-plugin
systemctl start docker && systemctl enable docker && systemctl status docker
docker info
curl -SL "https://github.com/docker/compose/releases/download/v2.7.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
docker-compose version

echo "[TASK 6] Config docker-ce registry mirrors"
cat >/etc/docker/daemon.json<<EOF
{
    "registry-mirrors": ["https://wxp2c032.mirror.aliyuncs.com/","https://registry.cn-hangzhou.aliyuncs.com/"],
    "insecure-registries" : ["192.168.56.100:5000"]
}
EOF
systemctl restart docker && systemctl status docker
docker info

echo "[TASK 7] Enable ssh password authentication"
sed -i 's/^PasswordAuthentication .*/PasswordAuthentication yes/' /etc/ssh/sshd_config
echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config
systemctl reload sshd