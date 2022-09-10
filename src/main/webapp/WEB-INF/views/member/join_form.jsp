<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<link href="resources/css/nomal.css" rel="stylesheet">
<!-- 다음 우편번호 API 포함시키기 -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="resources/js/jquery-3.6.0.js"></script>
<script type="text/javascript">
// Ajax를 이용한 id와 email 중복 확인
$(function() {
	// 아이디 중복 확인
	$("#idCheck").change(function() {
		let id = document.fr.id.value;
		if(id.length < 5 || id.length > 20){
			$(".id").html("아이디<span id='fail'> 아이디를 5~20자리로 입력해주십시오</span>");
			return;
		}
		$.ajax({
			type: "get",
			url: "IdDuplicate.me",
			data: {
				id: id
			},
			dataType: "text",
			success: function(response) {
				$(".id").html(response);
			}
		});
	});
	// 이메일 중복 확인
	$("#emailCheck").on("click", function() {
		let email = document.fr.email.value + '@' + document.fr.email2.value;
		$.ajax({
			type: "get",
			url: "EmailDuplicate.me",
			data:  {
				email: email
			},
			dataType: "text",
			success: function(response) {
				$(".email").html(response);
			}
		});
	});
	
	// 비밀번호 입력 처리
	$("#passwdCheck").change(function() {
		let passwd = document.fr.passwd.value;
		if(passwd.length < 8 || passwd.length > 16){
			$(".passwd").html("비밀번호<span id='fail'> 비밀번호를 8~16자리로 입력해주십시오</span>");
			return;
		} else {
			$(".passwd").html("비밀번호<span id='success'> 사용가능한 비밀번호 입니다!</span>");
			return;
		}
	});
	// 비밀번호 확인 처리
	$("#passwdCheck2").change(function() {
		let passwd = document.fr.passwd.value;
		let passwd2 = document.fr.passwd2.value;
		if(passwd2 != passwd){
			$(".passwd2").html("비밀번호 확인<span id='fail'> 비밀번호가 일치하지 않습니다.</span>");
			return;
		} else {
			$(".passwd2").html("비밀번호 확인<span id='success'> 확인 완료!</span>");
			return;
		}
	});
});
	
	// 중복체크 - 아이디 조금이라도 바뀌면 X 표시
	function checkIdOnkeydown() {
		var spanCheckIdResult = document.getElementById("duplicate");
		spanCheckIdResult.innerHTML = " 중복체크 X";
		spanCheckIdResult.style.color = "RED";
	}
	
	// 비밀번호 길이 판별
	function checkPasswdLength() {
		// 입력된 패스워드가 8자리 ~ 16자리 사이가 아닐 경우
		if(document.fr.user_passwd.value.length < 8 || document.fr.user_passwd.value.length > 16) {
			alert("패스워드는 8~16자리 필수!");
			document.fr.user_passwd.select();
		}
	}
	
	// 비밀번호 & 비밀번호확인란이 같은지 판별(패스워드확인란 글자 입력할 때마다 호출 = onkeyup)
	function checkConfirmPasswd() {
		// 결과를 표시할 span 태그 영역 객체 가져오기
		let confirmPasswdResult = document.getElementById("confirmPasswdResult");
		// 입력된 두 패스워드 가져오기
		let passwd = document.fr.user_passwd.value;
		let passwd2 = document.fr.user_passwd2.value;
		
		// 두 패스워드 비교
		if(passwd == passwd2) {
			confirmPasswdResult.innerHTML = "비밀번호 일치";
			confirmPasswdResult.style.color = "GREEN";
		} else {
			confirmPasswdResult.innerHTML = "비밀번호 불일치";
			confirmPasswdResult.style.color = "RED";
		}
	}
	
	// ------------------------------------------------------------------------------------
	// 다음 우편번호 API 추가
	function execDaumPostcode() {
		 new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var roadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 참고 항목 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById("postcode").value = data.zonecode;
                document.getElementById("roadAddress").value = roadAddr;
//                 document.getElementById("sample4_jibunAddress").value = data.jibunAddress;
            }
		 
        }).open();
	}
	
	// 회원가입 완료 시 확인용
	function checkSubmit(){
		// 중복이면 가입 X
		if(document.getElementById("duplicate").innerHTML == " 중복체크 X"){
			alert("이메일 중복체크를 하지않았습니다!");
			document.fr.user_email.select();
			return false;
		}
		// 비밀번호가 일치하지 않으면 가입 X
		if(document.getElementById("confirmPasswdResult").innerHTML == "비밀번호 불일치"){
			alert("비밀번호가 다릅니다!");
			document.fr.user_passwd.select();
			return false;
		}
		return true;
		
	}
	
