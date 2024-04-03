**Initialize the Project Directory**
```
git init
```
**Stage, Commit and Push Changes**
```
git add .
git commit -m "Initial commit with basic e-commerce site structure"
git remote add origin https://github.com/your-git-username/repo.git
git push -u origin main
```

**Dockerize the Application**
```
# Use the official NGINX base image
FROM nginx:latest

# Set the working directory in the container
WORKDIR  /usr/share/nginx/html/

# Copy the local HTML file to the NGINX default public directory
COPY index.html /usr/share/nginx/html/

# Copy the local HTML file to the NGINX default public directory
COPY index.html /usr/share/nginx/html/

# Expose port 80 to allow external access
EXPOSE 80

# No need for CMD as NGINX image comes with a default CMD to start the server
```

**Bulid Docker Images**
```
docker buils -t dockerfile .
```

**Push Images to Docker Hub**
```
docker tag <your-image-name> <your-dockerhub-username>/<your-repository-name>:<tag>
docker login -u <your-docker-hub-username>
docker push <your-dockerhub-username>/<your-repository-name>:<tag>
```

**Create Kubernetes Deployment.yaml File**
```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: my-deployment
spec:
  replicas: 1
  selector:
    matchLabels:
      app: my-nginx
  template:
    metadata:
      labels:
        app: my-nginx
    spec:
      containers:
      - name: my-nginx
        image: dareyregistry/my-nginx:1.0
        ports:
        - containerPort: 80
```
**Apply the Deployment to the cluster**
```
kubectl apply -f deployment.yaml
```

**Create Kubernetes Service.yaml File**
```
apiVersion: v1
kind: Service
metadata:
  name: my-nginx-service
spec:
  selector:
    app: my-nginx
  ports:
    - protocol: TCP
      port: 80
      targetPort: 80
  type: ClusterIP
```
**Apply the service.yaml to the cluster**
```
kubectl apply -f service.yaml
```
