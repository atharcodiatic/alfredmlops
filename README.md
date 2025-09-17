# Helpdesk App Deployment
app is deployed behind nginx which act as reverse proxy(port 8080)
request -> nginx 8080 -> django app 8000
Repo contains deployment with k8s and nomad. 
A jenkins file is added for Cicd.

steps to run nomad deployment 
1. cd nomad
2. start the nomad server - nomad agent -dev
3. Run the job - nomad job run hello-world.nomad
4. http://localhost:8080

Infrastructure as a code - 
terraform folder has automated setup for aws.

steps to run k8s deployment 
1. minikube start - start the cluster
2. kubectl apply -f ingress.yaml
3. kubectl apply -f web_deployment.yaml
4. kubectl apply -f deployment.yaml
visit port 8080 on browser

Note: k8s is using the secret to pull the docker image. 
if error occurs please push the image to docker hub and 
if you're pushing to private repo create a credential in
the same cluster namespace.

JenkinsFile - 
setup - 
1.poolscm in jenkins server settings(github url)
2. github webhook

pipeline will trigger through github webhook
when any changes in repo detected.
