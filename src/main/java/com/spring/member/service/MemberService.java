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

	public boolean sendEmailAuthCode(EmailAuthVO emailAuth) {
		return mapper.sendEmailAuthCode(emailAuth);
	}

	public boolean sendEmailAuthCodeUpdate(EmailAuthVO emailAuth) {
		return mapper.sendEmailAuthCodeUpdate(emailAuth);
	}

	public boolean joinMember(MemberVO member) {
		return mapper.joinMember(member);
	}

}
