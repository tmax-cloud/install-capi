## AWS CLI
#curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
#unzip awscliv2.zip
#rm -f unzip awscliv2.zip
#sudo ./aws/install

## clusterawsadm
curl -L https://github.com/kubernetes-sigs/cluster-api-provider-aws/releases/download/${AWS_VERSION}/clusterawsadm-linux-amd64 -o clusterawsadm
chmod +x clusterawsadm
mv clusterawsadm /usr/local/bin/clusterawsadm

## CAPI AWS provider initialize
clusterawsadm bootstrap iam create-cloudformation-stack
export AWS_B64ENCODED_CREDENTIALS=$(clusterawsadm bootstrap credentials encode-as-profile)
clusterctl init --infrastructure aws

cp yaml/_template/infrastructure-components-aws-template-${AWS_VERSION}.yaml yaml/_install/2.infrastructure-components-aws-${AWS_VERSION}.yaml

sed -i 's/${AWS_B64ENCODED_CREDENTIALS}/'${AWS_B64ENCODED_CREDENTIALS}'/g' yaml/_install/2.infrastructure-components-aws-${AWS_VERSION}.yaml

curl -L https://github.com/kubernetes-sigs/cluster-api-provider-aws/releases/download/"${AWS_VERSION}"/infrastructure-components.yaml > yaml/_template/infrastructure-components-aws-template-${AWS_VERSION}.yaml
curl -L https://github.com/kubernetes-sigs/cluster-api-provider-aws/releases/download/${AWS_VERSION}/cluster-template.yaml > yaml/_template/cluster-aws-template-${AWS_VERSION}.yaml