
# Capi 설치 가이드

## 구성 요소 및 버전
* Cluster Api([github.com/kubernetes-sigs/cluster-api/latest](https://github.com/kubernetes-sigs/cluster-api/releases/latest))
* InfrastructureProvider-AWS ([https://github.com/kubernetes-sigs/cluster-api-provider-aws/releases/latest](https://github.com/kubernetes-sigs/cluster-api-provider-aws/releases/latest))

 ### **주의**
 _1. Capi는 public cloud와 원활한 통신을 위해 가급적 **최신 버전을 유지**해야 합니다. 최신 버전 확인은 위 링크를 통해 확인 바랍니다_
 <br>_2. 버전 관리 문제로 default yaml을 upload 하지 않았으나, install guide 단계 중 yaml download하는 과정이 있습니다_ 

## Prerequisites
* kubernetes version >= 1.16
* AWS IAM 정보

## 폐쇄망 설치 가이드
* 외부 네트워크 통신이 가능한 환경에서 0.presetCN.sh를 이용하여 이미지 및 패키지 다운로드 후 2.2.initCN.sh를 이용하여 폐쇄망에 CAPI 환경 구성
* 외부 네트워크 환경 스크립트 실행순서
    ```bash
    $ source version.conf
    $ bash 0.presetCN.sh
    ```
* 폐쇄망 설치 스크립트 실행순서
    ```bash
    $ source version.conf
    $ bash 1.setEnv.sh
    $ export REGISTRY={registryIP:PORT}
    $ bash 2.2.initCN.sh
    $ bash 3.x.set{Provider}.sh     ## Install Steps(Open Network) 의 Provider 설치에서 해당 Provider 파트 참조
    ```
## Install Steps(Open Network)
* Capi설정을 위한 환경변수 및 디렉토리 설정
    ```bash
    $ source version.conf
    $ bash 1.setEnv.sh
    ```

* Capi 설정에 필요한 리소스(yaml, binary)다운로드 및 설치
    ```bash
    $ bash 2.2.initCN.sh
    ```

* Provider 설치
    1. [AWS Provider]
    * UI를 통해 입력된 AWS Config 값을 아래형식으로 ./awsConfig.conf로 저장
        ```bash
        export AWS_REGION={aws_region}
        export AWS_ACCESS_KEY_ID={aws_access_key_id}
        export AWS_SECRET_ACCESS_KEY={aws_secret_key}
        ```
    * 실행 순서
        ```bash
        $ source awsConfig.conf
        $ source 3.1.setAWS.sh
        ```