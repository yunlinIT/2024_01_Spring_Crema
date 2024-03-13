package com.example.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.crawling.WebCrawler13;
import com.example.demo.repository.CafeRepository;
import com.example.demo.vo.Cafe;


@Service
public class CafeService {

    @Autowired
    private CafeRepository cafeRepository;



    public void saveCafeDataFromWebCrawler() {
        WebCrawler13 crawler = new WebCrawler13(); // WebCrawler13 클래스의 인스턴스 생성
        List<Cafe> cafes = crawler.crawlCafes(); // 생성된 인스턴스를 통해 메서드 호출
    

        for (Cafe cafe : cafes) {
            cafeRepository.insertCafe(cafe);
        }


    }

}
