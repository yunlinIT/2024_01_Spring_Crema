package com.example.demo.crawling;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;

@Slf4j // 로그를 위해서
@Component // 빈 등록
@Service
public class ScheduledTasks {

	private static final DateTimeFormatter formatter = DateTimeFormatter.ofPattern("mm:ss:SSS");

	@Scheduled(fixedRate = 60000)
	public void fixedRate() {
		System.err.println("Hello CoCo World!");
				
	}

}
