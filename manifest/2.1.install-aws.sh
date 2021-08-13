if [ ! -f "aws-credential.conf" ]; then
    bash message.sh "ERROR" "'aws-credential.conf' is NOT EXIST!"
    exit 0
fi

source version.conf
source aws-credential.conf

sed -i 's#${AWS_ACCESS_KEY}#'${AWS_ACCESS_KEY}'#g' ./aws-credential.form
sed -i 's#${AWS_SECRET_ACCESS_KEY}#'${AWS_SECRET_ACCESS_KEY}'#g' ./aws-credential.form
sed -i 's#${AWS_REGION}#'${AWS_REGION}'#g' ./aws-credential.form
credential=$(cat ./aws-credential.form | base64 | tr -d '\n')

## Install CAPA infrastructure comopnents
sed -i 's#${AWS_B64ENCODED_CREDENTIALS}#'"$credential"'#g' yaml/infrastructure-components-aws-${AWS_VERSION}.yaml
kubectl apply -f yaml/infrastructure-components-aws-${AWS_VERSION}.yaml

bash message.sh "SUCCESS" "see 'kubectl get pods -A | grep capa'"
