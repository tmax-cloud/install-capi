## Download clusterawsadm
curl -L https://github.com/kubernetes-sigs/cluster-api-provider-aws/releases/download/${AWS_VERSION}/clusterawsadm-linux-amd64 > clusterawsadm
chmod +x clusterawsadm
sudo mv clusterawsadm /usr/local/bin/clusterawsadm

## To Do : Access after install, before cluster provision
## Create Cloudformation stack
#clusterawsadm bootstrap iam create-cloudformation-stack

## Install CAPA infrastructure comopnents
export AWS_B64ENCODED_CREDENTIALS=$(clusterawsadm bootstrap credentials encode-as-profile | sed 's/\//\\\//g')
curl -L https://github.com/kubernetes-sigs/cluster-api-provider-aws/releases/download/${AWS_VERSION}/infrastructure-components.yaml > yaml/infrastructure-components-aws-${AWS_VERSION}.yaml
sed -i 's/${AWS_B64ENCODED_CREDENTIALS}/'"${AWS_B64ENCODED_CREDENTIALS}"'/g' yaml/infrastructure-components-aws-${AWS_VERSION}.yaml
kubectl apply -f yaml/infrastructure-components-aws-${AWS_VERSION}.yaml

## Install service catalog template
curl -L https://github.com/tmax-cloud/install-capi/releases/download/v0.1.0/service-catalog-template-CAPI-aws.yaml > yaml/service-catalog-template-CAPI-aws.yaml
kubectl apply -f yaml/service-catalog-template-CAPI-aws.yaml

echo ""
echo ""
echo "########################################################################################"
echo "COMPLETE INSTALLATION!!!!! USE: kubectl get pods -A | grep capa"
echo ""
echo ""