## Download clusterawsadm
curl -L https://github.com/kubernetes-sigs/cluster-api-provider-aws/releases/download/${AWS_VERSION}/clusterawsadm-linux-amd64 -o clusterawsadm
chmod +x clusterawsadm
sudo mv clusterawsadm /usr/local/bin/clusterawsadm

## Initialize aws cloudformationstack and credential
clusterawsadm bootstrap iam create-cloudformation-stack
export AWS_B64ENCODED_CREDENTIALS=$(clusterawsadm bootstrap credentials encode-as-profile | sed 's/\//\\\//g')

## Download yaml
curl -L https://github.com/kubernetes-sigs/cluster-api-provider-aws/releases/download/${AWS_VERSION}/infrastructure-components.yaml > yaml/_template/infrastructure-components-aws-template-${AWS_VERSION}.yaml

## Initialize CAPI-provider-aws settings
cp yaml/_template/infrastructure-components-aws-template-${AWS_VERSION}.yaml yaml/_install/2.1.infrastructure-components-aws-${AWS_VERSION}.yaml
sed -i 's/${AWS_B64ENCODED_CREDENTIALS}/'"${AWS_B64ENCODED_CREDENTIALS}"'/g' yaml/_install/2.1.infrastructure-components-aws-${AWS_VERSION}.yaml

## Provision aws infrastructure
kubectl apply -f yaml/_install/2.1.infrastructure-components-aws-${AWS_VERSION}.yaml

## Download and apply catalog
curl -L https://github.com/tmax-cloud/install-capi/releases/download/v0.1.0/service-catalog-template-CAPI-aws.yaml > yaml/_catalog/1.service-catalog-template-CAPI-aws.yaml
kubectl apply -f yaml/_catalog/1.service-catalog-template-CAPI-aws.yaml