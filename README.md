# CAPI 설치 가이드

## 개요
- Cluster API
  
  Cluster API (CAPI) is a set of Kubernetes APIs and tools that enable users to create, configure, and manage clusters of machine servers. It provides a declarative, Kubernetes-style API for interacting with infrastructure providers (such as AWS or vSphere) and creating and managing the lifecycle of clusters.

- Cluster API Provider AWS
    
    Cluster-API AWS is a provider for the Cluster API that enables users to create, configure, and manage clusters on Amazon Web Services (AWS). It allows users to use the Cluster API to provision and manage AWS resources such as Amazon EC2 instances, security groups, and load balancers.


- Cluster API Provider vSphere
    
    Cluster-API vSphere is a provider for the Cluster API that enables users to create, configure, and manage clusters on VMware vSphere. It allows users to use the Cluster API to provision and manage vSphere resources such as virtual machines, datacenters, and clusters.

<br/>

## 구성 요소 및 버전
- [Cluster API v1.2.7](https://github.com/kubernetes-sigs/cluster-api/tree/v1.2.7)
- [InfrastructureProvider-AWS v2.0.2](https://github.com/kubernetes-sigs/cluster-api-provider-aws/tree/v2.0.2)
- [InfrastructureProvider-vSphere v1.5.1](https://github.com/kubernetes-sigs/cluster-api-provider-vsphere/tree/v1.5.1)

 ### **주의**
 _1. CAPI는 public cloud와 원활한 통신을 위해 가급적 **최신 버전을 유지**해야 합니다. 최신 버전 확인은 위 링크를 통해 확인 바랍니다_

<br/>

## Prerequisites
- K8S version >= v1.18
- [Cert Manager 설치 가이드](https://github.com/tmax-cloud/install-cert-manager)
- Provider AWS
    - AWS credential([How to get](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_access-keys.html))
    - AWS Cloudformation Stack([How to create](https://github.com/tmax-cloud/install-capi/tree/5.0#AWS-Cloudformation-Stack-추가-방법))
    - Key pair in target region([How to create](https://github.com/tmax-cloud/install-capi/tree/5.0#AWS-Key-pare-생성-방법))
- Provider vSphere
    - vSphere Center Setup
    - DHCP Server Setup
    - vSphere credential
    - vCenter에 OVA 템플릿 등록
        - 템플릿 다운로드 - [ubuntu-1804-kube-v1.23.5.ova](https://storage.googleapis.com/capv-images/release/v1.23.5/ubuntu-1804-kube-v1.23.5.ova)
        - 이외의 템플릿은 [여기](https://github.com/kubernetes-sigs/cluster-api-provider-vsphere/tree/v1.5.1#kubernetes-versions-with-published-ovas)서 확인

        - 다운 받은 템플릿 등록하기([vCenter manual link](https://docs.vmware.com/kr/VMware-vSphere/7.0/com.vmware.vsphere.vm_admin.doc/GUID-AFEDC48B-C96F-4088-9C1F-4F0A30E965DE.html))


<hr/>

### 폐쇄망 설치 가이드는 [여기](doc/offline.md)을 참고

<hr/>

## Cluster-API 설치
   
```bash
$ cd manifest
$ chmod +x *.sh
$ bash 1-1.install-capi.sh
```
    
<br/>

<hr/>

## CAPI-AWS 설치
### 1. AWS Cloudformation Stack 추가 방법은 [여기](doc/AWS_CONSOLE.md#aws-cloudformation-stack-추가-방법)를 참고
### 2. AWS Key pair 생성 방법은 [여기](doc/AWS_CONSOLE.md#aws-key-pair-생성-방법)를 참고

### 3. Install Steps

- `manifest/aws-credential.conf` 생성 후, `AWS_ACCESS_KEY`, `AWS_SECRET_ACCESS_KEY`, `AWS_REGION`에 값을 기입 
    ```bash
    $ cd manifest
    $ cp aws-credential.conf.example aws-credential.conf
    $ cat aws-credential.conf
    export AWS_ACCESS_KEY=demo-access-key
    export AWS_SECRET_ACCESS_KEY=demo-secret-key
    export AWS_REGION=ap-northeast-2
    ```


- CAPI-AWS 설치
    ```bash
    $ bash 2-1.install-capa.sh
    ```

    
<br/>

<hr/>

## CAPI-vSphere 설치

### Install Steps
- `manifest/vsphere-credential.conf` 생성 후, `VSPHERE_USERNAME`, `VSPHERE_PASSWORD`에 값을 기입 
    ```bash
    $ cd manifest
    $ cp vsphere-credential.conf.example vsphere-credential.conf
    $ cat vsphere-credential.conf
    export VSPHERE_USERNAME=example@domain.local
    export VSPHERE_PASSWORD=your_password
    ```


- CAPI-vShere 설치
    ```bash
    $ bash 3-1.install-capv.sh
    ``` 
    
<br/>

<hr/>

## Cluster-API/AWS/vSphere 삭제

### 1. `manifest/` 경로로 이동
    
```bash
$ cd manifest
$ chmod +x *.sh
```

### 2. Cluster-API 삭제

```bash
$ bash 1-2.delete-capi.sh
```


### 3. CAPI-AWS 삭제

```bash
$ bash 2-2.delete-capa.sh
```

### 4. CAPI-vSphere 삭제

```bash
$ bash 3-2.delete-capv.sh
```
