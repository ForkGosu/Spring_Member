package com.spring.member.vo;

import java.sql.Date;

/*
create table member(
date date not null,
id varchar(20) not null,
email varchar(64) unique not null,
passwd varchar(32) not null,
gender varchar(1) not null,
jumin varchar(14) not null,
phone varchar(20) not null,
address_code int not null,
address varchar(100) not null,
auth varchar(1) not null
);
 */
public class MemberVO {
	private Date date;
	private String id;
	private String email;
	private String passwd;
	private String gender;
	private String jumin;
	private String phone;
	private int address_code;
	private String address;
	private String auth;
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPasswd() {
		return passwd;
	}
	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getJumin() {
		return jumin;
	}
	public void setJumin(String jumin) {
		this.jumin = jumin;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public int getAddress_code() {
		return address_code;
	}
	public void setAddress_code(int address_code) {
		this.address_code = address_code;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getAuth() {
		return auth;
	}
	public void setAuth(String auth) {
		this.auth = auth;
	}
	
	@Override
	public String toString() {
		return "MemberVO [date=" + date + ", id=" + id + ", email=" + email + ", passwd=" + passwd + ", gender="
				+ gender + ", jumin=" + jumin + ", phone=" + phone + ", address_code=" + address_code + ", address="
				+ address + ", auth=" + auth + "]";
	}
}
