# 오픈 마켓 앱 프로젝트

 > 오픈마켓의 기능을 구현한 앱 
## Index
* [프로젝트 규칙](#프로젝트-규칙) 
* [기능](#기능)
* [Trouble Shooting](#trouble-shooting)
* [학습 내용](#학습-내용)


## 프로젝트 규칙

- 👧‍👦 팀원 : [이니](https://github.com/innieminnie), [태태](https://github.com/uuu1101)  

- 📅 기간 : 2021.01.18 ~ 2주간  

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
 1. 앱 실행시 전체 상품 목록을 조회
 2. 상단 `UISegmentControl`를 사용, `List`와 `Grid`를 선택하여 `TableView`, `CollectionView` 로 사용자에게 UI 제공
 3. 제품을 탭하면 상세내용을 보여줌
 4. 상품 등록 기능
 5. 상품 등록시 정가와 할인된 가격을 따로 입력받아 UI에 표시

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