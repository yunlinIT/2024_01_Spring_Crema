package com.example.demo.crawling;

import java.io.BufferedWriter;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.time.Duration;
import java.util.ArrayList;
import java.util.List;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.springframework.stereotype.Controller;

@Controller 
public class CrawlingTest_안됨 {

	public static void main(String[] args) {
		// 1. WebDriver와 ChromeDriver 설정
		// 프로젝트 폴더 기준으로 chromedirver.exe 파일의 위치를 작성
		System.setProperty("webdriver.chrome.driver", "C:/work/sts-4.21.0.RELEASE-workspace/2024_01_Spring_Crema/src/main/resources/chromedriver.exe");
		WebDriver driver = new ChromeDriver();
	
		
		// 2. 웹 페이지 접속
		String baseUrl = "https://movie.daum.net/ranking/boxoffice/weekly";
		// String searchTerm = "Java";
		// String url = baseUrl + "/wiki/" + searchTerm;
		
		driver.get(baseUrl);
		
		
		// 3. 데이터 추출
		ArrayList<Movie_안됨> movie_data = new ArrayList<>();
		
		WebElement movie_container = driver.findElement(By.cssSelector(".list_movieranking"));

		List<WebElement> movie_links = movie_container.findElements(By.cssSelector(".tit_item>a"));
		
		for(int i= 0; i < movie_links.size(); i++) {
			String link = movie_links.get(i).getAttribute("href");
			// links.add(link);
			driver.get(link);
			
			driver.manage().timeouts().implicitlyWait(Duration.ofMillis(500));
			
			String title = driver.findElement(By.xpath("//*[@id=\"mainContent\"]/div/div[1]/div[2]/div[1]/h3/span[1]")).getText();
			String start = driver.findElement(By.xpath("//*[@id=\"mainContent\"]/div/div[1]/div[2]/div[2]/div[1]/dl[1]/dd")).getText();
			String star = driver.findElement(By.xpath("//*[@id=\"mainContent\"]/div/div[1]/div[2]/div[2]/div[2]/dl[1]/dd")).getText();
			String learning_time = driver.findElement(By.xpath("//*[@id=\"mainContent\"]/div/div[1]/div[2]/div[2]/div[1]/dl[5]/dd")).getText();
			String content = driver.findElement(By.xpath("//*[@id=\"mainContent\"]/div/div[2]/div[2]/div[1]/div/div/div")).getText();
			
			Movie_안됨 movie = new Movie_안됨(title, start, star, learning_time, content);
			
			System.out.println((i+1)+". "+ title + " (" + star + ")");
			
			movie_data.add(movie);
		
			driver.navigate().back();
			// System.out.println(link);
		}
		
		
		// 4. 파일저장
        // 파일에 데이터 쓰기
        String fileName = "output.csv";
        try (BufferedWriter writer = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(fileName), "UTF-8"))) {
            for (int i=0; i<movie_data.size(); i++) {
            	writer.write((i+1)+";");
            	writer.write(movie_data.get(i).getTitle()+";");
                writer.write(movie_data.get(i).getStar()+";");
                writer.write(movie_data.get(i).getLearning_time()+";");
                writer.write(movie_data.get(i).getStart()+";");
                writer.write(movie_data.get(i).getContent().replace("\n","」"));
                writer.newLine();
            }
            String currentDir = System.getProperty("user.dir");
            System.out.println("파일 저장 디렉토리: " + currentDir);
            System.out.println("파일에 데이터를 성공적으로 저장했습니다.");
        } catch (IOException e) {
            e.printStackTrace();
        }
        		
		// 5. WebDriver 종료
		driver.quit();
	}
	
}