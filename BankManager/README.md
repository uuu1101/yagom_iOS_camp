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

- [프로젝트 룰](https://github.com/uuu1101/yagom_iOS_camp/blob/main/BankManager/ProjectRule.md)
## 기능

<img width="250" src="https://user-images.githubusercontent.com/49808034/117962192-ea578e80-b359-11eb-87bc-33537987fa2f.gif">

> 각 고객의 등급과 업무는 랜덤이며, 업무별 소요 시간이 다름

## Trouble Shooting

### 왜 비동기 프로그래밍이 필요하였나?  
초기 프로젝트는 은행원이 1명이었고, 순차적으로 고객을 응대하면 되었기에 비동기 프로그래밍이 필요하지 않았습니다.  
하지만 은행원이 늘어남에 따라 은행원 수만큼 고객을 응대하여야했기 때문에 비동기 프로그래밍이 필요하게 되었습니다.  

### DispatchQueue와 OperationQueue 중 DispatchQueue를 사용한 이유?  
비교적 간단한 비동기 작업을 수행한다고 생각하여 DispatchQueue를 사용하였습니다.  
OperationQueue 의 경우에는 동시에 실행되는 Task의 수를 지정하거나 Task의 일시정지, 취소를 할 수 있는 기능이 있습니다.  
하지만 본 프로젝트에서는 OperationQueue의 기능을 사용하는 경우가 없다고 판단하였습니다.

### DispatchGroup 과 Semaphore 중 DispatchGruop을 사용한 이유?  

### Thread의 sleep 대신 usleep을 사용했을 때의 이점이 있었나요?

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
