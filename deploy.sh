docker build -t pbgess10/multi-client:latest -t pbgess10/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t pbgess10/multi-server:latest -t pbgess10/multi-server:$SHA -f ./server/Dockerfile ./server 
docker build -t pbgess10/multi-worker:latest -t pbgess10/multi-worker:$SHA -f ./worker/Dockerfile ./worker 

docker push pbgess10/multi-client: latest
docker push pbgess10/multi-server: latest
docker push pbgess10/multi-worker: latest

docker push pbgess10/multi-client: $SHA
docker push pbgess10/multi-server: $SHA
docker push pbgess10/multi-worker: $SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=pbgess10/multi-server:$SHA
kubectl set image deployments/client-deployment client=pbgess10/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=pbgess10/multi-worker:$SHA