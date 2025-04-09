#!/bin/bash

export ARM_SUBSCRIPTION_ID="$(SUB_ID)"
export ARM_TENANT_ID="$(TENANT_ID)"
export ARM_CLIENT_ID="$(ARM_CLIENT_ID)"
export ARM_CLIENT_SECRET="$(ARM_CLIENT_SECRET_ID)"

terraform init -upgrade
terraform plan -out "test.tfplan"
terraform apply "test.tfplan"

echo "Done"