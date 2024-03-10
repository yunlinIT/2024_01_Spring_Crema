package com.example.demo.crawling;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class CrawlingController_안됨 {

	@RequestMapping("/weather.json")
	public List<HashMap<String, Object>> weather() {
		List<HashMap<String, Object>> array = new ArrayList<HashMap<String, Object>>();
		try {
			// 드라이버 위치
			System.setProperty("webdriver.chrome.driver", "c:/work/sts-4.21.0.RELEASE-workspace/2024_01_Spring_Crema/src/main/resources/chromedriver.exe");
			// 드라이버 옵션
			ChromeOptions options = new ChromeOptions();
			// 웹 페이지 안열리게
			// options.addArguments("headless");
			// 웹 드라이버
			WebDriver driver = new ChromeDriver(options);
			driver.get("https://www.daum.net/");

			List<WebElement> elements = driver.findElements(By.cssSelector(".list_weather li"));
			for (WebElement e : elements) {
				HashMap<String, Object> map = new HashMap<String, Object>();
				String part = e.findElement(By.className("txt_part")).getAttribute("textContent");
				String status = e.findElement(By.tagName("strong")).getAttribute("textContent");
				String temper = e.findElement(By.className("txt_temper")).getAttribute("textContent");
				map.put("part", part);
				map.put("status", status);
				map.put("temper", temper);
				array.add(map);
			}
			driver.close();
		} catch (Exception e) {
			System.out.println("daum weather Crawling error : " + e.toString());
		}
		return array;
	}
}
