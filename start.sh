#!/bin/bash
terraform -chdir=./terraform apply
sleep 60
ansible-playbook ./ansible/main.yml -i ./ansible/inventory

#ansible node_exp -i /home/tkharlamov/ITEA/Final_Task/ansible/inventory -m script -a /home/tkharlamov/ITEA/Final_Task/exporter_install.sh
#/bin/bash ./prometheus
#/bin/bash ./grafana
