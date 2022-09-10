package com.spring.member.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.member.service.MemberService;
import com.spring.member.vo.MemberVO;

@Controller
public class MemberController {
	@Autowired
	MemberService service;
	
	// 회원가입 페이지로 이동
	@RequestMapping(value = "/MemberJoin.me", method = RequestMethod.GET)
	public String JoinForm() {
		return "member/join_form";
	}
	
	// 아이디 중복 확인
	@RequestMapping(value = "/IdDuplicate.me")
	public String IdDuplicate(@RequestParam(defaultValue = "0")String id, Model model) {
		System.out.println("id값:" + id);
		MemberVO member = service.getMemberFromId(id);
		
		model.addAttribute("member",member);
		
		return "member/join_duplicate_id";
	}
	
	// 이메일 중복 확인
	@RequestMapping(value = "/EmailDuplicate.me")
	public String EmailDuplicate(@RequestParam(defaultValue = "")String email, Model model) {
		System.out.println("email값:" + email);
		MemberVO member = service.getMemberFromEmail(email);

		model.addAttribute("member",member);
		
		return "member/join_duplicate_email";
	}
		
	// 로그인 페이지로 이동
	@RequestMapping(value = "/MemberLogin.me", method = RequestMethod.GET)
	public String LoginForm() {
		return "member/login_form";
	}
	
	
	
	
}
