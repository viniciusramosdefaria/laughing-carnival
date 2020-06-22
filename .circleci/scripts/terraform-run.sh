#!/bin/bash

echo "Applying changes to ${TERRAFORM_ENV} ${ENVIRONMENT}"

cd src && AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID} AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY} make plan