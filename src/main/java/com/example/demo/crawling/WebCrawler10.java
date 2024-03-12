package com.example.demo.crawling;

import java.time.Duration;
import java.util.ArrayList;
import java.util.List;
import java.util.NoSuchElementException;
import java.util.concurrent.TimeUnit;

import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.interactions.Actions;
import org.openqa.selenium.support.ui.FluentWait;
import org.openqa.selenium.support.ui.Wait;

import com.google.common.collect.ImmutableMap;

public class WebCrawler10 {
	// 이미지 크롤링을 못하고있는 로직. 카페 데이터만 잘 가지고 옴. 이미지 크롤링 로직 실행 안됨?
	// 카페메뉴중에 링크화 되어있는 메뉴는 가져 오지 못해서 링크를 클릭한 후 클래스 선택하라고 했지만 안됨.

    private WebDriver driver;
    private String url;

    public static String WEB_DRIVER_ID = "webdriver.chrome.driver";
    public static String WEB_DRIVER_PATH = "C:/work/chromedriver.exe";

    @SuppressWarnings("deprecation")
	public void crawlMap(String location) {
        System.setProperty(WEB_DRIVER_ID, WEB_DRIVER_PATH);

        ChromeOptions options = new ChromeOptions();
        options.setCapability("goog:chromeOptions", ImmutableMap.of("ignoreProtectedModeSettings", true));
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

        // 원하는 요소를 찾기(스크롤할 창)
        WebElement scrollBox = driver.findElement(By.id("_pcmap_list_scroll_container"));

        Actions builder = new Actions(driver);

        for (int i = 0; i < 6; i++) {
            ((JavascriptExecutor) driver).executeScript("arguments[0].scrollIntoView(true);", scrollBox);
            try {
                Thread.sleep(3000);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }

        // 사이트에서 전체 매장을 찾은 뒤 코드를 읽는다
        List<WebElement> elements = driver.findElements(By.className("TYaxT"));

        for (WebElement e : elements) {
            Actions actions = new Actions(driver); // 새로운 Actions 객체 생성
            actions.moveToElement(e).click().perform(); // 해당 요소로 스크롤하고 클릭

            String key = e.getText();

            try {
                Thread.sleep(2000);
            } catch (InterruptedException ex) {
                ex.printStackTrace();
            }

            driver.switchTo().parentFrame();
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
         List<WebElement> menuEles = null;
         List<WebElement> priceEles = null;

         if (driver.findElements(By.className("VQvNX")).size() > 0) {
        	    menuEles = driver.findElements(By.className("VQvNX"));
        	    priceEles = driver.findElements(By.className("gl2cc"));
        	} else if (driver.findElements(By.className("mJtfr")).size() > 0) {
//        	    WebElement link = driver.findElement(By.className("ds3HZ")).findElement(By.tagName("a"));
//        	    WebElement link = driver.findElement(By.cssSelector("#app-root > div > div > div > div:nth-child(6) > div > div:nth-child(3) > div.place_section_content > ul > li:nth-child(1) > div > div.Fi0vA > div > div > a"));
//        	    link.click();
//        	    driver.manage().timeouts().implicitlyWait(10, TimeUnit.SECONDS); // Set implicit wait
        	    menuEles = driver.findElements(By.className("mJtfr"));
        	    priceEles = driver.findElements(By.className("Xac1z"));
        	}

        	// Proceed with extracting menu names and prices using menuEles and priceEles

        	try {
        	    if (menuEles != null && priceEles != null) {
        	        StringBuilder menuInfoBuilder = new StringBuilder();
        	        for (int i = 0; i < Math.min(menuEles.size(), priceEles.size()); i++) {
        	            String temp = menuEles.get(i).getText() + ":" + priceEles.get(i).getText() + ";";
        	            menuInfoBuilder.append(temp);
        	        }
        	        menuInfo = menuInfoBuilder.toString();
        	    } else {
        	        menuInfo = null;
        	    }
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
            
            
         // 이미지 url 5개 가져오기
            List<String> imageUrls = new ArrayList<>();
            try {
                Wait<WebDriver> wait = new FluentWait<>(driver)
                        .withTimeout(Duration.ofSeconds(10)) // 최대 10초까지 대기
                        .pollingEvery(Duration.ofMillis(500)) // 500밀리초마다 확인
                        .ignoring(NoSuchElementException.class); // 해당 예외 발생 시 무시

                List<WebElement> imageElements = wait.until(driver -> driver.findElements(By.xpath("//div[@class='K0PDV _div']/div")));
                for (int i = 0; i < Math.min(5, imageElements.size()); i++) {
                    String styleAttribute = imageElements.get(i).getAttribute("style");
                    String url = styleAttribute.split("url\\(")[1].split("\\)")[0].replaceAll("'", "").replaceAll("\"", "");
                    imageUrls.add(url);
                }
            } catch (Exception ex) {
                ex.printStackTrace();
            }

            for (String imageUrl : imageUrls) {
                System.out.println("Image URL: " + imageUrl);
            }

            // Output data
            System.out.println("Name: " + key);
            System.out.println("Address: " + address);
            System.out.println("Phone Number: " + phoneNumber);
            System.out.println("Business Hours: " + businessHours);
            System.out.println("Menu Info: " + menuInfo);
            System.out.println("Facilities: " + facilities);
            for (String imageUrl : imageUrls) {
                System.out.println("Image URL: " + imageUrl);
            }
        }

        driver.quit();
    }

    public static void main(String[] args) {
        WebCrawler7 crawler = new WebCrawler7();
        crawler.crawlMap("대전");
    }
}
