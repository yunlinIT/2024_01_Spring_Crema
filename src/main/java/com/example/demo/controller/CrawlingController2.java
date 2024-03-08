package com.example.demo.controller;

import java.util.ArrayList;
import java.util.List;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.example.demo.dto.CrawlingDTO;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class CrawlingController2 {

	@GetMapping("/crawling")
	public ResponseEntity<Integer> crawling(HttpServletRequest request) {
		List<CrawlingDTO> list = new ArrayList<>();

		String WEB_DRIVER_ID = "webdriver.chrome.driver";
		String WEB_DRIVER_PATH = "c:/work/sts-4.21.0.RELEASE-workspace/2024_01_Spring_Crema/src/main/resources/chromedriver.exe";

		System.setProperty(WEB_DRIVER_ID, WEB_DRIVER_PATH);
		ChromeOptions options = new ChromeOptions();
		options.addArguments("--remote-allow-origins=*");
		options.addArguments("headless");

		WebDriver driver = new ChromeDriver(options);

		try {
			driver.get("https://www.daum.net/"); // 크롤링할 사이트의 url
			for (WebElement element : driver.findElements(By.className("DataSet"))) {
				String data = element.getText();
				WebElement imgs = element.findElement(By.tagName("img"));
				String img = imgs.getAttribute("src");

				CrawlingDTO dto = new CrawlingDTO();
				dto.setData(data);
				dto.setImg(img);

				list.add(dto);
			}
			return ResponseEntity.ok(1);
		} catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.ok(0);
		} finally {
			driver.close();
		}

	}
}
