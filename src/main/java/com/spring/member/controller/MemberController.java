package com.spring.member.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.spring.member.service.MemberService;

@Controller
public class MemberController {
	@Autowired
	MemberService service;
	
	
	
}
