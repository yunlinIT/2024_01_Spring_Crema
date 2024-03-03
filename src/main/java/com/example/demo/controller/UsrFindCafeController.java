package com.example.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
@Controller
public class UsrFindCafeController {

	@RequestMapping("/usr/findcafe/searchList")
	public String searchList() {

		return "/usr/findcafe/searchList";
	}

}