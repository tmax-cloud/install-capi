source vsphere-credential.conf

envsubst < capv/infrastructure-components.yaml | kubectl delete -f -
kubectl delete -f capv/certificate.yaml