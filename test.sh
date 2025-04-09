#!/bin/bash

terraform init -upgrade
terraform plan -out "test.tfplan"
terraform apply "test.tfplan"

echo "Done"