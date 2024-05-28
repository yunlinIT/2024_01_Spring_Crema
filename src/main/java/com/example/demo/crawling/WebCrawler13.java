package com.example.demo.crawling;

import java.util.ArrayList;
import java.util.List;

import org.openqa.selenium.By;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;

import com.example.demo.vo.Cafe;

public class WebCrawler13 {

	private static WebDriver driver; // WebDriver 객체 선언
	private static String url; // URL 문자열 변수 선언

	public static String WEB_DRIVER_ID = "webdriver.chrome.driver"; // WebDriver ID 상수 선언
	public static String WEB_DRIVER_PATH = "C:/work/chromedriver.exe"; // WebDriver 경로 상수 선언

	public static List<Cafe> crawlCafes() { // 카페 크롤링 메서드 시작
		System.setProperty(WEB_DRIVER_ID, WEB_DRIVER_PATH); // 시스템 속성 설정

		ChromeOptions options = new ChromeOptions(); // ChromeOptions 객체 생성
		options.setCapability("ignoreProtectedModeSettings", true); // 보호 모드 설정 무시
		driver = new ChromeDriver(options); // ChromeDriver 객체 생성

		url = "https://map.naver.com/v5/"; // URL 설정
		driver.get(url); // WebDriver로 URL에 접속

		try { // 예외 처리 시작
			Thread.sleep(5000); // 5초 대기
		} catch (InterruptedException e) { // InterruptedException 예외 발생 시
			e.printStackTrace(); // 예외 내용 출력
		}

		WebElement inputSearch = driver.findElement(By.className("input_search")); // 검색 창 WebElement 변수 선언
		String inputKey = "대전 서구 카페"; // 검색어 문자열 변수 선언
		inputSearch.sendKeys(inputKey); // 검색 창에 검색어 입력
		inputSearch.sendKeys(Keys.ENTER); // Enter 키 입력

		try { // 예외 처리 시작
			Thread.sleep(3000); // 3초 대기
		} catch (InterruptedException e) { // InterruptedException 예외 발생 시
			e.printStackTrace(); // 예외 내용 출력
		}

		driver.switchTo().frame("searchIframe"); // 검색 결과가 있는 iframe으로 전환 // 데이터가 iframe 안에 있는 경우(HTML 안 HTML) 이동

		List<Cafe> cafes = new ArrayList<>(); // Cafe 객체를 담을 ArrayList 생성

		List<WebElement> elements = driver.findElements(By.className("TYaxT")); // 검색 결과 WebElement 목록 가져오기 // 사이트에서 전체
																				// 매장을 찾은 뒤 코드를 읽는다

		for (WebElement e : elements) { // WebElement 목록을 순회하며
			e.click(); // 각 WebElement를 클릭
			String key = e.getText(); // WebElement의 텍스트를 key 변수에 저장

			try { // 예외 처리 시작
				Thread.sleep(2000); // 2초 대기
			} catch (InterruptedException ex) { // InterruptedException 예외 발생 시
				ex.printStackTrace(); // 예외 내용 출력
			}

			driver.switchTo().parentFrame(); // 부모 iframe으로 전환
			driver.switchTo().frame(driver.findElement(By.id("entryIframe"))); // entryIframe으로 전환

			String address = driver.findElement(By.className("LDgIH")).getText(); // 주소 가져오기

			String phoneNumber; // 전화번호 문자열 변수 선언
			try { // 예외 처리 시작
				phoneNumber = driver.findElement(By.className("xlx7Q")).getText(); // 전화번호 가져오기
			} catch (Exception ex) { // 예외 발생 시
				phoneNumber = null; // 전화번호 없음을 나타내는 null 값으로 초기화
			}

			// 영업시간이 여러개인 경우
			String businessHours; // 영업시간 문자열 변수 선언
			try { // 예외 처리 시작
				WebElement button = driver.findElement(By.className("RMgN0")); // 버튼 WebElement 변수 선언
				button.click(); // 버튼 클릭
				List<WebElement> dayElements = driver.findElements(By.xpath("//span[@class='i8cJw']")); // 요일 WebElement
																										// 목록 가져오기
				List<WebElement> timeElements = driver.findElements(By.xpath("//div[@class='H3ua4']")); // 시간 WebElement
																										// 목록 가져오기
				StringBuilder businessHoursBuilder = new StringBuilder(); // StringBuilder 객체 생성
				for (int j = 0; j < dayElements.size(); j++) { // WebElement 목록을 순회하며
					String day = dayElements.get(j).getText(); // 요일 텍스트 가져오기
					String time = timeElements.get(j).getText(); // 시간 텍스트 가져오기
					String temp = day + " " + time + "; "; // 요일과 시간을 구분자 ';'로 연결하여 temp 문자열에 저장
					businessHoursBuilder.append(temp); // StringBuilder에 temp 문자열 추가
				}
				businessHours = businessHoursBuilder.toString(); // StringBuilder를 문자열로 변환하여 businessHours에 저장
			} catch (Exception ex) { // 예외 발생 시
				businessHours = null; // 영업시간 없음을 나타내는 null 값으로 초기화
			}

			// 메뉴와 가격은 ':', 메뉴 간은 ';'로 구분
			String menuInfo; // 메뉴 정보 문자열 변수 선언 // 메뉴정보를 저장할 문자열
			try { // 예외 처리 시작
				List<WebElement> menuEles = driver.findElements(By.className("VQvNX")); // 메뉴 WebElement 목록 가져오기
				List<WebElement> priceEles = driver.findElements(By.className("gl2cc")); // 가격 WebElement 목록 가져오기
				StringBuilder menuInfoBuilder = new StringBuilder(); // StringBuilder 객체 생성
				for (int i = 0; i < menuEles.size(); i++) { // WebElement 목록을 순회하며
					String temp = menuEles.get(i).getText() + ":" + priceEles.get(i).getText() + ";"; // 메뉴와 가격을 ':'로
																										// 연결하여 temp
																										// 문자열에 저장
					menuInfoBuilder.append(temp); // StringBuilder에 temp 문자열 추가
				}
				menuInfo = menuInfoBuilder.toString(); // StringBuilder를 문자열로 변환하여 menuInfo에 저장
			} catch (Exception ex) { // 예외 발생 시
				menuInfo = null; // 메뉴 정보 없음을 나타내는 null 값으로 초기화
			}

			// 시설정보
			String facilities; // 시설 정보 문자열 변수 선언
			try { // 예외 처리 시작
				WebElement facilitiesElement = driver.findElement(By.className("xPvPE")); // 시설 정보 WebElement 변수 선언
				facilities = facilitiesElement.getText(); // 시설 정보 텍스트 가져오기
			} catch (Exception ex) { // 예외 발생 시
				facilities = null; // 시설 정보 없음을 나타내는 null 값으로 초기화
			}

			Cafe cafe = new Cafe(); // Cafe 객체 생성

			String imageUrl = ""; // 이미지 URL 문자열 변수 선언
			List<WebElement> imageElements = driver.findElements(By.cssSelector("div.K0PDV._div")); // 이미지 WebElement 목록
																									// 가져오기

			for (int i = 0; i < imageElements.size(); i++) { // WebElement 목록을 순회하며
				WebElement imageElement = imageElements.get(i); // 각 WebElement를 가져와서

				String styleAttribute = imageElement.getAttribute("style"); // style 속성 가져오기

				imageUrl = extractImageUrlFromStyleAttribute(styleAttribute); // 스타일 속성에서 이미지 URL 추출하는 메서드 호출

				switch (i) { // i 값에 따라서
				case 0: // 0인 경우
					cafe.setCafeImgUrl1(imageUrl); // Cafe 객체의 첫 번째 이미지 URL 설정
					break; // switch 문 종료
				case 1: // 1인 경우
					cafe.setCafeImgUrl2(imageUrl); // Cafe 객체의 두 번째 이미지 URL 설정
					break; // switch 문 종료
				case 2: // 2인 경우
					cafe.setCafeImgUrl3(imageUrl); // Cafe 객체의 세 번째 이미지 URL 설정
					break; // switch 문 종료
				case 3: // 3인 경우
					cafe.setCafeImgUrl4(imageUrl); // Cafe 객체의 네 번째 이미지 URL 설정
					break; // switch 문 종료
				case 4: // 4인 경우
					cafe.setCafeImgUrl5(imageUrl); // Cafe 객체의 다섯 번째 이미지 URL 설정
					break; // switch 문 종료
				}
				System.out.println("Image URL: " + imageUrl); // 이미지 URL 출력
			}

			cafe.setName(key); // Cafe 객체의 이름 설정
			cafe.setAddress(address); // Cafe 객체의 주소 설정
			cafe.setPhoneNum(phoneNumber); // Cafe 객체의 전화번호 설정
			cafe.setBusinessHours(businessHours); // Cafe 객체의 영업시간 설정
			cafe.setFacilities(facilities); // Cafe 객체의 시설 정보 설정
			cafes.add(cafe); // cafes ArrayList에 Cafe 객체 추가

			// 출력 데이터
			System.out.println("Name: " + key); // 이름 출력
			System.out.println("Address: " + address); // 주소 출력
			System.out.println("Phone Number: " + phoneNumber); // 전화번호 출력
			System.out.println("Business Hours: " + businessHours); // 영업시간 출력
			System.out.println("Menu Info: " + menuInfo); // 메뉴 정보 출력
			System.out.println("Facilities: " + facilities); // 시설 정보 출력

			driver.switchTo().parentFrame(); // 부모 iframe으로 전환
			driver.switchTo().frame("searchIframe"); // searchIframe으로 전환
		}

		return cafes; // cafes ArrayList 반환
	}

	// 스타일 속성에서 이미지 URL을 추출하는 메서드
	private static String extractImageUrlFromStyleAttribute(String styleAttribute) { // 스타일 속성에서 이미지 URL을 추출하는 메서드 시작
		String imageUrl = ""; // 이미지 URL 문자열 변수 선언
		if (styleAttribute != null && styleAttribute.contains("background-image: url(")) { // 스타일 속성이 null이 아니고
																							// 'background-image: url('을
																							// 포함하는 경우
			int startIndex = styleAttribute.indexOf("url(") + 4; // 시작 인덱스 설정
			int endIndex = styleAttribute.indexOf(")", startIndex); // 끝 인덱스 설정
			imageUrl = styleAttribute.substring(startIndex, endIndex).replaceAll("'", "").replaceAll("\"", ""); // 이미지
																												// URL
																												// 추출하여
																												// imageUrl
																												// 변수에
																												// 저장
		}
		return imageUrl; // 이미지 URL 반환
	}
// 크롤링시 주석 해제 후 Run as [Java Application] 
	
//	public static void main(String[] args) {
//		WebCrawler13 crawler = new WebCrawler13();
//		crawler.crawlCafes();
//	}
}
