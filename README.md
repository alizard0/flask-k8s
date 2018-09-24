> Start a basic flask webserver on top of a kubernetes cluster in your laptop.

#### Requirements
* Your flask webserver (just copy it from flask website)
* Install minikube and kubectl (follow the steps on their official websites)

#### Create Dockerfile to wrap your webserver
```
FROM python:2.7-alpine
MAINTAINER alizard0

RUN mkdir -p /usr/src/ws
WORKDIR /usr/src/ws

COPY requirements.txt /usr/src/ws/
RUN pip install --no-cache-dir -r requirements.txt

COPY ws.py /usr/src/ws
EXPOSE 5000

CMD ["python", "ws.py"]
```

#### Build & Run Docker
* `docker build -t ws:0.0.1 .`
* `docker run -dit -p 5000:5000 <your-docker-username>/ws:0.0.1`
* `docker push <your-docker-username>/ws:0.0.1`

> Note: it is highly recommended to push the image to your docker account. You can change minikube settings to use local images instead.

#### Init Cluster & Run container
* `minikube start --vm-driver=hyperkit`
* `kubectl run flask --image=<your-docker-username>/ws:0.0.1 --port 5000`
* `kubectl expose deployment flask --type=NodePort`

##### Using yaml file
* `kubectl create -f ws-deployment.yaml`
* `kubectl create -f ws-service.yaml`

#### Check pods & hit webserver
* `kubectl get pod`
* `curl $(minikube service flask --url)`

#### Delete services
* `kubectl delete services flask`
* `kubectl delete deployment flask`

#### References
* https://kubernetes.io/docs/setup/minikube/
* https://github.com/learnk8s/spring-boot-k8s-hpa
