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

public class WebCrawler11 {
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

        WebElement inputSearch = driver.findElement(By.className("input_search"));
        String inputKey = " 서구 카페";
        inputSearch.sendKeys(location + inputKey);
        inputSearch.sendKeys(Keys.ENTER);

        try {
            Thread.sleep(3000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }

        driver.switchTo().frame("searchIframe");

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

        List<WebElement> elements = driver.findElements(By.className("TYaxT"));

        for (WebElement e : elements) {
            Actions actions = new Actions(driver);
            actions.moveToElement(e).click().perform();

            String key = e.getText();

            try {
                Thread.sleep(2000);
            } catch (InterruptedException ex) {
                ex.printStackTrace();
            }

            driver.switchTo().parentFrame();
            driver.switchTo().frame(driver.findElement(By.id("entryIframe")));

            String address = driver.findElement(By.className("LDgIH")).getText();

            String phoneNumber;
            try {
                phoneNumber = driver.findElement(By.className("xlx7Q")).getText();
            } catch (Exception ex) {
                phoneNumber = null;
            }

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

            String menuInfo;
            List<WebElement> menuEles = null;
            List<WebElement> priceEles = null;

            if (driver.findElements(By.className("VQvNX")).size() > 0) {
                menuEles = driver.findElements(By.className("VQvNX"));
                priceEles = driver.findElements(By.className("gl2cc"));
            } else if (driver.findElements(By.className("mJtfr")).size() > 0) {
                menuEles = driver.findElements(By.className("mJtfr"));
                priceEles = driver.findElements(By.className("Xac1z"));
            }

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

            String facilities;
            try {
                WebElement facilitiesElement = driver.findElement(By.className("xPvPE"));
                facilities = facilitiesElement.getText();
            } catch (Exception ex) {
                facilities = null;
            }

            // Print log for debugging
            System.out.println("Name: " + key);
            System.out.println("Address: " + address);
            System.out.println("Phone Number: " + phoneNumber);
            System.out.println("Business Hours: " + businessHours);
            System.out.println("Menu Info: " + menuInfo);
            System.out.println("Facilities: " + facilities);

            // Proceed with image URL extraction
            extractImageUrls();

            System.out.println(); // for better readability
        }

        driver.quit();
    }

    // Method to extract image URLs
    private void extractImageUrls() {
        List<String> imageUrls = new ArrayList<>();
        try {
            Wait<WebDriver> wait = new FluentWait<>(driver)
                    .withTimeout(Duration.ofSeconds(10)) 
                    .pollingEvery(Duration.ofMillis(500)) 
                    .ignoring(NoSuchElementException.class); 

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
    }

    public static void main(String[] args) {
        WebCrawler10 crawler = new WebCrawler10();
        crawler.crawlMap("대전");
    }
}
