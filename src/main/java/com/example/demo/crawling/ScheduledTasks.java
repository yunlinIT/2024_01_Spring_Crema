package com.example.demo.crawling;

import java.time.format.DateTimeFormatter;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import lombok.extern.slf4j.Slf4j;

@Slf4j // 로그를 위해서
@Component // 빈 등록
public class ScheduledTasks {

	private static final DateTimeFormatter formatter = DateTimeFormatter.ofPattern("mm:ss:SSS");

	@Scheduled(fixedRate = 3600000)
	public void fixedRate() {
		System.err.println("Scheduling Test");
				
	}

}
