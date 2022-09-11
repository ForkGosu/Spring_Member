<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
			<c:if test="${empty sId}">
				<div class="logoutStatus">
					<div><a href="MemberLogin.me"><img src="resources/images/login.png" width="80px" height="80px"><br>로그인</a></div>
					<div><a href="MemberJoin.me"><img src="resources/images/join.png" width="80px" height="80px"><br>회원가입</a></div>
				</div>
			</c:if>
			<c:if test="${!empty sId}">
				<div class="loginStatus">
					<div class="info_area">
						<!--  로그아웃 하이퍼링크 -->
						<a href="MemberLogoutPro.me" class="btn_logout">로그아웃</a>
						<!-- 사용자 아이콘 -->
						<a href="" class="user_thumb"><img alt="" src="resources/images/myInfo.gif" width="56" height="56"></a>
						<!-- 유저 ID, 이메일, 등등 -->
						<div class="user_info">
							<a href="" class="name">${sName }</a><br>
							<div class="id">${sId }</div>
						</div>
					</div>
					<div class="tab_area">
						<div class="tab_box">
							<a href="" class="tab">마이페이지</a>
							<a href="" class="tab">주문/배송</a>
							<a href="" class="tab">장바구니</a>
							<a href="" class="tab">내리뷰관리</a>
						</div>
					</div>
				</div>
			</c:if>
		</section>
	</section>
</header>
<h1>
	Hello world!  
</h1>

<P>  The time on the server is ${serverTime}. </P>
</body>
</html>
