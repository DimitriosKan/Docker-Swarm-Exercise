# Interactive Docker Swarm setup
Setup Terraform, gcloud (+credentials) and just run terraform apply
<br/>

## How To Run: <br/>
 - pull repo
 - run ./terra_setup
   - if it errors you might need to setup gcloud on your machine
 - in the output of the terraform action you will see how to ssh in each VM <br/>
   inside the home folder you will see the tutorial file (run it and follow along)

### Setup sequence:
   Start off with:
   - MANAGER-VM
   - WORKER1/2-VM
   - MANAGER-VM
   - NGINX-VM
