# 폐쇄망 설치 가이드

## 개요
- 외부 네트워크 통신이 가능한 환경에서 CAPI 사용을 위한 이미지를 다운받는다.
- 폐쇄망 환경의 이미지 레지스트리에 다운 받은 이미지를 업로드한다. 
- CAPI, CAPI-AWS, CAPI-vSphere를 설치한다.  


<hr/>

## Image 다운로드 
- 외부 네트워크 통신이 가능한 환경에서 이미지를 다운로드한다.
    ```bash
    $ cd manifest
    $ chmod +x *.sh
    $ bash 0.image-pull.sh
    ```

- 다운받은 이미지는 `manifest/img` 경로에서 확인할 수 있다. 

- 다운 받은 이미지를 폐쇄망 환경으로 가져와 `manifest/img` 경로에 위치시킨다.
- `registry.conf` 파일에 `REGISTRY 정보`를 기입한다.    
    ```bash
    $ cd manifest
    $ cat registry.conf
      export REGISTRY=172.21.5.30:5000
    ```
- registry에 다운 받은 이미지를 업로드 한다. 
    ```bash
    $ bash 0-1.image-push.sh 
    ```


<hr/>

## Cluster-API 설치
   
```bash
$ cd manifest
$ chmod +x *.sh
$ bash 1-0.setting-offline-capi.sh
$ bash 1-1.install-capi.sh
```
    

<br/>


<hr/>


## CAPI-AWS 설치
### 1. AWS Cloudformation Stack 추가 방법은 [여기](./AWS_CONSOLE.md#aws-cloudformation-stack-추가-방법)를 참고한다. 
### 2. AWS Key pair 생성 방법은 [여기](./AWS_CONSOLE.md#aws-key-pair-생성-방법)를 참고한다. 

### 3. Install Steps

- `manifest/aws-credential.conf` 생성 후, `AWS_ACCESS_KEY`, `AWS_SECRET_ACCESS_KEY`, `AWS_REGION`에 값을 기입한다. 
    ```bash
    $ cd manifest
    $ cp aws-credential.conf.example aws-credential.conf
    $ cat aws-credential.conf
    export AWS_ACCESS_KEY=demo-access-key
    export AWS_SECRET_ACCESS_KEY=demo-secret-key
    export AWS_REGION=ap-northeast-2
    ```


- CAPI-AWS를 설치한다. 
    ```bash
    $ bash 2-0.setting-offline-capa.sh
    $ bash 2-1.install-capa.sh
    ```



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


- CAPI-vShere 설치하기 
    ```bash
    $ bash 3-0.setting-offline-capv.sh
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
