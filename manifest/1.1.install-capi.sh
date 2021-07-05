if [ ! -f "oidc.conf" ]; then
    bash message.sh "ERROR" "'oidc.conf' is NOT EXIST!"
    exit 0
fi

source version.conf
source oidc.conf

## Set oidc configuration to templates
sed -i 's/${OIDC_ISSUER_URL}/'"${OIDC_ISSUER_URL}"'/g' yaml/service-catalog-template-CAPI-*.yaml
sed -i 's/${OIDC_CLIENT_ID}/'"${OIDC_CLIENT_ID}"'/g' yaml/service-catalog-template-CAPI-*.yaml
sed -i 's/${OIDC_USERNAME_CLAIM}/'"${OIDC_USERNAME_CLAIM}"'/g' yaml/service-catalog-template-CAPI-*.yaml
sed -i 's/${OIDC_USERNAME_PREFIX}/'"${OIDC_USERNAME_PREFIX}"'/g' yaml/service-catalog-template-CAPI-*.yaml
sed -i 's/${OIDC_GROUPS_CLAIM}/'"${OIDC_GROUPS_CLAIM}"'/g' yaml/service-catalog-template-CAPI-*.yaml
sed -i 's/${OIDC_CA_FILE}/'"${OIDC_CA_FILE}"'/g' yaml/service-catalog-template-CAPI-*.yaml
sed -i ${HYPERAUTH_CERT} yaml/service-catalog-template-CAPI-*.yaml
sed -i 's/\\n/\'$'\n''/g' yaml/service-catalog-template-CAPI-*.yaml

## Download and provision CAPI
kubectl apply -f yaml/cluster-api-components-${CAPI_VERSION}.yaml

bash ./message.sh "SUCCESS" "see 'kubectl get pods -A | grep capi'"