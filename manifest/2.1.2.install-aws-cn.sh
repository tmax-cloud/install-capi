## Set binary
sudo cp bin/clusterawsadm /usr/local/bin/clusterawsadm

## Register images to registry
sudo docker load < img/cluster-api-aws_cluster-api-aws-controller_${AWS_VERSION}.tar
sudo docker tag us.gcr.io/k8s-artifacts-prod/cluster-api-aws/cluster-api-aws-controller:${AWS_VERSION} ${REGISTRY}/k8s-artifacts-prod/cluster-api-aws/cluster-api-aws-controller:${AWS_VERSION}
sudo docker push ${REGISTRY}/k8s-artifacts-prod/cluster-api-aws/cluster-api-aws-controller:${AWS_VERSION}

## To Do : Access after install, before cluster provision
## Initialize aws cloudformationstack and credential
#clusterawsadm bootstrap iam create-cloudformation-stack

## Install CAPA infrastructure comopnents
export AWS_B64ENCODED_CREDENTIALS=$(clusterawsadm bootstrap credentials encode-as-profile | sed 's/\//\\\//g')
sed -i 's/gcr.io\/kubebuilder\/kube-rbac-proxy:'"${KUBE_RBAC_PROXY_VERSION}"'/'"${REGISTRY}"'\/kubebuilder\/kube-rbac-proxy:'"${KUBE_RBAC_PROXY_VERSION}"'/g' yaml/infrastructure-components-aws-${AWS_VERSION}.yaml
sed -i 's/us.gcr.io\/k8s-artifacts-prod\/cluster-api-aws\/cluster-api-aws-controller:'"${AWS_VERSION}"'/'"${REGISTRY}"'\/k8s-artifacts-prod\/cluster-api-aws\/cluster-api-aws-controller:'"${AWS_VERSION}"'/g' yaml/infrastructure-components-aws-${AWS_VERSION}.yaml
sed -i 's/${AWS_B64ENCODED_CREDENTIALS}/'"${AWS_B64ENCODED_CREDENTIALS}"'/g' yaml/infrastructure-components-aws-${AWS_VERSION}.yaml
kubectl apply -f yaml/infrastructure-components-aws-${AWS_VERSION}.yaml

## Install service catalog template
kubectl apply -f yaml/service-catalog-template-CAPI-aws.yaml

echo ""
echo ""
echo "########################################################################################"
echo "COMPLETE INSTALLATION!!!!! USE: kubectl get pods -A | grep capa"
echo ""
echo ""