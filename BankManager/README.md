# 은행 매니저 앱 프로젝트📱

 > 3명의 은행원이 10 ~ 30명의 고객을 우선순위(고객등급)에 따라 업무를 처리해주는 콘솔 앱

## Index
* [프로젝트 규칙](#프로젝트-규칙) 
* [기능](#기능)
* [Trouble Shooting](#trouble-shooting)
* [학습 내용](#학습-내용)


## 프로젝트 

- 👦 👦 팀원 : [글렌](https://github.com/innieminnie), [태태](https://github.com/uuu1101)  

- 📅 기간 : 2021.01.04 ~ 2021.01.17 2주간


## 프로젝트 규칙

#### 1. 팀원

* 글렌
* 태태



#### 2. 우리 팀만의 규칙

- 오전 11시, 회의실 6번에서 스크럼 진행 !

- 언제든지 연락 가능 ! 확인하면 답 해주기 !

- 궁금한 것이 있으면 DM하여 회의실 소환 !



#### 3. 스크럼 주제

- 현재까지 프로젝트 진행 사항 공유

- 컨디션, 쉬는 시간에 뭐 했는지 서로 질문

- 모르는 부분이나 어려운 부분이 있는지 서로 공유



#### 4. 프로젝트 규칙

* 글렌이 Fork를 떠서 각자 브랜치에서 작업 후 Merge 후 PR 보내기 !

  ##### 4-1. 브랜치 이름 규칙

  * 해당 스텝-닉네임 형식으로 브랜치 생성

    ​	Ex) Step1- Glenn , Step1-taetae

  ##### 4-2. 커밋 규칙

  - 한글로 작성 하기 !
  - 함수 단위로 커밋 작성할 수 있게 최대한 노력하기 !

  ##### 4-3. 커밋 메시지 규칙

  * [Karma Style](http://karma-runner.github.io/5.2/dev/git-commit-msg.html) 준수하기

  ##### 4-4. 코딩 컨벤션

  - Swift API 디자인 가이드라인 준수

  - 함수는 동사로, 변수나 상수는 명사로 작성

  - 네이밍에 신경쓰기

## 기능

<img width="250" src="https://user-images.githubusercontent.com/49808034/117962192-ea578e80-b359-11eb-87bc-33537987fa2f.gif">

> 각 고객의 등급과 업무는 랜덤이며, 업무별 소요 시간이 다름

## Trouble Shooting

### - 왜 비동기 프로그래밍이 필요하였나?  
초기 프로젝트는 은행원이 1명이었고, 순차적으로 고객을 응대하면 되었기에 비동기 프로그래밍이 필요하지 않았습니다.  
하지만 은행원이 늘어남에 따라 은행원 수만큼 고객을 응대하여야했기 때문에 비동기 프로그래밍이 필요하게 되었습니다.
- 은행원 1명, 고객 2명 (동기)  
![스크린샷 2021-05-17 오후 11 43 30](https://user-images.githubusercontent.com/49808034/118507950-b02b2a00-b769-11eb-96ee-408eee149194.png)

- 은행원 2명, 고객 4명 (동기)  
![스크린샷 2021-05-17 오후 11 44 16](https://user-images.githubusercontent.com/49808034/118508067-cc2ecb80-b769-11eb-999c-059932d3d2df.png)

- 은행원 2명, 고객 4명 (비동기)  
![스크린샷 2021-05-17 오후 11 44 50](https://user-images.githubusercontent.com/49808034/118508147-dfda3200-b769-11eb-931f-2c5e0f672b71.png)

                
### - DispatchQueue와 OperationQueue 중 DispatchQueue를 사용한 이유?  
비교적 간단한 비동기 작업을 수행한다고 생각하여 DispatchQueue를 사용하였습니다.  
OperationQueue 의 경우에는 동시에 실행되는 Task의 수를 지정하거나 Task의 일시정지, 취소를 할 수 있는 기능이 있습니다.  
하지만 본 프로젝트에서는 OperationQueue의 기능을 사용하는 경우가 없다고 판단하였습니다.

![스크린샷 2021-05-17 오후 3 39 04](https://user-images.githubusercontent.com/49808034/118442786-04acb600-b726-11eb-8b4c-459be019261f.png)

> 참고) [인프런 강의 앨런님](https://www.inflearn.com/course/iOS-Concurrency-GCD-Operation#)

### - DispatchGroup 과 Semaphore 중 DispatchGruop을 사용한 이유?  

### - Thread의 sleep 대신 usleep을 사용했을 때의 이점이 있었나요?

코드 리뷰 중 야곰에게 아래와 같은 질문을 받았습니다.  

<img width="800" src="https://user-images.githubusercontent.com/49808034/118435490-083a4000-b71a-11eb-9c1f-9bae4b720739.png">

Thread.sleep은 Foundation Framework의 메서드(Thread 클래스의 클래스 함수)이고, usleep은 posix standard library의 메서드입니다.  
메인 쓰레드를 멈추게 한다는 기능은 동일하지만 입력 파라미터에 차이가 있습니다. 

```swift

open class func sleep(forTimeInterval ti: TimeInterval)

public func usleep(_: useconds_t) -> Int32

``` 
위와 같이 Thread.sleep은 time interval을 입력 받고, usleep은 useconds_t를 입력으로 받습니다.  
결국 **time interval의 부동소수점으로 인해, 업무 소요시간 구현에 초 단위를 쓸 경우 정확하게 나오지 않아서 useconds_t를 사용**하였습니다.



## 학습 내용
- 비동기 프로그래밍
- Operation
- DispatchQueue
- DispatchGroup, Semaphore
