
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
<img width="250" src="https://user-images.githubusercontent.com/49808034/117234273-a519f500-ae5f-11eb-966d-4cbd8136d3fa.gif">

 1. 앱 실행시 전체 상품 목록을 조회
 2. 상단 `UISegmentControl`를 사용, `List`와 `Grid`를 선택하여 `TableView`, `CollectionView` 로 사용자에게 UI 제공
 3. 상품의 정가와 할인된 가격을 따로 입력받아 UI에 표시

## 주요 구현 사항 
### 1) 네트워크 통신을 위한 모델 타입 구현

[Model 디렉토리](https://github.com/uuu1101/yagom_iOS_camp/tree/main/OpenMarket/OpenMarket/Model)
| 타입명 | 요약 |
| :-: | :-: |
| Product | 상품정보 |
| ProductList | 페이지에 따른 20개의 Product 리스트 |
| ProductRegistration | 상품 등록 시 필요한 입력 정보 |
 
```swift
struct Product: Codable {
  let id: Int
  let title: String
  let descriptions: String
  let price: Int
  let currency: String
  let stock: Int
  let discountedPrice: Int?
  let thumbnails: [String]
  let images: [Data]
  let registrationDate: Double
  let password: String
  
  private enum CodingKeys: String, CodingKey {
    case id
    case title
    case descriptions
    case price
    case currency
    case stock
    case discountedPrice = "discounted_price"
    case thumbnails
    case images
    case registrationDate = "registration_date"
    case password
  }
}
```
```swift
struct ProductList: Decodable {
  let page: Int
  let items: [Product]
}
```
```swift
struct ProductRegistration: Encodable {
  let title: String
  let descriptions: String
  let price: Int
  let currency: String
  let stock: Int
  let discountedPrice: Int?
  let images: [Data]
  let password: String
  
  var description: [String: Any?] {[
      "title": title,
      "descriptions": descriptions,
      "price": price,
      "currency": currency,
      "stock": stock,
      "discountedPrice": discountedPrice,
      "images": images,
      "password": password
  ]}
}

```
## Trouble Shooting
- 서버와 통신하여 response를 retrun하여도 response가 담기지 않는 문제
  > 해당 문제는 서버와 통신하는 방식이 비동기 방식으로 작동하기 때문에 URLSessionDataTask 부분의 코드가 완료되기 전에 retrun이 됨
```swift
    private func fetchData<T: Decodable>(url: URLRequest) -> T? {
        var convertedData: T? = nil
        URLSessionDataTask.default.dataTask(with: url) { (data, response, error)  in
              convertedData = try? JSONDecoder().decode(T.self, from: data)
         }.resume()
         return convertedData
      }
 ```
 따라서 이 문제를 해결하기 위해 아래와 같이 escaping Clourse를 사용하여 해결하였습니다.
 ```swift
 private func fetchData<T: Decodable>(feature: FeatureList, url: URLRequest, completion: @escaping (Result<T,OpenMarketNetworkError>) -> Void) {
        let dataTask: URLSessionDataTask = session
            .dataTask(with: url) { (data, response, error)  in
            
                switch feature {
                case .listSearch, .productSearch:
                    do {
                        let convertedData = try JSONDecoder().decode(T.self, from: receivedData)
                        completion(.success(convertedData))
                    } catch {
                        completion(.failure(.decodingFailure))
                    }
                case .productRegistration:
                    completion(.success(receivedData as! T))
                case .deleteProduct(let id):
                    break
                case .productModification(let id):
                    break
                }
            }
        dataTask.resume()
    }
```
- 특정기기에서 컬렉션 뷰의 가격을 표시하는 Text가 셀을 벗어나는 문제 [[해당 PR 링크]](https://github.com/yagom-academy/ios-open-market/pull/13#discussion_r570717025)
> 해당 문제는 오토레이아웃 제약조건을 설정하지 않아서 발생하였습니다. 
따라서 문제가 발생한 Label에 제약조건을 추가하여 해결하였습니다.
```swift
//추가한 코드내용   
productPriceLabel.leadingAnchor.constraint(equalTo: productThumbnailImageView.leadingAnchor),
productPriceLabel.trailingAnchor.constraint(equalTo: productThumbnailImageView.trailingAnchor),

productNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
productNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),

productStockLabel.leadingAnchor.constraint(equalTo: productNameLabel.leadingAnchor),
productStockLabel.trailingAnchor.constraint(equalTo: productNameLabel.trailingAnchor),
```

- 테이블뷰에서 상품의 각각 이미지가 크기가 다르게 표시되는 문제 

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
