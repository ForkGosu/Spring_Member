<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
<title>Home</title>
<link href="resources/css/nomal.css" rel="stylesheet">
</head>
<body>
<header>
	<section class="top">
		<section class="logo">
			<div><a href="./"><img alt="로고" src="resources/images/main_logo.png" height="65px"></a></div>
		</section>
		<section class="memberSection">
			<div><a href="MemberLogin.me"><img src="resources/images/login.png" width="65px" height="65px"><br>로그인</a></div>
			<div><a href="MemberJoin.me"><img src="resources/images/join.png" width="65px" height="65px"><br>회원가입</a></div>
		</section>
	</section>
</header>
<h1>
	Hello world!  
</h1>

<P>  The time on the server is ${serverTime}. </P>
</body>
</html>
