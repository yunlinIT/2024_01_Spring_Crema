package com.example.demo.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Cafe {
	private int id;
	private String regDate;
	private String updateDate;
	private String name;
	private String address;
	private String businessHours;
	private String phoneNum;
	private String facilities;
	private String cafeImgUrl1;
	private String cafeImgUrl2;
	private String cafeImgUrl3;
	private String cafeImgUrl4;
	private String cafeImgUrl5;
	
	private int cafeScrapCount;
	private int reviewCount;
	private String hashtag;

}


