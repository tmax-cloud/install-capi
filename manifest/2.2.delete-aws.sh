source version.conf

## Delete CAPI-provider-aws infrastructure
kubectl delete -f yaml/service-catalog-template-CAPI-aws.yaml
kubectl delete -f yaml/infrastructure-components-aws-${AWS_VERSION}.yaml
#clusterawsadm bootstrap iam delete-cloudformation-stack
sudo rm -f /usr/local/bin/clusterawsadm

echo ""
echo ""
echo "########################################################################################"
echo "COMPLETE UNINSTALLATION!!!!!"
echo ""
echo ""