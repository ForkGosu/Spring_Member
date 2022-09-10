package com.spring.member.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.member.service.MemberService;

@Controller
public class MemberController {
	@Autowired
	MemberService service;
	
	// 로그인 페이지로 이동
	@RequestMapping(value = "/MemberLogin.me", method = RequestMethod.GET)
	public String LoginForm() {
		return "member/login_form";
	}
	
	// 회원가입 페이지로 이동
	@RequestMapping(value = "/MemberJoin.me", method = RequestMethod.GET)
	public String JoinForm() {
		return "member/join_form";
	}
	
	
}
