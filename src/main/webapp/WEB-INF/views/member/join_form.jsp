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
// Ajax를 이용한 id와 email 중복 확인 및 메일 보내기 ////////////////////////////////////////////////////////////////////
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
	// 이메일 중복 확인 후 이메일 전송
	var isMailSend=false;
	var isMailAuth=false;
	$("#emailCheck").on("click", function() {
		// 이메일 중복 확인 후 이메일 전송 - 이메일 전송 중이 아니라면 클링 불가능(오류 방지)
		if(isMailSend){
			alert("이메일 전송 중 입니다!!!");
		}
		// 이메일 인증 확인 후 이메일 전송 - 이메일 확인 완료 됬으면 클링 불가능(오류 방지)
		if(isMailAuth){
			alert("이메일 확인이 완료되었습니다!!!");
			return;
		}
		
		if(document.fr.email.value == "" || document.fr.email2.value == ""){
			$(".email").html("이메일<span id='fail'> 이메일을 제대로 입력해주십시오</span>");
			return;
		}
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
				// 이메일 중복 확인 완료시
				if($(".email").find('#success').text() != ""){
					$("#email").attr("readonly", true);
					$("#email2").attr("readonly", true);

					$("#email").removeAttr("class");
					$("#email2").removeAttr("class");
					
					$("#email").attr("class", "input1 inputUnable");
					$("#email2").attr("class", "input1 inputUnable");
					$(".emailAuth").html('이메일 인증<span id="fail"> 인증번호를 전송중 입니다. 기다려주세요...</span>');
					// 이메일 중복 확인 완료시 메일 보내기 Ajax (오류 방지를 위해 잠시 중지 걸어 둠)
					isMailSend=true;
					$.ajax({
						type: "get",
						url: "EmailAuthSend.me",
						data:  {
							email: email
						},
						dataType: "text",
						success: function(response) {
							$(".emailAuth").html(response);
							isMailSend = false;
						}
					});
					
				}
			}
		});
	});
	// 이메일 인증번호 확인
	$("#emailAuthCheck").on("click",function() {
		// 이메일 중복 확인 후 이메일 전송 - 이메일 전송 중이 아니라면 클링 불가능(오류 방지)
		if(isMailSend){
			alert("이메일 전송 중 입니다!!!");
		}
		// 이메일 인증 확인 후 이메일 전송 - 이메일 확인 완료 됬으면 클링 불가능(오류 방지)
		if(isMailAuth){
			alert("이메일 확인이 완료되었습니다!!!");
			return;
		}
		let email = document.fr.email.value + '@' + document.fr.email2.value;
		if($(".email").find('#success').text() == ""){
			$(".emailAuth").html("이메일<span id='fail'> 이메일 중복체크부터 해주세요...</span>");
			return;
		}
		let authCode = document.fr.authCode.value;
		if(document.fr.authCode.value == ""){
			$(".emailAuth").html("이메일<span id='good'> 인증코드가 입력되지 않았습니다...</span>");
			return;
		}
		$.ajax({
			type: "get",
			url: "EmailAuthCheck.me",
			data:  {
				email : email,
				authCode: authCode
			},
			dataType: "text",
			success: function(response) {
				$(".emailAuth").html(response);
				// 인증번호 완료 시
				if($(".emailAuth").find('#success').text() != ""){
					$("#authCode").attr("readonly", true);
					$("#authCode").removeAttr("class");
					$("#authCode").attr("class", "input1 inputUnable");
					isMailAuth=true;
				}
			}
		});
	});
	
	// 비밀번호 입력 처리
	$("#passwdCheck").change(function() {
		let passwd = document.fr.passwd.value;
		let passwd2 = document.fr.passwd2.value;
		if(passwd.length < 8 || passwd.length > 16){
			$(".passwd").html("비밀번호<span id='fail'> 비밀번호를 8~16자리로 입력해주십시오</span>");
			return;
		} else {
			$(".passwd").html("비밀번호<span id='success'> 사용가능한 비밀번호 입니다!</span>");
			if(passwd2 != passwd){
				$(".passwd2").html("비밀번호 확인<span id='fail'> 비밀번호가 일치하지 않습니다.</span>");
				return;
			} else {
				$(".passwd2").html("비밀번호 확인<span id='success'> 확인 완료!</span>");
				return;
			}
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
//Ajax를 이용한 id와 email 중복 확인 및 메일 보내기 끝 ////////////////////////////////////////////////////////////////////
 
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
				// document.getElementById("sample4_jibunAddress").value = data.jibunAddress;
            }
		 
        }).open();
	}
	
	// 회원가입 완료 시 확인용
	function checkSubmit(){
		if($(".id").find('#success').text() == ""){
			alert("아이디 중복체크가 완료되지 않았습니다.");
			$("#idCheck").focus();
			return false;
		}
		if($(".email").find('#success').text() == ""){
			alert("이메일 중복체크가 완료되지 않았습니다.");
			$("#emailCheck").focus();
			return false;
		}
		if($(".emailAuth").find('#success').text() == ""){
			alert("이메일 인증이 완료되지 않았습니다.");
			$("#emailAuthCheck").focus();
			return false;
		}
		if($(".passwd").find('#success').text() == ""){
			alert("비밀번호가 8~16 글자 사이가 아닙니다.");
			$("#passwdCheck").focus();
			return false;
		}
		if($(".passwd2").find('#success').text() == ""){
			alert("비밀번호가 일치하지 않습니다.");
			$("#passwdCheck2").focus();
			return false;
		}
		if($("#postcode").val() == ""){
			alert("우편 번호 및 도로명 주소를 입력하지 않았습니다.");
			$("#postcodeCheck").focus();
			return false;
		}
		if($("#postcode").val() == ""){
			alert("우편 번호 및 도로명 주소를 입력하지 않았습니다.");
			$("#postcodeCheck").focus();
			return false;
		}
		if($("#phone").val().length != 11){
			alert("휴대폰 번호는 11자리 이여야 합니다");
			$("#phone").focus();
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
		<form action="MemberJoinPro.us" onsubmit="return checkSubmit()" method="post" name="fr">
			<h1>회원가입</h1>
			
			<h3>이름</h3>
			<input class="input1 inputAble" type="text" placeholder="이름입력" name="name" required="required">
			
			<h3 class="id">아이디<span id="fail"> 아이디를 입력하세요.</span></h3>
			<input id="idCheck" class="input1 inputAble" type="text" name="id" required="required" placeholder="아이디 입력"  maxlength="16">
			
			<h3 class="email">이메일<span id="fail"> 이메일을 입력하세요.</span></h3>
			<div class="inputGroups">
				<div class="inputGroup">
					<input id="email" class="input1 inputAble" type="text" name="email" placeholder="이메일 입력" required="required">
				</div>
				<div class="inputGroupDot">
					@
				</div>
				<div class="inputGroup">
					<input id="email2" class="input1 inputAble" type="text" name="email2" placeholder="example.com" required="required">
				</div>
				<div class="inputGroup">
					<input id="emailCheck" class="input1 button1" type="button" value="인증번호 보내기">
				</div>
			</div>
			
			<h3 class="emailAuth">이메일 인증<span id="fail"> 이메일을 인증하세요.</span></h3>
			<div class="inputGroups">
				<div class="inputGroup">
					<input id="authCode" class="input1 inputAble" type="text" name="authCode" placeholder="이메일 인증 번호 입력" required="required">
				</div>
				<div class="inputGroup">
					<input id="emailAuthCheck" class="input1 button1" type="button" value="인증번호 확인">
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
					<input id="postcode" class="input1 inputUnable" type="text" class="input2 inputAble" id="postcode" name="address_code" placeholder="우편번호" required="required" readonly="readonly" onclick="execDaumPostcode()">
				</div>
		 		<div class="inputGroupThirty">
					<input id="postcodeCheck" class="input1 button1" type="button" class="input2 inputAble" onclick="execDaumPostcode()" value="우편번호 찾기">
				</div>
			</div>
			<input type="text" class="input1 inputUnable" id="roadAddress" name="address"  placeholder="도로명주소" required="required" readonly="readonly" onclick="execDaumPostcode()">
			<h3>상세 주소</h3>
			<input type="text" class="input1 inputAble" id="detailAddress" name="address2"  placeholder="상세주소" required="required">
			
			<h3>휴대폰</h3>
			<input id="phone" class="input1 inputAble" type="text" name="phone" maxlength="11" placeholder="-없이 숫자만 입력" required="required" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">
			
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

















    