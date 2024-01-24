docker build -t brs97/multi-client:latest brs97/multi-client:$SHA  -f ./client/Dockerfile ./client
docker build -t brs97/multi-server:latest brs97/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t brs97/multi-worker:latest brs97/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push brs97/multi-client:latest
docker push brs97/multi-client:$SHA
docker push brs97/multi-server:latest
docker push brs97/multi-server:$SHA
docker push brs97/multi-worker:latest
docker push brs97/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=brs97/multi-server:$SHA
kubectl set image deployments/client-deployment client=brs97/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=brs97/multi-worker:$SHA