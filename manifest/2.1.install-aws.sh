if [ ! -f "aws-credential.conf" ]; then
    bash message.sh "ERROR" "'aws-credential.conf' is NOT EXIST!"
    exit 0
fi

source version.conf
source aws-credential.conf

## Install clusterawsadm
chmod +x bin/clusterawsadm
sudo cp bin/clusterawsadm /usr/local/bin/clusterawsadm

## To Do : Access after install, before cluster provision
## Create Cloudformation stack
clusterawsadm bootstrap iam create-cloudformation-stack

## Install CAPA infrastructure comopnents
credential=$(clusterawsadm bootstrap credentials encode-as-profile | sed 's/\//\\\//g')
sed -i 's/${AWS_B64ENCODED_CREDENTIALS}/'"$credential"'/g' yaml/infrastructure-components-aws-${AWS_VERSION}.yaml
kubectl apply -f yaml/infrastructure-components-aws-${AWS_VERSION}.yaml

## Check install status
echo ""
clusterawsadm version

bash message.sh "SUCCESS" "see 'kubectl get pods -A | grep capa'"
