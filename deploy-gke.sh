curl https://sdk.cloud.google.com > install.sh;
bash install.sh --disable-prompts;
source $HOME/google-cloud-sdk/path.bash.inc;

gcloud components update kubectl --quiet;
gcloud auth activate-service-account --key-file service-account.json;
gcloud config set project kube8-practice;
gcloud config set compute/zone asia-northeast3-a;
gcloud container clusters get-credentials k8s-fibonacci-complex;

kubectl apply -f k8s;
kubectl rollout restart deployment api-deployment;
kubectl rollout restart deployment web-deployment; 
kubectl rollout restart deployment worker-deployment; 

##SHA 들어간 이미지를 사용할 경우
#kubectl set image deployments/api-deployment api=kwangdock/docker-fibonacci-complex:$SHA

