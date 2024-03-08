package com.example.demo.dto;

import java.util.List;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class CrawlingDTO {
    private String data;
    private String img;

    private List<CrawlingDTO> list;
}