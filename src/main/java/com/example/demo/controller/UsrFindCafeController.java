package com.example.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
@Controller
public class UsrFindCafeController {

	@RequestMapping("/usr/findcafe/searchList")
	public String searchList() {

		return "/usr/findcafe/searchList";
	}
	
	@RequestMapping("/usr/findcafe/likeList")
	public String likeList() {

		return "/usr/findcafe/likeList";
	}
	
	@RequestMapping("/usr/findcafe/cafeDetail")
	public String cafeDetail() {

		return "/usr/findcafe/cafeDetail";
	}

}