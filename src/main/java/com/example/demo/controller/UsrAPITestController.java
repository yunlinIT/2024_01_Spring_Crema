package com.example.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class UsrAPITestController {
	
	
	
	// 그냥 테스트용 컨트롤러 

	@RequestMapping("/usr/home/APITest")
	public String APITest() {

		return "/usr/home/APITest";
	}
	
	@RequestMapping("/usr/home/OpenWeatherAPITest")
	public String APITest2() {

		return "/usr/home/OpenWeatherAPITest";
	}
	
	@RequestMapping("/usr/home/APITest3")
	public String APITest3() {

		return "/usr/home/APITest3";
	}
	
	@RequestMapping("/usr/home/APITest4")
	public String APITest4() {

		return "/usr/home/APITest4";
	}
	@RequestMapping("/usr/home/APITest5")
	public String APITest5() {

		return "/usr/home/APITest5";
	}
	
	
	@RequestMapping("/usr/home/APITest7")
	public String APITest7() {

		return "/usr/home/APITest7";
	}

}