</script>
</head>
<body>
<section class="centerSection1">
	<!-- 로고지역 -->
	<section class="logo" >
		<a href="./"><img alt="로고" src="resources/images/main_logo.png" width="300px"></a>
	</section>
	<!-- 로고지역 끝 -->
	
	<section>
		<form action="UserJoinPro.us" onsubmit="return checkSubmit()" method="post" name="fr">
			<h1>회원가입</h1>
			
			<h3>이름</h3>
			<input class="input1 inputAble" type="text" name="name" required="required">
			
			<h3 class="id">아이디<span id="fail"> 아이디를 입력하세요.</span></h3>
			<input id="idCheck" class="input1 inputAble" type="text" name="id" required="required">
			
			<h3 class="email">이메일<span id="fail"> 이메일을 입력하세요.</span></h3>
			<div class="inputGroups">
				<div class="inputGroup">
					<input class="input1 inputAble" type="text" name="email" required="required">
				</div>
				<div class="inputGroupDot">
					@
				</div>
				<div class="inputGroup">
					<input class="input1 inputAble" type="text" name="email2" required="required">
				</div>
				<div class="inputGroup">
					<input id="emailCheck" class="input1 button1" type="button" value="인증번호">
				</div>
			</div>
				
			<h3 class="passwd">비밀번호</h3>
			<input id="passwdCheck" class="input1 inputAble" type="password" name="passwd" placeholder="8 ~ 16글자 사이 입력" 
						required="required" maxlength="16">
			
			<h3 class="passwd2">비밀번호확인</h3>
			<input id="passwdCheck2" class="input1 inputAble" type="password" name="passwd2" placeholder="8 ~ 16글자 사이 입력" 
							required="required" maxlength="16">
							<span id="confirmPasswdResult"></span>
		 
			<h3>우편 번호 및 도로명 주소</h3>
		 	<div class="inputGroups">
		 		<div class="inputGroup">
					<input class="input1 inputAble" type="text" class="input2 inputAble" id="postcode" name="address_code" placeholder="우편번호" required="required" readonly="readonly" onclick="execDaumPostcode()">
				</div>
		 		<div class="inputGroupThirty">
					<input class="input1 button1" type="button" class="input2 inputAble" onclick="execDaumPostcode()" value="우편번호 찾기">
				</div>
			</div>
			<input type="text" class="input1 inputAble" id="roadAddress" name="address"  placeholder="도로명주소" required="required" readonly="readonly" onclick="execDaumPostcode()">
			<h3>상세 주소</h3>
			<input type="text" class="input1 inputAble" id="detailAddress" name="address2"  placeholder="상세주소" required="required">
			
			<h3>휴대폰</h3>
			<input class="input1 inputAble" type="text" name="phone" maxlength="11" placeholder="-없이 숫자만 입력" required="required">
			
			<h3>주민번호</h3>
			<div class="inputGroups">
				<div class="inputGroup">
					<input class="input1 inputAble" type="text" name="jumin" required="required" maxlength="6">
				</div>
				<div class="inputGroupDot">
					-
				 </div>
				<div class="inputGroup">
					<input class="input1 inputAble" type="password" name="jumin2" required="required" maxlength="7">
				</div>
			</div>
			
			<h3>성별</h3>
			<div class="select">
				<input type="radio" id="남" name="gender" checked="checked"><label for="남">남자</label>
				<input type="radio" id="여" name="gender"><label for="여">여자</label>
			</div>
			
			<input class="input1 button1" type="submit" value="가입하기">
		</form>
	</section>
</section>
</body>
</html>

















    