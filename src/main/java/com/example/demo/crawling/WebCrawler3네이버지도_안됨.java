package com.example.demo.crawling;


import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import java.io.FileWriter;
import java.io.IOException;
import java.util.List;
import java.util.concurrent.TimeUnit;

public class WebCrawler3네이버지도_안됨 {

    public void crawl() {
        System.setProperty("webdriver.chrome.driver", "C:/work/chromedriver.exe");

        ChromeOptions options = new ChromeOptions();
        options.addArguments("--headless");

        WebDriver driver = new ChromeDriver(options);

        try {
            driver.manage().timeouts().implicitlyWait(10, TimeUnit.SECONDS);

            String url = "https://map.naver.com/p/search/%EB%8C%80%EC%A0%84%20%EC%84%9C%EA%B5%AC%20%EC%B9%B4%ED%8E%98?c=11.00,0,0,0,dh";
            driver.get(url);

            List<WebElement> elements = driver.findElements(By.cssSelector("#_pcmap_list_scroll_container > ul > li:nth-child(3) > div.CHC5F > a.tzwk0 > div > div > span.TYaxT")); // 수정된 부분
            saveToFile(elements, "cafes_in_seo-gu.txt");

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            driver.quit();
        }
    }

    private void saveToFile(List<WebElement> elements, String fileName) throws IOException {
        FileWriter writer = new FileWriter(fileName);
        for (WebElement element : elements) {
            String cafeName = element.getText();
            writer.write(cafeName + "\n");
        }
        writer.close();
        System.out.println("데이터를 파일에 저장했습니다.");
    }


    public static void main(String[] args) {
        WebCrawler3네이버지도_안됨 webCrawler = new WebCrawler3네이버지도_안됨();
        webCrawler.crawl();
    }
}
