package com.example.demo.crawling;

import java.time.format.DateTimeFormatter;

import org.springframework.scheduling.annotation.Scheduled; // 스케줄링 어노테이션
import org.springframework.stereotype.Component; // 컴포넌트로 등록하는 어노테이션

import lombok.extern.slf4j.Slf4j; // 로그를 위한 롬복 어노테이션

@Slf4j // 롬복을 사용하여 로그 기능을 추가하는 어노테이션
@Component // 스프링에게 이 클래스가 빈으로 등록되어야 함을 알리는 어노테이션
public class ScheduledTasks {

    private static final DateTimeFormatter formatter = DateTimeFormatter.ofPattern("mm:ss:SSS"); // 시간 포맷 지정

    // 매 시간마다 실행되는 메서드
    @Scheduled(fixedRate = 3600000) // 스케줄링 어노테이션을 이용하여 주기적으로 실행될 메서드를 지정
    public void fixedRate() {
        System.err.println("Scheduling Test"); // 로그 출력
    }
}
