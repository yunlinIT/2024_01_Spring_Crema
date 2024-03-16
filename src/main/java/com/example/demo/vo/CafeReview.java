package com.example.demo.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CafeReview {
	private int id;
	private String regDate;
	private String updateDate;
	private int memberId;
	private int cafeId;
	private String body;


	private String extra__writer;

	private boolean userCanModify;
	private boolean userCanDelete;
}