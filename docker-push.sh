# docker authenticate
echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin 

# build and push web
docker build -t kwangdock/docker-fibonacci-complex-web:latest \
  -t kwangdock/docker-fibonacci-complex-web:$SHA ./web && 
docker push kwangdock/docker-fibonacci-complex-web:latest &
docker push kwangdock/docker-fibonacci-complex-web:$SHA

# build and push api
docker build -t kwangdock/docker-fibonacci-complex-api:latest \
  -t kwangdock/docker-fibonacci-complex-api:$SHA ./api &&
docker push kwangdock/docker-fibonacci-complex-api:latest &
docker push kwangdock/docker-fibonacci-complex-api:$SHA

# build and push worker
docker build -t kwangdock/docker-fibonacci-complex-worker:latest \
  -t kwangdock/docker-fibonacci-complex-worker:$SHA ./worker &&
docker push kwangdock/docker-fibonacci-complex-worker:latest &
docker push kwangdock/docker-fibonacci-complex-worker:$SHA
