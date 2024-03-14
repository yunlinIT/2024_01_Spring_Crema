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

public class WebCrawler4_naverBlogNewArticles {

    public void crawl() {
        System.setProperty("webdriver.chrome.driver", "C:/work/chromedriver.exe");

        ChromeOptions options = new ChromeOptions();
        options.addArguments("--headless");

        WebDriver driver = new ChromeDriver(options);

        try {
            driver.manage().timeouts().implicitlyWait(10, TimeUnit.SECONDS);

            String url = "https://section.blog.naver.com/BlogHome.naver?directoryNo=0&currentPage=1&groupId=0";
            driver.get(url);

            List<WebElement> elements = driver.findElements(By.cssSelector("#content section div.list_post_article div div.info_post div.desc a.desc_inner strong")); // 수정된 부분
            saveToFile(elements, "blogmain.txt");                        // #content > section > div.list_post_article > div:nth-child(1) > div.info_post > div.desc > a.desc_inner > strong
            															 // #content section div.list_post_article div div.info_post div.desc a.desc_inner strong
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


//    public static void main(String[] args) {
//        WebCrawler4_naverBlogNewArticles webCrawler = new WebCrawler4_naverBlogNewArticles();
//        webCrawler.crawl();
//    }
}
