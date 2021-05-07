source version.conf
source aws-credential.conf

## Install clusterawsadm
chmod +x bin/clusterawsadm
sudo cp bin/clusterawsadm /usr/local/bin/clusterawsadm

## To Do : Access after install, before cluster provision
## Create Cloudformation stack
#clusterawsadm bootstrap iam create-cloudformation-stack

## Install CAPA infrastructure comopnents
credential=$(clusterawsadm bootstrap credentials encode-as-profile | sed 's/\//\\\//g')
sed -i 's/${AWS_B64ENCODED_CREDENTIALS}/'"$credential"'/g' yaml/infrastructure-components-aws-${AWS_VERSION}.yaml
kubectl apply -f yaml/infrastructure-components-aws-${AWS_VERSION}.yaml

## Install service catalog template
kubectl apply -f yaml/service-catalog-template-CAPI-aws-${AWS_VERSION}.yaml

## Check install status
echo ""
clusterawsadm version

echo ""
echo ""
echo "########################################################################################"
echo "COMPLETE INSTALLATION!!!!! USE: kubectl get pods -A | grep capa"
echo ""
echo ""