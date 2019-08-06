# Interactive Docker Swarm setup
Setup Terraform, gcloud (+credentials) and just run terraform apply
<br/>
### ToDo: <br/>
 - setup credentials for gcloud (**HIGH PRIORITY**)
   https://www.terraform.io/docs/providers/google/getting_started.html
 - scripts: 
   - create scripts on differnte brances for different vms
   - git pull scripts from other branches on specific vm (while terraforming)
     - eg. "docker swarm init" [on master]
     - "echo '*you just initiated the swarm, grab that line of code and past it in your worker nodes*'"
