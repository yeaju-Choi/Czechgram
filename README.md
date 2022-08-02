# 📷 CzechGram (Instagram Demo)

**인스타그램 API를 활용하여 사용자가 업로드한 사진을 볼 수 있는 iOS APP**
<br>
개발기간 : 2022.07.10 - 07.31 

### 🧑‍💻 팀원

|   <center>iOS </center> |
| ---------- |
| Chez [@asqw887](https://github.com/asqw887)  |
| 푸코 [@wnsxor1993](https://github.com/wnsxor1993) | 

<br>


## 🎯 프로젝트 목표

```
    1. OAuth 개념 학습 및 적용 
    2. MVVM + CleanArchitecture 적용
    3. RxSwift 학습 및 적용
    4. 매일 회고 및 작업 단위 작성 연습
```
<br>

## 📝 기능소개 
|   로그인    |   메인화면   |   미디어 상세화면   |
| :----------: | :--------: | :----------: |
|  <img src="https://user-images.githubusercontent.com/59790540/180960369-faa3a331-6ec3-4ed0-a019-19d62f92a992.gif" width="200"> | <img src="https://i.imgur.com/kKZdIlv.gif" width="200"> |<img src="https://i.imgur.com/bOzkgSp.gif" width="200"> |




## ⚙️ 개발 환경


[![Swift](https://img.shields.io/badge/swift-v5.5-orange?logo=swift)](https://developer.apple.com/kr/swift/)
[![Xcode](https://img.shields.io/badge/xcode-v13.2-blue?logo=xcode)](https://developer.apple.com/kr/xcode/)
<img src="https://img.shields.io/badge/UIkit-000000?style=flat&logo=UIkit" alt="uikit" maxWidth="100%">

<br>

## 🏗 Architecture (MVVM + Clean Architecture) 
### 1) LoginScene 
![](https://i.imgur.com/0YpP9K7.jpg)

### 2) HomeScene
![](https://i.imgur.com/OK9KJEH.jpg)


### 3) DetailScene
![](https://i.imgur.com/Ydp4MZB.jpg)

<br>

## 🌟 고민과 해결

### 1. MVVM - cleanArchitecture 고민
1) Repository의 코드 중복성에 대한 고민
    - HomeScene과 DetailScene에서 사용하는 Repository의 작업 흐름과 이를 작동시키는 로직이 매우 유사하였고, 이를 통합시켜보기 위해 여러 방법을 시도.
    - 하지만 통합시키기 위해서는 결국 각 Scene에 맞춰서 작성한 Repository를 기능 별로 나눠서 추상화를 해야하는 상황이 되면서 어떤 것이 더 옳은 방식일까에 대한 고민이 깊어짐
    - 이와 함께 EndPoint도 주입을 해줘야하면서 로직의 복잡성이 높아질 듯 하여, 일단 수정을 미뤄뒀지만 Scene 별 Repository 형태가 아닌, 기능 별 Repository 형태로 구현하여도 되는 지에 대한 고민만 깊어지고 아직까지 뚜렷한 해결 방법을 찾지 못 한 상태  
    
<br>

2) Rxswift의 필요성 
     - Rxswift를 학습하지 않은 상태에서 적용하기에는 어렵다고 판단이 되어 Observable 객체를 구현하여 바인딩
     - 클린 아키텍처를 적용하다보니 각 역할에 따라 객체가 분리되어 있고, 비동기적으로 데이터를 전달하는 로직이 있기 때문에, 많은 클로저가 연결되는 흐름이 발생.
     - Rxswift에 대해 학습하고 추후에 리팩토링하기로 결정.
     
     ---

### 2. instagram redirect url 설정
- 이전에 Github OAuth를 사용한 경험이 있어 쉽게 연결할 줄 알았으나, 인스타그램은 redirect url이 무조건 https로 설정해야 되었고 이에 OAuth 인증을 허용해도 다시 우리 앱으로 리다이렉트가 되지 않는 문제가 발생

    **해결**
    - Github page를 생성, 해당 페이지의 url을 리다이렉트 url로 설정. 이와 함께 javaScript를 활용하여 Github page에서 다시 어플로 이동하는 로직의 스크립트를 작성.
    - 다만 2차에 걸친 리다이렉트로는 코드 값을 받아올 수 없기 때문에 처음 경로로 받아온 코드 값을 잘라내 다음 리다이렉트 경로에 붙여넣는 로직을 추가함
    ---

<br>

### 3. Stub에 대한 필요성 
- 인스타그램 API를 호출하는 과정에서 지정된 호출 횟수이상 호출시, 인스타그램에서 지정해놓은 사용 제한을 초과해 디버깅을 하지 못하는 문제
- API를 요청하지 않아도 미리 지정한 가짜 값을 줄수 Stub이나 Mock의 필요성을 느낌 
- 테스트 코드를 작성하게 된다면 해당 부분도 리팩토링으로 수정을 할 계획
    - ---


### 4. Rx를 사용할 때, 과연 어느 범위까지 활용을 해야될 지에 대한 고민

- Input/Output은 보통 VC-VM 관계에서 활용되는 듯 보이는데, 그렇다면 VM-Usecase-Repository 관계에서는 어떻게 활용하는가
- 이 부분은 고민 끝에 상위 모듈에서 하위 모듈에게 작업을 시킬 때, 메서드를 호출하고 인자값을 넘겨주는 대신 하위 모듈에서 값을 받아올 때에는 subject 객체로부터 subscribe를 통해 받아오는 형태로 구현
- 여러 Subject나 Traits 등을 비롯하여 operator까지 대체 언제, 어떻게 사용해야 되는 지에 대한 구체적인 설명이 없다보니 동일한 것만 사용하게 되는데 이것이 맞는 건지에 대한 고민이 듬

    - --- 

### 5. NetworkService에서 받아온 데이터가 디코딩까지 넘어가지 않고 바로 종료되는 문제

- 처음에는 Observable 리턴 시에 생기는 문제로 생각하고 subject를 만들어 onNext를 해주도록 흐름을 수정하였지만 문제가 해결되지 않음
- 어떤 문제인지 파악하지 못 해, 다른 사람들의 코드들을 보며 비교를 하던 중 NetworkService를 호출한 뒤 바로 .dispose를 해준 구문이 다른 이들과 다른 점인 것을 확인
- dispose를 호출한 구문을 dispose(by:)로 수정한 뒤, 정상적으로 데이터가 전달되는 것을 확인.
- 결국 disposeBag에 넣어주지 않고 dispose로 바로 해제해주다보니 NetworkService가 데이터를 받아와도 이미 해당 구문에 대하여 구독 해제가 진행되어서 디코딩으로 이어지는 일련의 흐름이 끊겨버린 것.
dispose를 호출하면 해당 시점에서 바로 구독이 해제되는 점과 비동기 작업은 실행 후, 바로 다음 흐름으로 이어지지 않는다는 점을 매칭하지 못 한 실수로 생긴 문제임을 직시함

    --- 


## 4. 회고 및 기타

[프로젝트 노션 📒](https://moored-zircon-1e6.notion.site/Czechgram-7c64ecfeb32a439aaa62d29519555dae)


