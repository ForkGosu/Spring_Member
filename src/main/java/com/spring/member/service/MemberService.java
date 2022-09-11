package com.spring.member.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.member.mapper.MemberMapper;
import com.spring.member.vo.EmailAuthVO;
import com.spring.member.vo.MemberVO;

@Service
public class MemberService {
	
	@Autowired
	MemberMapper mapper;
	
	public MemberVO getMemberFromId(String id) {
		return mapper.getMemberFromId(id);
	}

	public MemberVO getMemberFromEmail(String email) {
		return mapper.getMemberFromEmail(email);
	}

	public EmailAuthVO getEmailAuthFromEmail(String email) {
		return mapper.getEmailAuthFromEmail(email);
	}

	public boolean sendEmailAuthCode(String email, String authCode) {
		return mapper.sendEmailAuthCode(email, authCode);
	}

	public boolean sendEmailAuthCodeUpdate(String email, String authCode) {
		return mapper.sendEmailAuthCodeUpdate(email, authCode);
	}

}
