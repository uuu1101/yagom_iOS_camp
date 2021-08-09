
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

- 상품등록 (requestRegistration) 에 대한 POST 요청시, 단순히 HTTP Method를 POST로 설정한 후, 데이터를 전송할 경우 Content-Type 불일치 관련 에러가 발생하는 문제

  > 서버 API에 따르면,<br> 전송하는 문서의 Content-Type (리소스의 media type 나타내는 부분) 은 multipart/form-data 이어야합니다. [(참조: MDN HTTP Header 관련 문서)](https://developer.mozilla.org/ko/docs/Web/HTTP/Headers/Content-Type)
  또한 multipart/form-data 타입의 문서를 POST 요청하는 Request Message 작성 시, 아래와 같은 메시지를 만들어서 요청해야합니다.  
  <img src="https://user-images.githubusercontent.com/49808034/124079183-ca079e80-da83-11eb-9b75-131db107a34a.png" alt="drawing" width="550"/>

  따라서 이 문제를 해결하기 위해, requestRegistration 메소드 내에 
  ```swift
    let boundary = "Boundary-\(UUID().uuidString)"
    urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
    let mimeType = "image/jpg"
    let params = product.description 
    urlRequest.httpBody = createBody(boundary: boundary, mimeType: mimeType, params: params, imageArray: product.images)
  ```
  > 요청메시지의 body 부분에 포함되어야하는 요소 (boundary, mimeType,전송데이터(product.description)) 등을 설정하여 createBody를 통해 urlRequest.httpBody를 생성하였습니다.

  ```swift
   private func createBody(boundary: String, mimeType: String, params: [String : Any?], imageArray: [Data]) -> Data {
        var body = Data()
        let boundaryPrefix = "--\(boundary)\r\n"
        
        for (key,value) in params {
            if let convertedValue = value {
                body.append(string: boundaryPrefix, encoding: .utf8)
                body.append(string: "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n", encoding: .utf8)
                body.append(string: "\(convertedValue)\r\n", encoding: .utf8)
            }
        }
        
        for (index,data) in imageArray.enumerated() {
            body.append(string: boundaryPrefix, encoding: .utf8)
            body.append(string: "Content-Disposition: form-data; name=\"images\"; filename=\"image\"\(index)\"\r\n", encoding: .utf8)
            body.append(string: "Content-Type: \(mimeType)\r\n\r\n", encoding: .utf8)
            body.append(data)
            body.append(string: "\r\n", encoding: .utf8)
        }
        body.append(string: "--".appending(boundary.appending("--")), encoding: .utf8)
        
        return body
    }
  ```
---

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
 > 따라서 이 문제를 해결하기 위해 아래와 같이 escaping Clourse를 사용하여 해결하였습니다.
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
---
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
---
- 테이블뷰에서 상품의 각각 이미지가 크기가 다르게 표시되는 문제  

|변경 전|변경 후|
|------|---|
|![2021-07-01_4 07 59](https://user-images.githubusercontent.com/49808034/124081506-9a0dca80-da86-11eb-843f-4c4b70bf268f.png)|![2021-07-01_4 10 48](https://user-images.githubusercontent.com/49808034/124082326-8dd63d00-da87-11eb-8c7b-b8c40cfe45e0.png)|

 ```swift
    private func setUpConstraints() {
        self.contentView.addSubview(productNameLabel)
        self.contentView.addSubview(productPriceLabel)
        self.contentView.addSubview(productDiscountedPriceLabel)
        self.contentView.addSubview(productStockLabel)
        
        NSLayoutConstraint.activate([
            productThumbnailImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            productThumbnailImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            productThumbnailImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            productNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            productNameLabel.leadingAnchor.constraint(equalTo: productThumbnailImageView.trailingAnchor, constant: 10),
            
            productPriceLabel.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor, constant: 5),
            productPriceLabel.leadingAnchor.constraint(equalTo: productThumbnailImageView.trailingAnchor, constant: 5),
            productPriceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
        
            productDiscountedPriceLabel.topAnchor.constraint(equalTo: productPriceLabel.topAnchor),
            productDiscountedPriceLabel.leadingAnchor.constraint(equalTo: productPriceLabel.trailingAnchor, constant: 5),
            productDiscountedPriceLabel.bottomAnchor.constraint(equalTo: productPriceLabel.bottomAnchor),
            
            productStockLabel.topAnchor.constraint(equalTo: productNameLabel.topAnchor),
            productStockLabel.leadingAnchor.constraint(equalTo: productNameLabel.trailingAnchor, constant: 5),
            productStockLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
        ])
    } 
```
> 위 코드에서 `productThumbnailImageView`의 width에 대한 제약이 없어서 `productThumbnailImageView`의 너비가 이미지에 따라서 변경되는 현상 발생
이러한 문제를 해결하기 위해서 아래와 같이 `widthAnchor`에 대한 제약을 추가하였습니다.
```swift
        NSLayoutConstraint.activate([
            productThumbnailImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            productThumbnailImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            productThumbnailImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.2),
            productThumbnailImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
 ```
 ---
- 테이블뷰 화면에서 스크롤을 하게 되면 상품가격 Label의 글자 색상과 취소선이 제멋대로 표시되는 현상 발생  


|변경 전|변경 후|
|------|---|
|<img width="250" src="https://user-images.githubusercontent.com/49808034/124344762-54303e00-dc0f-11eb-85a7-2172cac5cf0f.gif">!|<img width="250" src="https://user-images.githubusercontent.com/49808034/124345073-6a3efe00-dc11-11eb-9557-8db58083f28f.gif">!|  

이러한 현상은 셀이 컨테이너 벨트처럼 돌아가면서 재사용하기 때문에 나타나게 됩니다.

```swift
  override func prepareForReuse() {
        productThumbnailImageView.image = nil
        productStockLabel.textColor = .gray
        productPriceLael.text = nil
    }
``` 

위와 같이 `prepareForReuse()` 메서드를 사용하여 셀이 재사용 될 때 내용들을 초기화를 하여 해결하였습니다.

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
