package com.example.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.repository.CafeRepository;
import com.example.demo.vo.Cafe;


@Service
public class CafeService {

    @Autowired
    private CafeRepository cafeRepository;

    // 웹 크롤러를 통해 카페 데이터를 가져와서 저장하는 메서드
    public void saveCafeDataFromWebCrawler(List<Cafe> cafes) {

        for (Cafe cafe : cafes) {
        	           
            int count = cafeRepository.countDuplicateCafeName(cafe.getName());
            
            if (count == 0) {
            	 cafeRepository.insertCafe(cafe); 
            } 
        }
    }
}


