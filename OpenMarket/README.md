
# 오픈 마켓 앱 프로젝트📱

 > 오픈마켓의 기능을 구현한 앱 
## Index
* [프로젝트 규칙](#프로젝트-규칙) 
* [기능](#기능)
* [Trouble Shooting](#trouble-shooting)
* [학습 내용](#학습-내용)


## 프로젝트 규칙

- 👧‍👦 팀원 : [이니](https://github.com/innieminnie), [태태](https://github.com/uuu1101)  

- 📅 기간 : 2021.01.25 ~ 2021.02.05 2주간

- 스크럼 : 월,화,목,금 오전 10시 30분 디스코드 회의실
    > 오늘 나의 컨디션 상태, 일상 이야기, 어제한 일, 오늘 해야할 일,겪고있는 문제점에 대하여 이야기 


- 🪃 Git branch 규칙: 각 스텝 브랜치에 merge, 개인브랜치에 작업 후 메인되는 브랜치에 Pull Request
    > ex) step1(메인브랜치), step1-taetae(개인브랜치)

-  📐 Git Commit 컨벤션
Git Karma 
    > ex)feat: commit Messsage 
```bash
# Git Karma Type 예시 
add: 파일 추가  
remove: 삭제  
feat: 새로운 기능 구현  
test: 테스트 구현  
style: 기능이나 로직 변경 없이, 오탈자 등 변경  
refactor: 변수 이름을 바꾸거나, 코드 수정  
fix: bug 수정  
docs: 문서파일 추가 및 수정  
chore: 기타업무  
```

## 기능

![OpenMarket](https://user-images.githubusercontent.com/49808034/117233226-aa764000-ae5d-11eb-9168-06a8e499a4d7.gif)
 1. 앱 실행시 전체 상품 목록을 조회
 2. 상단 `UISegmentControl`를 사용, `List`와 `Grid`를 선택하여 `TableView`, `CollectionView` 로 사용자에게 UI 제공
 3. 상품의 정가와 할인된 가격을 따로 입력받아 UI에 표시

## Trouble Shooting

## 학습 내용

- TableView
- CollectionView
- DispatchQueue
- UICollectionViewDelegateFlowLayout
- HTTP Method
- JSON, multipart/form-data
- URLRequest
- URLSession
- Mock Data
