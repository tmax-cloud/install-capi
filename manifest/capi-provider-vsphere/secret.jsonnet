function (
    username="id"
    password="pw"
)
    [
        {
            "apiVersion": "1",
            "kind": "Secret",
            "metadata": {
                "labels": [
                    {
                        "cluster.x-k8s.io/provider": "infrastructure-vsphere",
                    },
                ],
                "name": "capv-manager-bootstrap-credentials",
                "namespace": "capv-system",
            },
            "stringData": {
                "credentials.yaml": "username: 'username'\npassword: 'password'",
            },
            "type": "Opaque",
        },
    ]