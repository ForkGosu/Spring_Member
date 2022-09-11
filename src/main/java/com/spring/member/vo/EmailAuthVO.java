package com.spring.member.vo;

/*
create table email_auth(
email VARCHAR(64) unique not null,
auth_code VARCHAR(20) 
);
 */

public class EmailAuthVO {
	private String email;
	private String auth_code;
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getAuth_code() {
		return auth_code;
	}
	public void setAuth_code(String auth_code) {
		this.auth_code = auth_code;
	}
	@Override
	public String toString() {
		return "EmailAuthVO [email=" + email + ", auth_code=" + auth_code + "]";
	}
}
