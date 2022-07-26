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
|  <img src="https://user-images.githubusercontent.com/59790540/180960369-faa3a331-6ec3-4ed0-a019-19d62f92a992.gif" width="200"> | <img src="https://i.imgur.com/do5Au9S.gif" width="200"> |<img src="https://i.imgur.com/bOzkgSp.gif" width="200"> |




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

## 🌟 트러블 슈팅 
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

### 2. instagram redirect url 설정
- 이전에 Github OAuth를 사용한 경험이 있어 쉽게 연결할 줄 알았으나, 인스타그램은 redirect url이 무조건 https로 설정해야 되었고 이에 OAuth 인증을 허용해도 다시 우리 앱으로 리다이렉트가 되지 않는 문제가 발생

    **해결**
    - Github page를 생성, 해당 페이지의 url을 리다이렉트 url로 설정. 이와 함께 javaScript를 활용하여 Github page에서 다시 어플로 이동하는 로직의 스크립트를 작성.
    - 다만 2차에 걸친 리다이렉트로는 코드 값을 받아올 수 없기 때문에 처음 경로로 받아온 코드 값을 잘라내 다음 리다이렉트 경로에 붙여넣는 로직을 추가함

<br>

### 3. Stub에 대한 필요성 
- 인스타그램 API를 호출하는 과정에서 지정된 호출 횟수이상 호출시, 인스타그램에서 지정해놓은 사용 제한을 초과해 디버깅을 하지 못하는 문제
- API를 요청하지 않아도 미리 지정한 가짜 값을 줄수 Stub이나 Mock의 필요성을 느낌 
- 테스트 코드를 작성하게 된다면 해당 부분도 리팩토링으로 수정을 할 계획

## 4. 회고 및 기타

[프로젝트 노션 📒](https://moored-zircon-1e6.notion.site/Czechgram-7c64ecfeb32a439aaa62d29519555dae)


