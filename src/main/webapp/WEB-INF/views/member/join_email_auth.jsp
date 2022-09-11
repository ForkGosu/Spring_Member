<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<c:choose>
	<c:when test="${isEmailAuth}">
		이메일 인증<span id="success"> 인증번호 확인이 완료되었습니다!</span>
	</c:when>
	<c:otherwise>
		이메일 인증<span id="good"> 인증번호를 다시 확인 해 주세요...</span>
	</c:otherwise>
</c:choose>