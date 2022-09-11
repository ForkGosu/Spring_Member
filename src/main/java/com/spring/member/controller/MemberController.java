package com.spring.member.controller;

import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.Properties;

import javax.mail.Address;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.Message.RecipientType;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.member.service.MemberService;
import com.spring.member.vo.EmailAuthVO;
import com.spring.member.vo.GenerateUserAuthenticationCode;
import com.spring.member.vo.GmailSMTPAuthenticator;
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
	@RequestMapping(value = "/IdDuplicate.me", method = RequestMethod.GET)
	public String IdDuplicate(@RequestParam(defaultValue = "0")String id, Model model) {
		System.out.println("IdDuplicate메서드에 전송된 id값:" + id);
		MemberVO member = service.getMemberFromId(id);
		
		model.addAttribute("member",member);
		
		return "member/join_duplicate_id";
	}
	
	// 이메일 중복 확인
	@RequestMapping(value = "/EmailDuplicate.me", method = RequestMethod.GET)
	public String EmailDuplicate(@RequestParam(defaultValue = "")String email, Model model) {
		System.out.println("EmailDuplicate메서드에 전송된 email값:" + email);
		MemberVO member = service.getMemberFromEmail(email);

		model.addAttribute("member",member);
		
		return "member/join_duplicate_email";
	}
	
	
	// 이메일 인증번호 보내기
	@RequestMapping(value = "/EmailAuthSend.me", method = RequestMethod.GET)
	public String EmailAuthSend(@RequestParam(defaultValue = "")String email, Model model) {
		System.out.println("EmailAuthSend메서드에 전송된 email값:" + email);
		
		GenerateUserAuthenticationCode myAuthCode = new GenerateUserAuthenticationCode(8);
		String authCode = myAuthCode.getAuthCode();
		System.out.println("EmailAuthSend메서드에서 전송할 authCode값:" + authCode);
		
		String sender = "test@itwillbs.co.kr"; // 보내는 사람 주소(관리자 메일)
		String receiver = email; // 받는 사람 주소
		String subject = "[BookShop] 북샵 가입 인증 메일입니다!"; // 메일 제목
		
		// 인증코드 보낼 때 발송할 content 미리 입력
		String content = "인증코드는 : \'" + authCode + "\' 입니다."; // 메일 본문

		boolean isError = false;
		try {
			// ---------------- 메일 전송을 위한 설정 작업 -----------------
			// 메일 전송 프로토콜 : SMTP(Simple Mail Tranfer Protocol) - TCP 587번 포트 사용(Gmail 기준)
			// => 시스템(서버)의 속성 정보(= 서버 정보)를 java.util.Properties 객체로 리턴받기
			Properties properties = System.getProperties();
			// 메일 전송에 필요한 기본 설정 정보를 서버 속성 정보에 추가 - Properties 객체의 put() 메서드 사용
			// 메일 전송에 사용할 메일 서버 지정(구글, 네이버, 아웃룩 등)
			properties.put("mail.smtp.host", "smtp.gmail.com"); // 구글(Gmail) SMTP 서버
			properties.put("mail.smtp.auth", "true"); // SMTP 서버에 대한 인증 여부 설정
			properties.put("mail.smtp.port", "587"); // SMTP 서비스 포트 설정
			// 메일 인증 정보 설정
			properties.put("mail.smtp.starttls.enable", "true"); // TLS 인증 사용 여부 설정
			properties.put("mail.smtp.ssl.protocols", "TLSv1.2"); // 인증 프로토콜 버전 설정
			// 만약, TLS 버전 문제 발생(could not convert socket to TLS) 시 다음 코드 추가

			// 메일 서버 인증 정보를 생성하는 사용자 정의 클래스의 인스턴스 생성(javax.mail)
			Authenticator authenticator = new GmailSMTPAuthenticator(); // 업캐스팅 활용

			// 자바 메일에서 메일 전송 기본 단위를 javax.mail.Session 객체 단위로 관리하므로
			// Session 클래스의 getDefaultInstance() 메서드를 호출하여 객체 얻어오기
			// => 파라미터 : 서버 정보와 인증 정보 전달(javax.mail)
			Session mailSession = Session.getDefaultInstance(properties, authenticator);

			// 서버와 인증 정보를 포함하는 MimeMessage 객체 생성
			// => 파라미터로 Session 객체 전달
			// => 생성된 MimeMessage 객체를 통해 전송할 메일에 대한 정보 생성(javax.mail.Internet)
			Message mailMessage = new MimeMessage(mailSession); // 업캐스팅

			// 전송할 메일에 대한 정보 설정
			// 1. 발신자 정보 설정
			// => 단, 스팸 메일 정책으로 인해 상용 메일 사이트(구글, 네이버 등)는 발신자 주소 변경 불가능
			Address senderAddress = new InternetAddress(sender, "북샵");
			// 2. 수신자 정보 설정
			Address receiverAddress = new InternetAddress(receiver);
			// 3. Message 객체를 통해 전송할 메일에 대한 내용 정보 설정
			// 3-1) 메일 헤더 정보 설정
			mailMessage.setHeader("content-Type", "text/html; charset=UTF-8");
			// 3-2) 발신자 정보 설정
			mailMessage.setFrom(senderAddress);
			// 3-3) 수신자 정보 설정
			mailMessage.addRecipient(RecipientType.TO, receiverAddress);// javax.mail.Message
			// 3-4) 메일 제목 설정
			mailMessage.setSubject(subject);
			// 3-5) 메일 본문 설정
			mailMessage.setContent(content, "text/html; charset=UTF-8");
			// 3-6) 메일 전송 날짜 및 시각 정보 설정(java.util.Date 객체 생성을 통해 시스템 시각 정보로 설정)
			mailMessage.setSentDate(new Date());
			

			// 4. 메일 전송 완료
			// javax.mail.Transport 클래스의 static 메서드 send() 호출
			Transport.send(mailMessage);
			
			// 4-1. 메일 전송 실패 시
		} catch (AddressException e) {
			isError = true;
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			isError = true;
			e.printStackTrace();
		} catch (MessagingException e) {
			isError = true;
			e.printStackTrace();
		} 
		boolean isSendEmail = false;
		// 4-2. 메일 전송 실패하면 Error
		if(isError) {
			// 4-3. 실패하였으니 false로 저장 후 바로 리턴
			model.addAttribute("isSendEmail",isSendEmail);
			
			return "member/join_email_send";
		}

		// 5. 전에 보낸 이메일이 있는지 확인
		EmailAuthVO emailAuth = service.getEmailAuthFromEmail(email);
		
		// 6-1. 그 전에 이메일로 보낸 인증번호가 없다면 인증코드를 DB에 바로 저장
		if(emailAuth == null) {
			isSendEmail = service.sendEmailAuthCode(email, authCode);
		} else {// 6-2. 이메일로 보낸 인증번호가 있다면 인증코드를 DB에 업데이트
			isSendEmail = service.sendEmailAuthCodeUpdate(email, authCode);
		}
		
		// 7. 인증코드가 제대로 저장 되었는 지 확인
		model.addAttribute("isSendEmail",isSendEmail);
		
		return "member/join_email_send";
	}	
	
	
	// 인증코드를 이용한 이메일 확인
	@RequestMapping(value = "/EmailAuthCheck.me", method = RequestMethod.GET)
	public String EmailAuthCheck(@RequestParam(defaultValue = "")String email, @RequestParam(defaultValue = "")String authCode, Model model) {
		EmailAuthVO emailAuth = service.getEmailAuthFromEmail(email);
		
		if(emailAuth.getAuth_code().equals(authCode)) {
			model.addAttribute("isEmailAuth", true);
		} else {
			model.addAttribute("isEmailAuth", false);
		}
		
		return "member/join_email_auth";
	}
	
		
	// 로그인 페이지로 이동
	@RequestMapping(value = "/MemberLogin.me", method = RequestMethod.GET)
	public String LoginForm() {
		return "member/login_form";
	}
	
	
	
	
}
