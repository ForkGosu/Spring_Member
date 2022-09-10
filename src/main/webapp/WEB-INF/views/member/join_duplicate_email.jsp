<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<c:choose>
	<c:when test="${empty member}">
		이메일<span id="success"> 사용가능한 이메일입니다!</span>
	</c:when>
	<c:otherwise>
		이메일<span id="fail"> 이미 사용하고 있는 이메일입니다...</span>
	</c:otherwise>
</c:choose>