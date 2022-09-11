<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<c:choose>
	<c:when test="${isSendEmail}">
		이메일 인증<span id="good"> 인증번호가 이메일로 전송되었습니다! 인증번호를 확인 해주세요</span>
	</c:when>
	<c:otherwise>
		이메일 인증<span id="fail"> 인증번호 전송에 실패했습니다...</span>
	</c:otherwise>
</c:choose>