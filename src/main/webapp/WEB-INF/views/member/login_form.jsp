 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<link href="resources/css/nomal.css" rel="stylesheet">
</head>
<body>
<section class="centerSection1">
	<!-- 메인 로고 지역 -->
	<section class="logo" >
		<a href="./"><img alt="로고" src="resources/images/main_logo.png" width="300px"></a>
	</section>
	<!-- 메인 로고 지역 끝 -->
	
 	<!-- 로그인 지역 -->
 	<section>
		<h1>로그인</h1>
		
		<form action="MemberLoginPro.me" method="post" id="join">
			<h3>아이디</h3>
			<input type="text" class="input1 inputAble" required="required" name="id" placeholder="아이디" title="아이디입력">
			<h3>비밀번호</h3>
			<input type="password" class="input1 inputAble" required="required" name="passwd" placeholder="비밀번호" title="비밀번호입력">
			<input type="submit" class="input1 button1" value="로그인" class="submit">
		</form>
 	</section>
 	<!-- 로그인 지역 끝 -->
	
	<!-- 부가 옵션 지역 -->
	<nav>
		<a href="./">아이디 찾기</a> |
		<a href="./">비밀번호 찾기</a>
	</nav>
	<!-- 부가 옵션 지역 끝 -->
	
</section>
</body>
</html>