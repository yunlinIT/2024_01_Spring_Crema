## ☕ Crema : 날씨 기반 대전 카페 추천 및 테마별 카페검색 플랫폼
___

![](https://velog.velcdn.com/images/yunlinit/post/eb0b28e7-8bf8-42a0-b6a5-14ec0ecf4105/image.png)


# 📌 프로젝트 소개
___
* Crema는 카페를 좋아하는 사람들을 위해 대전 내 카페들을 지역 / 분위기 / 시설 별 키워드와 함께 업체 상세정보를 제공합니다. 
* 또한 날씨에 따라 그날의 날씨에 방문하기 좋은 분위기의 카페를 추천검색어를 통해 표시해주고 추천해줍니다. 
* 사용자는 원하는 분위기의 카페를 검색창 또는 필터를 통해 검색하여 카페 상세정보 및 카페와의 거리를 제공 받을 수 있습니다.

### 주제 선정 동기
* 저는 커피를 좋아하고 예쁜 카페 방문하는 것을 좋아합니다. 그러나 제가 방문 하고 싶은 분위기나 시설의 카페를 찾고싶을 때마다 포털 사이트의 지도에서 지역별로 검색된 카페들을 일일히 들어가서 분위기를 사진으로 봐야하고 시설이 어떤지 봐야하는 번거로움이 있었고 '원하는 분위기나 시설의 카페를 보다 쉽게 찾을 수 있는 방법이 없을까'라는 생각에 제가 직접 만들어보기로 했습니다.


# 📅 개발 기간
___
- 2024.02.14 ~ 2024.04.16


# 👥 팀원 & 담당파트
___


|**장윤린** - 전체(개인프로젝트)|
|:---:|
|<img src="https://velog.velcdn.com/images/yunlinit/post/50a14c38-d5e7-4e5e-9e5f-aeca410a3e40/image.jpg" width="250" height="auto"/>|
|✉ yunlinit@gmail.com|


<img src="https://velog.velcdn.com/images/yunlinit/post/a110e449-007d-4bf9-ac09-e0d6340d4bf0/image.jpg" width="700px;" height="100%"/>



# 🛠 사용기술 및 개발환경
___
- **언어**
  - Java, Python
- **Front-end**
  - HTML, CSS, JavaScript, jQuery, Tailwind, daisyUI
  - API: Open Weather API
- **Back-end**
  - 프레임워크 : SpringBoot, Selenium
  - 라이브러리 : Lombok, Tomcat
  - 템플릿 엔진 : JSP
  - ORM : MyBatis
- **DB**
  - MySQL
  - 쿼리 브라우저 : SQLyog
- **버전 관리**
  - Git, GitHub
- **디자인**
  - Figma
- **자료 관리 툴**
  - Google Form, Google Sheets
- **개발 환경**
  - JDK, MAVEN, Spring Tool Suit 4, Window 10
  - 웹-프레임워크: 구글 앱 스크립트
---
# 🖇ERD 구조
![](https://velog.velcdn.com/images/yunlinit/post/6c23eb32-c6af-4d26-942b-2f12f56f0cee/image.jpg)

# ⚙ 기능
---
- 회원가입, 로그인/로그아웃, 개인정보 수정, 탈퇴
- 검색창 검색, 추천 검색어 추천, 검색필터
- 카페 목록, 상세페이지, 카페 찜/해제 기능, 후기댓글 비동기 처리
- 커뮤니티 게시판 CRUD, 게시글 좋아요/싫어요, 댓글 비동기 처리
- 이메일 발송 


# 💡 페이지별 기능 설명
#### [메인화면]
![](https://velog.velcdn.com/images/yunlinit/post/eb0b28e7-8bf8-42a0-b6a5-14ec0ecf4105/image.png)
- 메인페이지에는 3개의 섹션으로 나눠져있으며 스크롤을 내려서 메인페이지에 있는 기능을 사용 할 수 있습니다.
- 첫번째 섹션은, 시작화면으로 로고와 프로젝트테마에 배경화면을 보여주는 페이지 입니다.

![](https://velog.velcdn.com/images/yunlinit/post/c422e89e-e3ac-4420-be6b-10ce3169d2ac/image.png)
- 두번째 섹션은, Crema의 핵심 기능중 하나인 날씨에 따라 카페의 분위기를 추천검색어로 추천해주는 페이지입니다. 또한, 검색창에서 원하는 분위기를 검색할 수도 있습니다.

![](https://velog.velcdn.com/images/yunlinit/post/4faba7fd-7c72-4d57-9969-0b81647cdb11/image.png)
- 세번째 섹션은, 신규 카페(신규 등록), 인기 카페(찜 수가 높은 카페), 추천카페(랜덤)를 보여줍니다. 

![](/)
- Crema 프로젝트를 만든 본인의 정보와 contact 할 수단을 작성해놓은 섹션입니다.

### [회원가입]
![](https://velog.velcdn.com/images/yunlinit/post/358ec3f0-86dc-41d3-9d52-1f080a661ff2/image.png)
- 기본 정보 입력 후 회원가입을 합니다.

### [로그인 페이지]
![](https://velog.velcdn.com/images/yunlinit/post/f8511067-ebca-41c9-94b6-c1d1f2980977/image.png)
- 아이디와 비밀번호로 로그인을 합니다.

### [회원 마이페이지]
![](https://velog.velcdn.com/images/yunlinit/post/a851b9ac-7a6a-4dcb-a132-32753ff7fc7d/image.png)
- 회원 마이페이지에서 나의 회원정보로 들어갈 수 있으며, 나의 게시물 / 댓글 / 질문 / 찜 목록의 수를 확인 할 수 있습니다.

### [회원정보 수정]
![](https://velog.velcdn.com/images/yunlinit/post/5b57e17d-3f08-42ea-bd76-6c57ba96bafe/image.png)

![](https://velog.velcdn.com/images/yunlinit/post/f1a6bdd9-4e63-4d78-9ced-d310a2ae27aa/image.png)

![](https://velog.velcdn.com/images/yunlinit/post/d3d60617-5e74-44f9-b8d7-80c296024941/image.png)

- 회원정보 수정 페이지에서 개인정보 수정 및 회원 탈퇴 할 수 있으며, 회원정보 수정페이지로 진입 하기 전 비밀번호를 재확인합니다.

### [카페 찾기 페이지]
![](https://velog.velcdn.com/images/yunlinit/post/40e38468-defc-49d7-81f0-e7f087e28268/image.png)
- 처음 접속 시 카페 전체보기를 할 수 있습니다.
- 좌측 필터버튼으로 키워드에 해당하는 카페만 필터링하여 볼 수 있습니다.
- 좌측 검색창으로 직접 입력하여 카페를 검색 할 수 있습니다.

### [카페 상세보기 페이지]
![](https://velog.velcdn.com/images/yunlinit/post/85831f6e-ca5f-4c1d-914d-e1ab19bb044d/image.png)
- 클릭한 카페의 사진과 기본정보(주소, 전화번호, 영업시간, 시설)를 확인 할 수 있습니다.
- 사용자 위치기반 카페와의 거리를 표시해주며 지도로 위치를 알려줍니다.
- 찜 버튼으로 찜 목록 추가 및 해제 할 수 있습니다. 

### [카페 상세사진 슬라이드]
![](https://velog.velcdn.com/images/yunlinit/post/0aa347a2-e54b-4dc9-b007-afa61dd591c9/image.png)
- 카페 상세페이지에서 사진을 클릭하면 각각의 사진을 슬라이드 형태로 볼 수 있습니다.

### [카페 상세페이지 - 리뷰 작성 ]
![](https://velog.velcdn.com/images/yunlinit/post/28f3b9c8-e359-4d76-8cc3-006838a2234c/image.png)
- 카페 상세페이지에서 해당 카페에 대한 리뷰를 조회 및 작성 할 수 있습니다.

### [나의 찜 목록 페이지]
![](https://velog.velcdn.com/images/yunlinit/post/db8cac2b-88d9-4f02-8cc0-4b7ad420bea0/image.png)
- 내가 찜한 카페를 해당 페이지에서 모아보기 할 수 있습니다.

### [헤더 - 커뮤니티]
![](https://velog.velcdn.com/images/yunlinit/post/97f16e7f-5999-4560-8a0b-18ff73027b1c/image.png)
- 헤더에서 커뮤니티 메뉴아이템에 마우스를 올리면, 크레마소식, 자유게시판, 질문게시판, 제휴문의 게시판의 메뉴아이템이 나타납니다.

### [커뮤니티 게시판 - 게시글 목록]
![](https://velog.velcdn.com/images/yunlinit/post/3eb81315-9e26-44f6-a11c-4bb7df07f416/image.png)
- 각각의 게시판에서 작성 된 게시글의 목록을 조회할 수 있습니다.

### [커뮤니티 게시판 - 게시글 작성]
![](https://velog.velcdn.com/images/yunlinit/post/60bfe021-e982-4b2a-ba2b-43f90ba8b748/image.png)
- 회원은 자유게시판과 질문게시판에서 게시글을 작성 할 수 있으며, 관리자는 공지사항 게시판 포함 모든 게시판에서 게시글 작성이 가능합니다.

### [커뮤니티 게시판 - 게시글 상세보기]
![](https://velog.velcdn.com/images/yunlinit/post/6cd71ad3-8a08-4985-83ec-8d3c69c17032/image.png)
- 회원은 제휴문의를 제외한 게시판의 모든 게시글을 상세보기 할 수 있습니다.

### [커뮤니티 게시판 - 게시글 상세보기]
![](https://velog.velcdn.com/images/yunlinit/post/626b5f23-ec4e-4997-97a4-6df797e09700/image.png)
- 회원은 자신이 쓴 게시글을 수정 할 수 있습니다.

### [제휴 문의하기]
![](https://velog.velcdn.com/images/yunlinit/post/b4c9f0c2-c7c7-453c-9911-3a1e0be882bf/image.png)
- 누구나 관리자에게 이메일을 보낼 수 있습니다. 

### [제휴 문의하기 - 이메일 전송]
![](https://velog.velcdn.com/images/yunlinit/post/bb1473f7-4498-479b-89ca-6adffddebc19/image.png)
- 이메일이 성공적으로 전송 시 alert창을 띄워주고 제휴문의 페이지는 새로고침됩니다.

# ☕날씨 별 추천 카페의 분위기 선정 배경
날씨 별 카페 추천은 설문조사를 통해 150여명의 설문조사 참여자들이 특정 날씨에 방문하고싶은 카페의 분위기를 선정하였고, 그 결과를 바탕으로 데이터를 분석하여 추천 카페 부위기를 선정 하였습니다. 

설문조사: 날씨에 따라 가장 방문하고 싶은 카페의 분위기를 선택해주세요☕
총 8개의 문항을 만들었습니다. 
![](https://velog.velcdn.com/images/yunlinit/post/e230e510-8027-4bb6-9edb-162c22196e92/image.png)

![](https://velog.velcdn.com/images/yunlinit/post/f1d01ee7-2765-4ab3-ba7c-aafc71b12ddb/image.png)

### 설문조사 결과 데이터 분석 보기
- https://docs.google.com/spreadsheets/d/e/2PACX-1vSKBpljECX8WAcu_u5U_xLf4A1bVL6YdIdILtEkGcCHFNuKRI0N6dE1jFXog6rPCCgWFzo3_ME2ofPN/pubhtml?gid=0&single=true

미리보기
![](https://velog.velcdn.com/images/yunlinit/post/d3c9f9e1-b0fd-4c7b-ad87-c0366e62b87d/image.png)


# 📑 Crema 환경설정 가이드 북

### I. 프로젝트 실행에 필요한 프로그램  
[STS4](https://cdn.spring.io/spring-tools/release/STS4/4.22.0.RELEASE/dist/e4.31/spring-tool-suite-4-4.22.0.RELEASE-e4.31.0-win32.win32.x86_64.self-extracting.jar)  
[Xampp](https://www.apachefriends.org/)  
[SQLyog](https://s3.amazonaws.com/SQLyog_Community/SQLyog+13.2.1/SQLyog-13.2.1-0.x64Community.exe)  
 

### 2. DB(DataBase) 세팅  
1. SpringCrema 파일 내부의 DB.sql 파일을 메모장으로 실행 후 텍스트 전체 복사(ctrl+A)해주세요.  
![](https://velog.velcdn.com/images/yunlinit/post/d5a321db-4ad4-4276-9aaf-60a1ba6a412a/image.PNG)  
2. 텍스트 붙여넣기 후 전체 쿼리 실행(F9)해주세요.  
![](https://velog.velcdn.com/images/yunlinit/post/d59527e8-b0ef-47a8-9e13-dca1a9a4e7d7/image.PNG)  

### 3. API KEY 세팅  
 ![](https://velog.velcdn.com/images/yunlinit/post/c0a64302-5b90-40b1-b085-bfeef470ba70/image.PNG)
 
1. OpenWeather(OpenWeatherMap)에 접속하여 API KEY를 발급받습니다.
https://openweathermap.org/  

 - main.jsp 내 fetchWeather() 자바스크립트 함수안에 발급 받은 API KEY를 세팅합니다.
 ```javascript
  var apiKey = "API key"; 
 ```

### 4. ChromeDriver 설치 및 크롤링 작업  
 - Crema 프로젝트는 DB에 테스트 데이터를 미리 세팅해놨으므로 크롤링 작업은 필수가 아니지만, 추가적으로 더 많은 카페 데이터를 사용하려면 크롤링을 추가로 진행해야 합니다. (크롤링 방법은 6번부터 참고하세요.)  

#### ChromeDriver 115 버전 이후 드라이버 다운로드  
1. ChromeDriver - WebDriver for Chrome 접속  
[크롬 드라이버 다운로드](https://chromedriver.chromium.org/downloads)  


2. 노란색 형광펜으로 표시된 부분을 클릭해 들어갑니다.  
![](https://velog.velcdn.com/images/insamju300/post/fc2277ee-a1f6-46be-aa3b-af2f0a759e6e/image.png)  

3. table한 버전들이 나오는데 chromedriver 중 각자 OS에 맞는 버전의 URL을 복사해 주소창에 입력하면 웹 드라이버가 다운로드됩니다.![](https://velog.velcdn.com/images/insamju300/post/6e06fe03-83a5-4685-bf1e-c972e09e2dc9/image.png)  

4. 다운로드된 zip 파일의 압축을 해제합니다.  
![](https://velog.velcdn.com/images/insamju300/post/8bda1637-26e4-47ba-820e-a4b1434fce6d/image.png)  

5. chromedriver.exe(응용프로그램)을 현재 사용하고 있는 디렉토리에 추가해 주세요.  
- 프로젝트를 구동 하기 위해선 c://work에 추가해주시면 됩니다.  
![](https://velog.velcdn.com/images/insamju300/post/10483837-46e8-4e47-b3da-1673c42a8615/image.png)  


#### STS4에서 크롤링 작업  
6. 기본값으로 24개의 카페만 DB에 세팅되어있습니다. 크롤링을 추가적으로 진행하시면 중복되는 카페를 제외하고 크롤링이 되어 DB에 저장됩니다. 

![](https://velog.velcdn.com/images/yunlinit/post/9aa7d73e-d277-4475-a9b2-ae06ea98a2e7/image.PNG)  

7. 크롤링 진행을 위해서, com.example.demo.crawling 패키지에서 WebCrawler13.java를 Run As Java Application으로 실행합니다.   



