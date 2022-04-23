aws ecr get-login-password --region us-west-2 | helm registry login --username AWS --password-stdin 996166566464.dkr.ecr.us-west-2.amazonaws.com
#helm push node-app-0.1.0.tgz oci://996166566464.dkr.ecr.us-west-2.amazonaws.com/
helm pull oci://996166566464.dkr.ecr.us-west-2.amazonaws.com/node-app --version 0.1.0
#helm install ecr-chart-demo ./node-app
helm install <app-name> oci://${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/my-chart --version 0.1
