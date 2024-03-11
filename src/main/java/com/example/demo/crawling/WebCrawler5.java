package com.example.demo.crawling;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStreamReader;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.interactions.Actions;

public class WebCrawler5 {

    // WebDriver
    private WebDriver driver;
    private WebElement element;
    private String url;

    // Properties
    public static String WEB_DRIVER_ID = "webdriver.chrome.driver";
    public static String WEB_DRIVER_PATH = "C:/work/chromedriver.exe";

    // 매장 정보들을 저장할 해시맵
    Map<String, ArrayList<String>> coffeeInfoms = new HashMap<>();
    ArrayList<String> temp = new ArrayList<>();

    // 중복 제거한 도로명이 담긴 리스트
    ArrayList<String> roadNameList = new ArrayList<>();

//    public void txtReader() {
//        try {
//            // "."은 working directory 경로
//            FileInputStream file = new FileInputStream(".\\intrvl_seoul.txt");
//            // 텍스트파일 인코딩은 MS949형식으로 되어있다.
//            InputStreamReader inputStreamReader = new InputStreamReader(file, "MS949");
//            // 입력 버퍼 생성
//            BufferedReader br = new BufferedReader(inputStreamReader);
//            String line = "";
//            while ((line = br.readLine()) != null) {
//                System.out.println(line);
//                String[] lineAry = line.split("\\|");
//
//                if (!roadNameList.contains(lineAry[10])) {
//                    roadNameList.add(lineAry[10]);
//                }
//
//            }
//            br.close();
//        } catch (FileNotFoundException e) {
//            System.out.println("File not found");
//        } catch (IOException e) {
//            System.out.println(e);
//        }
//
//    }

