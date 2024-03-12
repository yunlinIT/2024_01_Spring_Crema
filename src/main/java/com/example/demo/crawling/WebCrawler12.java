package com.example.demo.crawling; //WebCrawler8에서 오류 해결중

import java.time.Duration;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.TimeUnit;

import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;

public class WebCrawler12 {

    private WebDriver driver;
    private String url;

    public static String WEB_DRIVER_ID = "webdriver.chrome.driver";
    public static String WEB_DRIVER_PATH = "C:/work/chromedriver.exe";

    public void crawlMap(String location) {
        System.setProperty(WEB_DRIVER_ID, WEB_DRIVER_PATH);

        ChromeOptions options = new ChromeOptions();
        options.setCapability("pageLoadStrategy", "eager"); // 페이지 로드 전략 설정
        options.addArguments("--headless"); // 헤드리스 모드 설정 (화면 표시 X)
        driver = new ChromeDriver(options);
        driver.manage().timeouts().implicitlyWait(10, TimeUnit.SECONDS);

        url = "https://map.naver.com/v5/";
        driver.get(url);

        // 네이버 지도 검색창에 원하는 검색어 입력 후 엔터
        WebElement inputSearch = driver.findElement(By.className("input_search"));
        String inputKey = " 서구 카페";
        inputSearch.sendKeys(location + inputKey);
        inputSearch.sendKeys(Keys.ENTER);

        // 데이터가 iframe 안에 있는 경우(HTML 안 HTML) 이동
//        WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(10));
//        wait.until(ExpectedConditions.frameToBeAvailableAndSwitchToIt("searchIframe"));
        
        WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(30));
        wait.until(ExpectedConditions.frameToBeAvailableAndSwitchToIt("searchIframe"));

        // 원하는 요소를 찾기(스크롤할 창)
        WebElement scrollBox = driver.findElement(By.id("_pcmap_list_scroll_container"));

        for (int i = 0; i < 6; i++) {
            ((JavascriptExecutor) driver).executeScript("arguments[0].scrollIntoView(true);", scrollBox);
            try {
                Thread.sleep(3000); // 스크롤 후 잠시 대기
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
        
        // 사이트에서 전체 매장을 찾은 뒤 코드를 읽는다
        List<WebElement> elements = driver.findElements(By.className("TYaxT"));

        for (WebElement e : elements) {
            ((JavascriptExecutor) driver).executeScript("arguments[0].scrollIntoView(true);", e);
            e.click();

            String key = e.getText();

            try {
                Thread.sleep(2000); // 요소 클릭 후 잠시 대기
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
            
            // 이미지 url 5개 가져오기
            List<String> imageUrls = new ArrayList<>();
            try {
                wait.until(ExpectedConditions.visibilityOfElementLocated(By.xpath("//div[@class='K0PDV _div']")));
                List<WebElement> imageElements = driver.findElements(By.xpath("//div[@class='K0PDV _div']"));
                for (WebElement element : imageElements) {
                    String styleAttribute = element.getAttribute("style");
                    String url = styleAttribute.split("url\\(")[1].split("\\)")[0].replaceAll("'", "").replaceAll("\"", "");
                    imageUrls.add(url);
                }
            } catch (Exception ex) {
                ex.printStackTrace();
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
        WebCrawler12 crawler = new WebCrawler12();
        crawler.crawlMap("대전");
    }
}
