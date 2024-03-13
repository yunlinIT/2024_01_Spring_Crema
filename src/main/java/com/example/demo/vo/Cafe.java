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
	
	private int goodReactionPoint;
	private int reviewCount;
	private String hastag;

}