docker volume create gitea-data
docker volume create drone-data


docker run -d \
  --volume=gitea-data:/data \
  --volume=/etc/timezone:/etc/timezone:ro \
  --volume=/etc/localtime:/etc/localtime:ro \
  --env=USER_UID=1000 \
  --env=USER_GID=1000 \
  --env=APP_NAME=gitea \
  --env=RUN_MODE=prod \
  --env=SSH_DOMAIN=192.168.101.41 \
  --env=SSH_PORT=2222 \
  --env=SSH_LISTEN_PORT=22 \
  --env=HTTP_PORT=3000 \
  --env=ROOT_URL=http://192.168.101.41:30000 \
  --env=TZ="Asia/Shanghai" \
  --publish=2222:22 \
  --publish=30000:3000 \
  --restart=always \
  --name=gitea \
  gitea/gitea


docker run -d \
  --volume=drone-data:/data \
  --volume=/etc/timezone:/etc/timezone:ro \
  --volume=/etc/localtime:/etc/localtime:ro \
  --env=DRONE_GITEA_SERVER=http://192.168.101.41:30000 \
  --env=DRONE_GITEA_CLIENT_ID=1d50da68-0863-40b8-ab72-1d0eaa358d5c \
  --env=DRONE_GITEA_CLIENT_SECRET=Nn4tjJqJy579Ri3OU0oNHipieU47dL0IGAOTkPNxtlxf \
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
  --volume=/etc/timezone:/etc/timezone:ro \
  --volume=/etc/localtime:/etc/localtime:ro \
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