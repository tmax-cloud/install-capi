## Download yaml
curl -L https://github.com/kubernetes-sigs/cluster-api-provider-aws/releases/download/${AWS_VERSION}/cluster-template.yaml > yaml/_template/cluster-template-aws-${AWS_VERSION}.yaml

## Initialize cluster setting
cp yaml/_template/cluster-template-aws-${AWS_VERSION}.yaml yaml/_install/2.2.cluster-template-aws-${AWS_VERSION}.yaml
sed -i 's/${CLUSTER_NAME}/'"${CLUSTER_NAME}"'/g' yaml/_template/2.2.cluster-template-aws-${AWS_VERSION}.yaml
sed -i 's/${AWS_CONTROL_PLANE_MACHINE_TYPE}/'"${AWS_CONTROL_PLANE_MACHINE_TYPE}"'/g' yaml/_template/2.2.cluster-template-aws-${AWS_VERSION}.yaml
sed -i 's/${AWS_NODE_MACHINE_TYPE}/'"${AWS_NODE_MACHINE_TYPE}"'/g' yaml/_template/2.2.cluster-template-aws-${AWS_VERSION}.yaml
sed -i 's/${AWS_SSH_KEY_NAME}/'"${AWS_SSH_KEY_NAME}"'/g' yaml/_template/2.2.cluster-template-aws-${AWS_VERSION}.yaml
sed -i 's/${KUBERNETES_VERSION}/'"${KUBERNETES_VERSION}"'/g' yaml/_template/2.2.cluster-template-aws-${AWS_VERSION}.yaml
sed -i 's/${CONTROL_PLANE_MACHINE_COUNT}/'"${CONTROL_PLANE_MACHINE_COUNT}"'/g' yaml/_template/2.2.cluster-template-aws-${AWS_VERSION}.yaml
sed -i 's/${WORKER_MACHINE_COUNT}/'"${WORKER_MACHINE_COUNT}"'/g' yaml/_template/2.2.cluster-template-aws-${AWS_VERSION}.yaml

## Provision aws cluster
kubectl apply -f yaml/_install/2.2.cluster-template-aws-${AWS_VERSION}.yaml