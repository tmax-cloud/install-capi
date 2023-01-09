
# Capi 설치 가이드

## 개용
- Cluster Api
    - Cluster API is a Kubernetes sub-project focused on providing declarative APIs and tooling to simplify provisioning, upgrading, and operating multiple Kubernetes clusters.
- Cluster Api Provider AWS
    - The Cluster API brings declarative, Kubernetes-style APIs to cluster creation, configuration and management.
    The API itself is shared across multiple cloud providers allowing for true AWS hybrid deployments of Kubernetes. It is built atop the lessons learned from previous cluster managers such as kops and kubicorn.

<br/>

## 구성 요소 및 버전
- [Cluster Api](https://github.com/kubernetes-sigs/cluster-api/releases/latest)
- [InfrastructureProvider-AWS](https://github.com/kubernetes-sigs/cluster-api-provider-aws/releases/latest)
- [InfrastructureProvider-vSphere](https://github.com/kubernetes-sigs/cluster-api-provider-vsphere/releases/latest)

 ### **주의**
 _1. Capi는 public cloud와 원활한 통신을 위해 가급적 **최신 버전을 유지**해야 합니다. 최신 버전 확인은 위 링크를 통해 확인 바랍니다_

<br/>

## Prerequisites
- kubernetes version >= 1.18
- Cert Manager
    - [설치 가이드](https://github.com/tmax-cloud/install-cert-manager)
- Provider AWS
    - AWS credential([How to get](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_access-keys.html))
    - AWS Cloudformation Stack([How to create](https://github.com/tmax-cloud/install-capi/tree/5.0#AWS-Cloudformation-Stack-추가-방법))
    - Key pair in target region([How to create](https://github.com/tmax-cloud/install-capi/tree/5.0#AWS-Key-pare-생성-방법))
- Provider vSphere
    - vSphere Center Setup
        - vCenter에 OVA 템플릿 등록
            - OVA Template Download([Download link](https://storage.googleapis.com/capv-images/release/v1.23.5/ubuntu-1804-kube-v1.23.5.ova))
            - vCenter에 다운로드 받은 템플릿을 등록([vCenter manual link](https://docs.vmware.com/kr/VMware-vSphere/7.0/com.vmware.vsphere.vm_admin.doc/GUID-AFEDC48B-C96F-4088-9C1F-4F0A30E965DE.html))
    - DHCP Server
    - vSphere credential

<br/>

## AWS Cloudformation Stack 추가 방법
- 동일한 Cloudformation Stack은 한 region에만 unique하게 존재할 수 있으며, management를 위해서 어떤 region에 생성하였는지를 기억하고 있는것을 권장함

- Step1: AWS Cloudformation console에서 stack을 생성할 region을 선택하고, 스택 생성 > 새 리소스 사용(표준) 선택([AWS Cloudformation Link](https://console.aws.amazon.com/cloudformation))
![image](figure/step1.png)

- Step2: 템플릿 파일 업로드를 선택하고 manifest/yaml/cluster-api-provider-aws-sigs-k8s-io.yaml을 업로드후 "다음" 버튼 클릭
![image](figure/step2.png)

- Step3: 스택 이름 입력(cluster-api-provider-aws-sigs-k8s-io)후 "다음" 버튼 클릭
![image](figure/step3.png)

- Step4: 태그입력(optional)후 "다음" 버튼 클릭
![image](figure/step4.png)

- Step5: 하단 체크박스 클릭후 "스택 생성" 버튼 클릭
![image](figure/step5.png)

<br/>

## AWS Key pare 생성 방법
- Step1: AWS EC2 console에서 Key pair를 생성할 region을 선택하고, 키 페어 클릭([AWS EC2 Link](https://console.aws.amazon.com/ec2/v2))
![image](figure/keypair_step1.png)

- Step2: "키 페어 생성" 버튼 클릭

- Step3: 키 페어 이름 입력후 "키 페어 생성" 버튼 클릭

<br/>

## 폐쇄망 설치 가이드
- 외부 네트워크 통신이 가능한 환경에서 0.preset-cn.sh를 이용하여 이미지 및 패키지를 다운로드하여 폐쇄망 환경으로 옮겨준 뒤, 설치 스크립트를 수행
    - 외부 네트워크 환경 스크립트 실행순서
        ```bash
        $ cd manifest
        $ chmod +x *.sh
        $ bash 0.preset-cn.sh
        ```

    - 폐쇄망 설치 스크립트 실행순서
        - 외부 네트워크 환경에서 받은 파일들을 manifest경로 아래 위치시켜야 함
            - img/

        - Capi 설치
        ```bash
        $ cd manifest
        $ chmod +x *.sh
        $ cat << "EOF" | tee registry.conf
          export REGISTRY={registryIP:PORT}
          EOF
        $ bash 1.0.set-cn-capi.sh
        $ bash 1.1.install-capi.sh
        ```
        
        - Provider 설치
            1. [AWS Provider]
            - 아래 명령어를 순서대로 수행
                ```bash
                $ cat << "EOF" | tee aws-credential.conf
                  export AWS_REGION=your-region-1
                  export AWS_ACCESS_KEY=your_access_key
                  export AWS_SECRET_ACCESS_KEY=your_secret_key
                  EOF
                $ bash 2.0.set-cn-aws.sh
                $ bash 2.1.install-aws.sh
                ```

            2. [vSphere Provider]
            - 아래 명령어를 순서대로 수행
                ```bash
                $ cat << "EOF" | tee vsphere-credential.conf
                  export VSPHERE_USERNAME=your_username
                  export VSPHERE_PASSWORD=your_password
                  EOF
                $ bash 3.0.set-cn-vsphere.sh
                $ bash 3.1.install-vsphere.sh
                ```

<br/>

## Install Steps(Open Network)
- Capi 설치에 필요한 리소스(yaml, binary)다운로드 및 설치
    ```bash
    $ cd manifest
    $ chmod +x *.sh
    $ bash 1.1.install-capi.sh
    ```

- Provider 설치
    1. [AWS Provider]
    - 아래 명령어를 순서대로 수행
        ```bash
        $ cat << "EOF" | tee aws-credential.conf
          export AWS_REGION=your-region-1
          export AWS_ACCESS_KEY=your_access_key
          export AWS_SECRET_ACCESS_KEY=your_secret_key
          EOF
        $ bash 2.1.install-aws.sh

    2. [vSphere Provider]
    - 아래 명령어를 순서대로 수행
        ```bash
        $ cat << "EOF" | tee vsphere-credential.conf
          export VSPHERE_USERNAME=example@domain.local
          export VSPHERE_PASSWORD=your_password
          EOF
        $ bash 3.1.install-vsphere.sh
        ```

<br/>

## Uninstall Steps
- Provider 삭제
    1. [AWS Provider]
    - 실행 순서
        ```bash
        $ cd manifest
        $ bash 2.2.delete-aws.sh
        ```

    2. [vSphere Provider]
    - 실행 순서
        ```bash
        $ cd manifest
        $ bash 3.2.delete-vsphere.sh
        ```

- CAPI와 Provider들의 CRD 제거 및 바이너리, yaml등의 리소스 삭제
    ```bash
    $ bash 1.2.delete-capi.sh
    ```
