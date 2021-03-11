## Delete AWS Provider infrastructure
kubectl delete -f yaml/_install/2.infrastructure-components-aws-${AWS_VERSION}.yaml
clusterawsadm bootstrap iam delete-cloudformation-stack
rm -f /usr/local/bin/clusterawsadm