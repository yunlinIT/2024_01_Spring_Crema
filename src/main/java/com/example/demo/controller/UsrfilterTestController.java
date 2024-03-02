package com.example.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.demo.util.Ut;
import com.example.demo.vo.Rq;

import jakarta.servlet.http.HttpServletRequest;







@Controller
public class UsrfilterTestController {

	@RequestMapping("/usr/home/filterTest")
	public String filterTest() {

		return "/usr/home/filterTest";
	}
	
	

	


}