#curl https://sdk.cloud.google.com > install.sh;
#bash install.sh --disable-prompts;

sudo apt-get install apt-transport-https ca-certificates gnupg;
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list;
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -;
sudo apt-get update -y && sudo apt-get install google-cloud-cli -y;

gcloud components install kubectl --quiet;
gcloud auth activate-service-account --key-file ./service-account.json;
gcloud config set project kube8-practice;
gcloud config set compute/zone asia-northeast3-a;
gcloud container clusters get-credentials k8s-fibonacci-complex;

kubectl apply -f k8s;
kubectl rollout restart deployment api-deployment;
kubectl rollout restart deployment web-deployment; 
kubectl rollout restart deployment worker-deployment; 

##SHA 들어간 이미지를 사용할 경우
#kubectl set image deployments/api-deployment api=kwangdock/docker-fibonacci-complex:$SHA

