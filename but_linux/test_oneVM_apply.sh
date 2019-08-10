#!/bin/bash

#echo ""
#echo "Run terraform plan to see which instance you wanna terraform only and append next line"
#echo ""
#read

terraform apply -target google_compute_instance.nginx -target google_compute_firewall.default
