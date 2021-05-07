
# Capi 설치 가이드

## 구성 요소 및 버전
* [Cluster Api](https://github.com/kubernetes-sigs/cluster-api/releases/latest)
* [InfrastructureProvider-AWS](https://github.com/kubernetes-sigs/cluster-api-provider-aws/releases/latest)
* [InfrastructureProvider-vSphere](https://github.com/kubernetes-sigs/cluster-api-provider-vsphere/releases/latest)

 ### **주의**
 _1. Capi는 public cloud와 원활한 통신을 위해 가급적 **최신 버전을 유지**해야 합니다. 최신 버전 확인은 위 링크를 통해 확인 바랍니다_
 <br>_2. 버전 관리 문제로 default yaml을 upload 하지 않았으나, install guide 단계 중 yaml download하는 과정이 있습니다_ 

## Prerequisites
* kubernetes version >= 1.16
* Cert Manager
    * [임시 설치 가이드](https://github.com/tmax-cloud/install-cert-manager-temp)
* Template Service Broker
    * [설치 가이드](https://github.com/tmax-cloud/template-service-broker)
* Catalog Controller
    * [설치 가이드](https://github.com/tmax-cloud/install-catalog)
* Provider AWS
    * AWS credential([How to get](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_access-keys.html))
    ~~* AWS machine spec([Spec list](https://aws.amazon.com/ec2/instance-types/?nc1=h_ls))~~
    * AWS Cloudformation Stack
* Provider vSphere
    * vSphere Center Setup
        * vCenter에 OVA 템플릿 등록
            * [OVA Template Download](https://storage.googleapis.com/capv-images/release/v1.17.3/ubuntu-1804-kube-v1.17.3.ova)
            * [vCenter에 다운로드 받은 템플릿을 등록](https://docs.vmware.com/kr/VMware-vSphere/7.0/com.vmware.vsphere.vm_admin.doc/GUID-AFEDC48B-C96F-4088-9C1F-4F0A30E965DE.html)
    * DHCP Server
    * vSphere credential
    ~~* vSphere machine spec~~
        ~~* Resource pool, ...~~

## 폐쇄망 설치 가이드
* 외부 네트워크 통신이 가능한 환경에서 0.preset-cn.sh를 이용하여 이미지 및 패키지 다운로드 하여 옮겨준 뒤, 폐쇄망 환경에서 설치 스크립트 실행
* 외부 네트워크 환경 스크립트 실행순서
    ```bash
    $ cd manifest
    $ chmod +x *.sh
    $ bash 0.preset-cn.sh
    ```

* 폐쇄망 설치 스크립트 실행순서
    * Capi 설치
    ```bash
    $ cd manifest
    $ chmod +x *.sh
    $ export REGISTRY={registryIP:PORT}
    $ bash 1.2.install-capi-cn.sh
    ```
    
    * Provider 설치
        1. [AWS Provider]
        * AWS Config 값을 manifest경로 아래 aws-credential.conf에 저장후 스크립트 실행
            ```bash
            $ cat << "EOF" | tee aws-credential.conf
                > export AWS_REGION=your-region-1
                > export AWS_ACCESS_KEY=your_access_key
                > export AWS_SECRET_ACCESS_KEY=your_secret_key
                > EOF
            $ bash 2.0.set-cn-aws.sh
            $ bash 2.1.install-aws.sh
            ```

        2. [vSphere Provider]
        * vCenter Config 값을 manifest경로 아래 vsphere-credential.conf로 저장후 스크립트 실행
            ```bash
            $ cat << "EOF" | tee vsphere-credential.conf
                > export VSPHERE_USERNAME=example@domain.local
                > export VSPHERE_PASSWORD=your_password
                > EOF
            $ bash 3.0.set-cn-vsphere.sh
            $ bash 3.1.install-vsphere.sh
            ```
## Install Steps(Open Network)
* Capi 설치에 필요한 리소스(yaml, binary)다운로드 및 설치
    ```bash
    $ cd manifest
    $ chmod +x *.sh
    $ bash 1.1.install-capi.sh
    ```

* Provider 설치
    1. [AWS Provider]
    * AWS Config 값을 manifest경로 아래 aws-credential.conf에 저장후 스크립트 실행
        ```bash
        $ cat << "EOF" | tee aws-credential.conf
            > export AWS_REGION=your-region-1
            > export AWS_ACCESS_KEY=your_access_key
            > export AWS_SECRET_ACCESS_KEY=your_secret_key
            > EOF
        $ bash 2.1.install-aws.sh

    2. [vSphere Provider]
    * vCenter Config 값을 manifest경로 아래 vsphere-credential.conf로 저장후 스크립트 실행
        ```bash
        $ cat << "EOF" | tee vsphere-credential.conf
            > export VSPHERE_USERNAME=example@domain.local
            > export VSPHERE_PASSWORD=your_password
            > EOF
        $ bash 3.1.install-vsphere.sh
        ```
## Uninstall Steps
* Provider 삭제
    1. [AWS Provider]
    * 실행 순서
        ```bash
        $ cd manifest
        $ bash 2.2.delete-aws.sh
        ```

    2. [vSphere Provider]
    * 실행 순서
        ```bash
        $ cd manifest
        $ bash 3.2.delete-vsphere.sh
        ```

* CAPI와 Provider들의 CRD 제거 및 바이너리, yaml등의 리소스 삭제
    ```bash
    $ bash 1.2.delete-capi.sh
    ```