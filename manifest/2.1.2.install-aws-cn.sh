sudo cp bin/clusterawsadm /usr/local/bin/clusterawsadm

sudo docker load < img/cluster-api-aws_cluster-api-aws-controller_${AWS_VERSION}.tar
sudo docker tag us.gcr.io/k8s-artifacts-prod/cluster-api-aws/cluster-api-aws-controller:${AWS_VERSION} ${REGISTRY}/k8s-artifacts-prod/cluster-api-aws/cluster-api-aws-controller:${AWS_VERSION}
sudo docker push ${REGISTRY}/k8s-artifacts-prod/cluster-api-aws/cluster-api-aws-controller:${AWS_VERSION}

## Initialize aws cloudformationstack and credential
clusterawsadm bootstrap iam create-cloudformation-stack
export AWS_B64ENCODED_CREDENTIALS=$(clusterawsadm bootstrap credentials encode-as-profile | sed 's/\//\\\//g')

sed -i 's/gcr.io\/kubebuilder\/kube-rbac-proxy:'"${KUBE_RBAC_PROXY_VERSION}"'/'"${REGISTRY}"'\/kubebuilder\/kube-rbac-proxy:'"${KUBE_RBAC_PROXY_VERSION}"'/g' yaml/_template/infrastructure-components-aws-template-${AWS_VERSION}.yaml
sed -i 's/us.gcr.io\/k8s-artifacts-prod\/cluster-api-aws\/cluster-api-aws-controller:'"${AWS_VERSION}"'/'"${REGISTRY}"'\/k8s-artifacts-prod\/cluster-api-aws\/cluster-api-aws-controller:'"${AWS_VERSION}"'/g' yaml/_template/infrastructure-components-aws-template-${AWS_VERSION}.yaml

## Initialize CAPI-provider-aws settings
cp yaml/_template/infrastructure-components-aws-template-${AWS_VERSION}.yaml yaml/_install/2.1.infrastructure-components-aws-${AWS_VERSION}.yaml
sed -i 's/${AWS_B64ENCODED_CREDENTIALS}/'"${AWS_B64ENCODED_CREDENTIALS}"'/g' yaml/_install/2.1.infrastructure-components-aws-${AWS_VERSION}.yaml

## Provision aws infrastructure
kubectl apply -f yaml/_install/2.1.infrastructure-components-aws-${AWS_VERSION}.yaml

## Download and apply catalog
kubectl apply -f yaml/_catalog/1.service-catalog-template-CAPI-aws.yaml