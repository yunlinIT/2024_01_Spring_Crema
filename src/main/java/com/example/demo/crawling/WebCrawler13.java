package com.example.demo.crawling;

import java.util.ArrayList;
//성공한 로직
import java.util.List;

import org.openqa.selenium.By;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;

import com.example.demo.vo.Cafe;

public class WebCrawler13 {

	private static WebDriver driver;
	private static String url;

	public static String WEB_DRIVER_ID = "webdriver.chrome.driver";
	public static String WEB_DRIVER_PATH = "C:/work/chromedriver.exe";

	public static List<Cafe> crawlCafes() {
		System.setProperty(WEB_DRIVER_ID, WEB_DRIVER_PATH);

		ChromeOptions options = new ChromeOptions();
		options.setCapability("ignoreProtectedModeSettings", true);
		driver = new ChromeDriver(options);

		url = "https://map.naver.com/v5/";
		driver.get(url);

		try {
			Thread.sleep(5000);
		} catch (InterruptedException e) {
			e.printStackTrace();
		}

		// 네이버 지도 검색창에 원하는 검색어 입력 후 엔터
		WebElement inputSearch = driver.findElement(By.className("input_search"));
		String inputKey = "대전 서구 카페";
		inputSearch.sendKeys(inputKey);
		inputSearch.sendKeys(Keys.ENTER);

		try {
			Thread.sleep(3000);
		} catch (InterruptedException e) {
			e.printStackTrace();
		}

		// 데이터가 iframe 안에 있는 경우(HTML 안 HTML) 이동
		driver.switchTo().frame("searchIframe");

		List<Cafe> cafes = new ArrayList<>();

		// 사이트에서 전체 매장을 찾은 뒤 코드를 읽는다
		List<WebElement> elements = driver.findElements(By.className("TYaxT"));

		for (WebElement e : elements) {
			e.click();
			String key = e.getText();

			try {
				Thread.sleep(2000);
			} catch (InterruptedException ex) {
				ex.printStackTrace();
			}

			// 부모 iframe으로 전환
			driver.switchTo().parentFrame();

			// entryIframe으로 전환
			driver.switchTo().frame(driver.findElement(By.id("entryIframe")));

			// 주소
			String address = driver.findElement(By.className("LDgIH")).getText();

			// 전화번호 있는 경우
			String phoneNumber;
			try {
				phoneNumber = driver.findElement(By.className("xlx7Q")).getText();
			} catch (Exception ex) {
				phoneNumber = null;
			}

			// 영업시간이 여러개인 경우
			String businessHours;
			try {
				WebElement button = driver.findElement(By.className("RMgN0"));
				button.click();
				List<WebElement> dayElements = driver.findElements(By.xpath("//span[@class='i8cJw']"));
				List<WebElement> timeElements = driver.findElements(By.xpath("//div[@class='H3ua4']"));
				StringBuilder businessHoursBuilder = new StringBuilder();
				for (int j = 0; j < dayElements.size(); j++) {
					String day = dayElements.get(j).getText();
					String time = timeElements.get(j).getText();
					String temp = day + " " + time + "; ";
					businessHoursBuilder.append(temp);
				}
				businessHours = businessHoursBuilder.toString();
			} catch (Exception ex) {
				businessHours = null;
			}

			// 메뉴정보를 저장할 문자열
			// 메뉴와 가격은 ':', 메뉴 간은 ';'로 구분
			String menuInfo;
			try {
				List<WebElement> menuEles = driver.findElements(By.className("VQvNX"));
				List<WebElement> priceEles = driver.findElements(By.className("gl2cc"));
				StringBuilder menuInfoBuilder = new StringBuilder();
				for (int i = 0; i < menuEles.size(); i++) {
					String temp = menuEles.get(i).getText() + ":" + priceEles.get(i).getText() + ";";
					menuInfoBuilder.append(temp);
				}
				menuInfo = menuInfoBuilder.toString();
			} catch (Exception ex) {
				menuInfo = null;
			}

			// 시설정보
			String facilities;
			try {
				WebElement facilitiesElement = driver.findElement(By.className("xPvPE"));
				facilities = facilitiesElement.getText();
			} catch (Exception ex) {
				facilities = null;
			}

//            List<String> imageUrls = new ArrayList<>();
//            List<WebElement> imageElements = driver.findElements(By.cssSelector("div.K0PDV._div"));
//
//            for (WebElement imageElement : imageElements) {
//                String styleAttribute = imageElement.getAttribute("style");
//                // 스타일 속성에서 URL 추출
//                String imageUrl = extractImageUrlFromStyleAttribute(styleAttribute);
//                imageUrls.add(imageUrl); // 이미지 URL을 리스트에 추가
//            }

//            String imageUrl = "";
//            List<WebElement> imageElements = driver.findElements(By.cssSelector("div.K0PDV._div"));
//            for (WebElement imageElement : imageElements) {
//                String styleAttribute = imageElement.getAttribute("style");
//                // 스타일 속성에서 URL 추출
//                imageUrl = extractImageUrlFromStyleAttribute(styleAttribute);
//                System.out.println("Image URL: " + imageUrl);
//            }
			Cafe cafe = new Cafe();

			String imageUrl = "";
			List<WebElement> imageElements = driver.findElements(By.cssSelector("div.K0PDV._div"));
//            List<String> imageUrls = new ArrayList<>();
			for (int i = 0; i < imageElements.size(); i++) {
				WebElement imageElement = imageElements.get(i);

				String styleAttribute = imageElement.getAttribute("style");

				// 스타일 속성에서 URL 추출
				imageUrl = extractImageUrlFromStyleAttribute(styleAttribute);

//                imageUrls.add(i, imageUrl);

				switch (i) {
				case 0:
					cafe.setCafeImgUrl1(imageUrl);
					break;
				case 1:
					cafe.setCafeImgUrl2(imageUrl);
					break;
				case 2:
					cafe.setCafeImgUrl3(imageUrl);
					break;
				case 3:
					cafe.setCafeImgUrl4(imageUrl);
					break;
				case 4:
					cafe.setCafeImgUrl5(imageUrl);
					break;

				}
	            System.out.println("Image URL: " + imageUrl);
			}

			cafe.setName(key);
			cafe.setAddress(address);
			cafe.setPhoneNum(phoneNumber);
			cafe.setBusinessHours(businessHours);
			cafe.setFacilities(facilities);
//			cafe.setCafeImgUrl1(imageUrls.get(0)); // Cafe 객체에 이미지 URL 리스트 설정
//			cafe.setCafeImgUrl2(imageUrls.get(1));
//			cafe.setCafeImgUrl3(imageUrls.get(2));
//			cafe.setCafeImgUrl4(imageUrls.get(3));
//			cafe.setCafeImgUrl5(imageUrls.get(4));
			cafes.add(cafe);

			// Output data
			System.out.println("Name: " + key);
			System.out.println("Address: " + address);
			System.out.println("Phone Number: " + phoneNumber);
			System.out.println("Business Hours: " + businessHours);
			System.out.println("Menu Info: " + menuInfo);
			System.out.println("Facilities: " + facilities);
//            System.out.println("Image URL: " + imageUrls);
//            System.out.println("Image URL: " + imageUrls);

			driver.switchTo().parentFrame();
			driver.switchTo().frame("searchIframe");
		}

//        driver.quit();

		return cafes;
	}

	// 스타일 속성에서 이미지 URL 추출하는 메서드
	private static String extractImageUrlFromStyleAttribute(String styleAttribute) {
		String imageUrl = "";
		if (styleAttribute != null && styleAttribute.contains("background-image: url(")) {
			int startIndex = styleAttribute.indexOf("url(") + 4;
			int endIndex = styleAttribute.indexOf(")", startIndex);
			imageUrl = styleAttribute.substring(startIndex, endIndex).replaceAll("'", "").replaceAll("\"", "");
		}
		return imageUrl;
	}

//	public static void main(String[] args) {
//        WebCrawler13 crawler = new WebCrawler13();
//        crawler.crawlCafes();
//    }
}