    public void crawlMap(String location) throws InterruptedException {
        // System Property SetUp
        System.setProperty(WEB_DRIVER_ID, WEB_DRIVER_PATH);

        // Driver SetUp
        ChromeOptions options = new ChromeOptions();
        options.setCapability("ignoreProtectedModeSettings", true);
        driver = new ChromeDriver(options);

        // 네이버 지도
        url = "https://map.naver.com/v5/";
        driver.get(url);
        Thread.sleep(5000);

        // 네이버 지도 검색창에 원하는 동명 입력 후 엔터
        WebElement inputSearch = driver.findElement(By.className("input_search"));
        String inputKey = " 카페";
        inputSearch.sendKeys(location + inputKey);
        Thread.sleep(1000);
        inputSearch.sendKeys(Keys.ENTER);
        Thread.sleep(3000);

        // 데이터가 iframe 안에 있는 경우(HTML 안 HTML) 이동
        driver.switchTo().frame("searchIframe");

        // 원하는 요소를 찾기(스크롤할 창)
        WebElement scrollBox = driver.findElement(By.id("_pcmap_list_scroll_container"));

        Actions builder = new Actions(driver);

        // 커서를 올리고 스크롤을 내리는 액션 체인 생성, 실행
        for (int i = 0; i < 1; i++) {
            builder.sendKeys(scrollBox, Keys.END).build().perform();
            Thread.sleep(2000);
        }

        // 사이트에서 전체 매장을 찾은 뒤 코드를 읽는다
        List<WebElement> elements = driver.findElements(By.className("TYaxT"));

        for (WebElement e : elements) {
            System.out.println(e.getText());
            // 매장명을 키값으로 해시맵 생성
            coffeeInfoms.put(e.getText(), new ArrayList<>());
        }

        // 매장을 하나씩 클릭하고 주소를 읽는다
        for (WebElement e : elements) {
            e.click();
            String key = e.getText();
            Thread.sleep(2000);
            driver.switchTo().parentFrame(); // 부모 프레임으로 이동
            driver.switchTo().frame(driver.findElement(By.id("entryIframe"))); // 옆 iframe으로 이동

            // 주소
            WebElement addEle = driver.findElement(By.className("LDgIH"));
            ArrayList<String> addTemp = coffeeInfoms.get(key);
            addTemp.add(0, addEle.getText());
            coffeeInfoms.put(key, addTemp);

            // 영업시간 있는 경우
//            try {
//                // 버튼을 클릭하여 영업 시간 요소를 표시
//                WebElement button = driver.findElement(By.className("gKP9i"));
//                button.click();
//
//                // 영업 시간 요소 가져오기
//                WebElement dayElement = driver.findElement(By.xpath("//span[@class='i8cJw']"));
//                String day = dayElement.getText();
//
//                WebElement timeElement = driver.findElement(By.xpath("//div[@class='w9QyJ']//div[@class='H3ua4']"));
//                String openingHours = timeElement.getText();
//
//                // 영업 시간 및 영업요일을 해시맵에 추가
//                ArrayList<String> timeTemp = coffeeInfoms.get(key);
//                timeTemp.add(3, day + " " + openingHours); // 영업요일과 영업 시간 함께 저장
//                coffeeInfoms.put(key, timeTemp);
//            } catch (Exception ex) {
//                // 예외 처리: 영업 시간 요소를 찾을 수 없는 경우
//                System.out.println(ex.toString());
//
//                // 영업 시간 정보가 없는 경우 null 처리
//                ArrayList<String> timeTemp = coffeeInfoms.get(key);
//                timeTemp.add(3, null);
//                coffeeInfoms.put(key, timeTemp);
//            }

            // 전화번호 있는 경우
            try {
                WebElement callEle = driver.findElement(By.className("xlx7Q"));
                ArrayList<String> callTemp = coffeeInfoms.get(key);
                callTemp.add(1, callEle.getText());
                coffeeInfoms.put(key, callTemp);
            } catch (Exception ex) {
                System.out.println(ex.toString());
                // 전화번호 정보 없는 경우 null처리
                ArrayList<String> callTemp = coffeeInfoms.get(key);
                callTemp.add(2, null);
                coffeeInfoms.put(key, callTemp);
            }

            // 시설정보 있는 경우
            try {
                WebElement facilEle = driver.findElement(By.className("xPvPE"));
                ArrayList<String> facilTemp = coffeeInfoms.get(key);
                facilTemp.add(1, facilEle.getText());
                coffeeInfoms.put(key, facilTemp);
            } catch (Exception ex) {
                System.out.println(ex.toString());
                // 시설정보 정보 없는 경우 null처리
                ArrayList<String> facilTemp = coffeeInfoms.get(key);
                facilTemp.add(4, null);
                coffeeInfoms.put(key, facilTemp);
            }

            // 메뉴정보를 저장할 문자열
            // 메뉴와 가격은 ':', 메뉴 간은 ';'로 구분
            String menuInfo = "";

            try {
                List<WebElement> menuEles = driver.findElements(By.className("VQvNX"));
                List<WebElement> priceEles = driver.findElements(By.className("gl2cc"));
                for (int i = 0; i < menuEles.size(); i++) {
                    String temp = menuEles.get(i).getText() + ":" + priceEles.get(i).getText() + ";";
                    menuInfo = menuInfo + temp;
                }
            } catch (Exception ex) {
                System.out.println("메뉴정보 없음");
            }

            ArrayList<String> menuTemp = coffeeInfoms.get(key);
            menuTemp.add(2, menuInfo);
            coffeeInfoms.put(key, menuTemp);

            driver.switchTo().parentFrame(); // 부모 프레임으로 이동
            driver.switchTo().frame("searchIframe"); // 원래 iframe으로 이동
        }

        // 창 닫기
        // driver.close();
    }

//    // db에 해시맵의 정보 업데이트
//    public void uploadDB() {
//        String driver = "oracle.jdbc.driver.OracleDriver";
//        String url = "jdbc:oracle:thin:@//34.64.231.171/xe";
//        Connection con = null;
//        PreparedStatement pstmt = null;
//        String query = "MERGE INTO T_CAFE A USING(SELECT NVL(MAX(CAFE_NAME), ' ') CAFE_NAME, NVL(MAX(CAFE_ADDRESS), ' ') CAFE_ADDRESS FROM T_CAFE WHERE CAFE_NAME=? AND CAFE_ADDRESS=?) B ON (A.CAFE_NAME = B.CAFE_NAME AND A.CAFE_ADDRESS = B.CAFE_ADDRESS) WHEN MATCHED THEN UPDATE SET CONTACT_NUMBER=?, MENU_INFO=?,"
//                + "UPDATED_DATETIME = SYSDATE, UPDATOR_ID=?, DELETED_YN=? WHEN NOT MATCHED THEN INSERT (CAFE_NAME, CAFE_ADDRESS, CONTACT_NUMBER, MENU_INFO, CREATED_DATETIME, CREATOR_ID, DELETED_YN) VALUES (?,?,?,?,SYSDATE,?,?)";
//
//        try {
//            Class.forName(driver); // 드라이버 로딩
//            con = DriverManager.getConnection(url, "COFFEE_IDX", "onestar21"); // DB연결
//            pstmt = con.prepareStatement(query);
//
//            Set set = coffeeInfoms.keySet();
//            Iterator iterator = set.iterator();
//            while (iterator.hasNext()) {
//
//                String key = (String) iterator.next();
//                pstmt.setString(1, key);
//                pstmt.setString(2, coffeeInfoms.get(key).get(0));
//                pstmt.setString(3, coffeeInfoms.get(key).get(1));
//                pstmt.setString(4, coffeeInfoms.get(key).get(2));
//                pstmt.setString(5, coffeeInfoms.get(key).get(3));
//                pstmt.setString(6, "admin");
//                pstmt.setString(7, "N");
//
//                int cnt = pstmt.executeUpdate();
//            }
//        } catch (Exception e) {
//            System.out.println(e.getMessage());
//        } finally {
//            try {
//                pstmt.close();
//                con.close();
//            } catch (Exception e2) {
//                System.out.println(e2.getMessage());
//            }
//        }
//    }

    public static void main(String[] args) throws InterruptedException {
        WebCrawler4 test = new WebCrawler4();
        test.crawlMap("서구");
        
        System.out.println(test.coffeeInfoms.get("빈이어"));
        
        // test.uploadDB();
    }
}
