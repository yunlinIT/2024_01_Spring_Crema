package com.example.demo.crawling;
//성공한 로직
import java.util.List;

import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.interactions.Actions;

public class WebCrawler13 {
    
    private WebDriver driver;
    private String url;

    public static String WEB_DRIVER_ID = "webdriver.chrome.driver";
    public static String WEB_DRIVER_PATH = "C:/work/chromedriver.exe";

    public void crawlMap(String location) {
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
        String inputKey = " 서구 카페";
        inputSearch.sendKeys(location + inputKey);
        inputSearch.sendKeys(Keys.ENTER);

        try {
            Thread.sleep(3000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        
        // 데이터가 iframe 안에 있는 경우(HTML 안 HTML) 이동
        driver.switchTo().frame("searchIframe");

//        // 원하는 요소를 찾기(스크롤할 창)
//        WebElement scrollBox = driver.findElement(By.id("_pcmap_list_scroll_container"));
//
//        Actions builder = new Actions(driver);
//
//        for (int i = 0; i < 6; i++) {
//            ((JavascriptExecutor) driver).executeScript("arguments[0].scrollIntoView(true);", scrollBox);
//            try {
//                Thread.sleep(3000);
//            } catch (InterruptedException e) {
//                e.printStackTrace();
//            }
//        }
        

//        // 원하는 요소를 찾기(스크롤할 창)
//        WebElement scrollBox = driver.findElement(By.id("_pcmap_list_scroll_container"));
//
//        Actions builder = new Actions(driver);
//
//     // 10개의 요소를 가져오기 위해 스크롤을 수행합니다.
//     for (int i = 0; i < 15; i++) {
//         // JavaScript를 사용하여 scrollBox 요소가 화면에 보이도록 스크롤합니다.
//         ((JavascriptExecutor) driver).executeScript("arguments[0].scrollIntoView(true);", scrollBox);
//         try {
//             // 스크롤 후 충분한 시간을 기다립니다. 페이지가 로드되고 요소가 나타날 때까지 대기합니다.
//             Thread.sleep(3000);
//         } catch (InterruptedException e) {
//             e.printStackTrace();
//         }
//     }
        
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
            
            
            List<WebElement> imageElements = driver.findElements(By.cssSelector("div.K0PDV._div"));

            for (WebElement imageElement : imageElements) {
                String styleAttribute = imageElement.getAttribute("style");
                // 스타일 속성에서 URL 추출
                String imageUrl = extractImageUrlFromStyleAttribute(styleAttribute);
                System.out.println("Image URL: " + imageUrl);
            }



            // Output data
            System.out.println("Name: " + key);
            System.out.println("Address: " + address);
            System.out.println("Phone Number: " + phoneNumber);
            System.out.println("Business Hours: " + businessHours);
            System.out.println("Menu Info: " + menuInfo);
            System.out.println("Facilities: " + facilities);

            driver.switchTo().parentFrame();
            driver.switchTo().frame("searchIframe");
        }

//        driver.quit();
    }
    // 스타일 속성에서 이미지 URL 추출하는 메서드
    private String extractImageUrlFromStyleAttribute(String styleAttribute) {
    	String imageUrl = "";
        if (styleAttribute != null && styleAttribute.contains("background-image: url(")) {
            int startIndex = styleAttribute.indexOf("url(") + 4;
            int endIndex = styleAttribute.indexOf(")", startIndex);
            imageUrl = styleAttribute.substring(startIndex, endIndex).replaceAll("'", "").replaceAll("\"", "");
        }
        return imageUrl;
	}

	public static void main(String[] args) {
        WebCrawler13 crawler = new WebCrawler13();
        crawler.crawlMap("대전");
    }
}
