export AWS_B64ENCODED_CREDENTIALS=$(cat tmp.txt)

envsubst < capa/infrastructure-components.yaml | kubectl delete -f -
kubectl delete -f capa/certificate.yaml