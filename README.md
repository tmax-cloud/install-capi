
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
    *  $HOME/install-capi 디렉토리 생성 후 스크립트 파일들을 옮겨준다
    ```bash
    ## path 생성 및 설정
    $ export $FILE_DIR=${file dir}
    # ${file dir}은 img, yaml 디렉토리의 부모디렉토리로 입력해준다
    $ mkdir $HOME/install-capi
    $ cd $HOME/install-capi
    ## 이 경로로 스크립트를 옮겨준다
    $ source version.conf
    $ export REGISTRY={registryIP:PORT}
    $ bash 1.2.initCN.sh
    $ bash 2.x.set{Provider}.sh -c
    ## Provider에 따른 Script File Name List
    ## AWS      : 2.1.setAWS.sh
    ## vSphere  : 2.2.setVsphere.sh
    ```
## Install Steps(Open Network)
* Capi 설치에 필요한 리소스(yaml, binary)다운로드 및 설치
    ```bash
    $ source version.conf
    $ bash 1.1.initON.sh
    ```

* Provider 설치
    1. [AWS Provider]
    * UI를 통해 입력된 AWS Config 값을 아래형식으로 manifest경로 아래 aws-credential.conf로 저장
        ```bash
        export AWS_REGION={aws_region}
        export AWS_ACCESS_KEY_ID={aws_access_key_id}
        export AWS_SECRET_ACCESS_KEY={aws_secret_key}
        ```
    * 실행 순서
        ```bash
        $ source aws-credential.conf
        $ source 2.1.setAWS.sh -o
        ```

    2. [vSphere Provider]
    * UI를 통해 입력된 vSphere Config 값을 아래형식으로 manifest경로 아래 vsphere-credential.conf로 저장
        ```bash
        export VSPHERE_USERNAME={vsphere_username}
        export VSPHERE_PASSWORD={vsphere_password}
        ```
    * 실행 순서
        ```bash
        $ source vsphere-credential.conf
        $ source 2.2.setVsphere.sh -o
        ```

## Uninstall Steps
* CAPI와 Provider들의 CRD 제거 및 바이너리, yaml등의 리소스 삭제
    ```bash
    $ for f in *.conf; do source "$f"; done
    $ bash 3.x.delete{Provider}.sh
    $ bash 4.delete.sh
    ## Provider에 따른 Script File Name List
    ## AWS      : 4.1.deleteAWS.sh
    ## vSphere  : 4.2.deleteVsphere.sh
    ```