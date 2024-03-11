package com.example.demo.crawling;

import java.io.FileWriter;
import java.io.IOException;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;

public class WebCrawler_melonTop1 {

    public void crawl() {
        // 크롬 드라이버 경로 설정 (크롬 드라이버 설치 필요)
        System.setProperty("webdriver.chrome.driver", "C:/work/chromedriver.exe");

        // 크롬 옵션 설정
        ChromeOptions options = new ChromeOptions();
        options.addArguments("--headless"); // 브라우저를 표시하지 않고 실행할 경우

        // 웹 드라이버 초기화
        WebDriver driver = new ChromeDriver(options);

        try {
            // 크롤링할 웹 페이지 URL
            String url = "https://www.melon.com/chart/index.htm";
            // 웹 페이지 열기
            driver.get(url);

            // 특정 요소 찾기 (예: id가 "someId"인 요소)
            WebElement element = driver.findElement(By.xpath("//*[@id=\"lst50\"]/td[6]/div/div/div[1]"));

            // 요소에서 텍스트 가져오기
            String text = element.getText();
            System.out.println("TOP100: " + text);

            // 파일에 텍스트 저장
            saveToFile(text, "output.txt");

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // 웹 드라이버 종료
            driver.quit();
        }
    }

    private void saveToFile(String text, String fileName) throws IOException {
        FileWriter writer = new FileWriter(fileName);
        writer.write(text);
        writer.close();
        System.out.println("데이터를 파일에 저장했습니다.");
    }

    public static void main(String[] args) {
        WebCrawler_melonTop1 webCrawler = new WebCrawler_melonTop1();
        webCrawler.crawl();
    }
}
