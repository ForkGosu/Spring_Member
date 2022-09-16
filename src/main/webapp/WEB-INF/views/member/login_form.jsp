 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<link href="resources/css/nomal.css" rel="stylesheet">
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script>
Kakao.init('75f1a2ca32c44d02a134ab704b75e428'); //발급받은 키 중 javascript키를 사용해준다.

// 카카오 로그인에서 설정한 RedirectURI를 사용 할 수 있다(10개 까지 지정 가능)
// Kakao.Auth.authorize({
// 	redirectUri: "http://localhost:8080/member/KakaoLoginPro.me",
// });

console.log(Kakao.isInitialized()); // sdk초기화여부판단
//카카오로그인
function kakaoLogin() {
    Kakao.Auth.login({
//       scope:'profile_nickname, profile_image, account_email, gender, birthday',
      success: function (authObj) {
        Kakao.API.request({
          url: '/v2/user/me', //버전2의 user me로 url을 쓰면 유저의 정보를 들고 온다
          success: function (res){
        	  console.log(res);
        	  const id = res.id;
        	  const email = res.kakao_account.email;
        	  const name = res.properties.nickname;
        	  const birthday = res.kakao_account.birthday;
        	  
        	// 할수도 있지만 취약해서 RestAPI를 사용 한다고 한다
        	  location.href="KakaoLoginPro.me?id="+id+"&name="+name+"&email="+email+"&birthday="+birthday; 
          },
          fail: function (error) {
            console.log(error)
          },
        })
        console.log(authObj);
        var token = authObj.access_tokken;
      },
      fail: function (error) {
    	alert("카카오 로그인 오류입니다!");
        console.log(error)
      },
    })
  }
//카카오로그아웃  
function kakaoLogout() {
    if (Kakao.Auth.getAccessToken()) {
      Kakao.API.request({
        url: '/v1/user/unlink',
        success: function (response) {
        	console.log(response)
        },
        fail: function (error) {
          console.log(error)
        },
      })
      Kakao.Auth.setAccessToken(undefined)
    }
  }  
</script>
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
		<a onclick="kakaoLogin();" href="javascript:void(0)">카카오톡으로 로그인</a> |
		<a onclick="kakaoLogout();" href="javascript:void(0)">카카오톡으로 연결끊기</a>
	</nav>
	<!-- 부가 옵션 지역 끝 -->
	
</section>
</body>
</html>