
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
* 최종 실행순서
    ```bash
    $ source 0.presetCN.sh
    $ source 1.setEnv.sh
    $ bash 2.2.initCN.sh
    $ bash 3.x.set{Provider}.sh
    ```
## Install Steps(Open Network)
1. [환경변수 및 디렉토리]
* 목적 : Capi설정을 위한 환경변수 및 디렉토리 설정
    ```bash
    $ source 1.setEnv.sh
    $ export REGISTRY={registry IP:PORT}
    ```
* 주의사항 : 환경변수를 export하기 위해서 꼭 source command를 통하여 실행해주어야 함


2. [리소스 다운로드 및 설치]
* 목적 : Capi 설정에 필요한 리소스(yaml, binary)다운로드 및 설치
    ```bash
    $ bash 2.2.initCN.sh
    ```

3. [외부 프로바이더 설치]
* 목적 : 해당 Platform에 VM을 구축하기 위해 CAPI Provider api를 설치
    3.1. [AWS Provider]
    * AWS config file : UI를 통해 입력된 값을 아래형식으로 ./awsConfig.conf로 저장
        ```bash
        export AWS_REGION={aws_region}
        export AWS_ACCESS_KEY_ID={aws_access_key_id}
        export AWS_SECRET_ACCESS_KEY={aws_secret_key}
        '''
    * 실행 순서
        ```bash
        $ source awsConfig.conf
        $ bash 3.1.setAWS.sh
        ```