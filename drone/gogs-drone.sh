docker volume create gogs-data
docker volume create drone-data


docker run -d \
  --volume=gogs-data:/data \
  --env=TZ="Asia/Shanghai" \
  --publish=2222:22 \
  --publish=30000:3000 \
  --restart=always \
  --name=gogs \
  gogs/gogs


docker run -d \
  --volume=drone-data:/data \
  --env=DRONE_AGENTS_ENABLED=true \
  --env=DRONE_GOGS_SERVER=http://192.168.101.41:30000 \
  --env=DRONE_RPC_SECRET=1c0601db6b8d55072c34df5ca2456a0a \
  --env=DRONE_SERVER_HOST=192.168.101.41:8000 \
  --env=DRONE_SERVER_PROTO=http \
  --env=DRONE_USER_CREATE=username:fengj,admin:true \
  --env=TZ="Asia/Shanghai" \
  --publish=8000:80 \
  --restart=always \
  --name=drone \
  drone/drone:2


docker run -d \
  --volume=/var/run/docker.sock:/var/run/docker.sock \
  --env=DRONE_RPC_PROTO=http \
  --env=DRONE_RPC_HOST=192.168.101.41:8000 \
  --env=DRONE_RPC_SECRET=1c0601db6b8d55072c34df5ca2456a0a \
  --env=DRONE_RUNNER_CAPACITY=2 \
  --env=DRONE_RUNNER_NAME=runner-docker \
  --env=DRONE_TRACE=true \
  --env=TZ="Asia/Shanghai" \
  --publish=3000:3000 \
  --restart=always \
  --name=runner-docker \
  drone/drone-runner-docker:1