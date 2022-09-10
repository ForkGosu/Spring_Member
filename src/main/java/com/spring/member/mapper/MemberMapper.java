package com.spring.member.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.spring.member.vo.MemberVO;

@Mapper
public interface MemberMapper {

	public MemberVO getMemberFromId(@Param("id")String id);

	public MemberVO getMemberFromEmail(@Param("email")String email);

}
