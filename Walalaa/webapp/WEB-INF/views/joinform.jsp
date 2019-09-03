<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- 위 3개의 메타 태그는 *반드시* head 태그의 처음에 와야합니다; 어떤 다른 콘텐츠들은 반드시 이 태그들 *다음에* 와야 합니다 -->
<title>회원가입</title>

<!-- 부트스트랩 -->
<link
	href="${pageContext.request.contextPath}/assets/bootstrap/css/bootstrap.css"
	rel="stylesheet">

<!-- jQuery (부트스트랩의 자바스크립트 플러그인을 위해 필요합니다) -->
<script type="text/javascript"
	src="${pageContext.request.contextPath}/assets/js/jquery-1.12.4.js"></script>

<!-- 모든 컴파일된 플러그인을 포함합니다 (아래), 원하지 않는다면 필요한 각각의 파일을 포함하세요 -->

<style>
@import url(//fonts.googleapis.com/earlyaccess/jejugothic.css);

form.form-inline>div {
	padding: 10px 0px 10px 0px;
}

.pageset {
	width: 1080px;
	margin: 0 auto;
}

h1 {
	text-align: center;
}

label {
	width: 100px;
	text-align: right;
	padding-right: 10px;
}

.loginformdiv {
	border-top: 1px solid lightgray;
	border-top-style: dotted;
}

.loginformlist {
	font-family: serif;
}
</style>


<script type="text/javascript">
	//----- 중복확인 클릭시
	//----- jquery에서는 #은 아이디 .은 클래스를 표현합니다. $("#ID명") $(".CLASS명")

	//---아이디 중복 체크여부 확인 (아이디 중복일 경우 = 0 , 중복이 아닐경우 = 1 )
	var isCheckId = 0;
	function duplicationId() {
		// 유저 정보를 param.
		var email = $("#email").val();
		console.log(email);
		$.ajax({
			//async: false,
			type : "post",
			url : "duplicationIdCheck.do",
			data : email,
			//dataType : "json",
			//contentType: "charset=UTF-8",
			success : function(data) {
				if (data == "S") {
					alert("사용가능한 아이디입니다.");
					$("#nickname").focus();
					isCheckId = 1;
				} else {
					alert("아이디가 존재합니다. 다른 아이디를 입력해주세요.");
					$("#email").focus();
				}
			},
			error : function(req, status, errThrown) {
				alert("network error occur");
			}
		});
	}

	//---닉네임 중복 체크여부 확인 (아이디 중복일 경우 = 0 , 중복이 아닐경우 = 1 )
	var isCheckNickname = 0;
	function duplicationNickname() {
		// 유저 정보를 param.
		var nickname = $("#nickname").val();
		console.log(nickname);

		$.ajax({
			//async: false,
			type : "post",
			url : "duplicationNicknameCheck.do",
			data : nickname,
			success : function(data) {
				if (data == "S") {
					alert("사용가능한 닉네임입니다.");
					$("#password").focus();
					isCheckNickname = 1;
				} else {
					alert("닉네임이 존재합니다. 다른 닉네임을 입력해주세요.");
					$("#nickname").focus();
				}
			},
			error : function(req, status, errThrown) {
				alert("network error occur");
			}
		});
	}

	function DoSignUp() {
		if (confirm("회원가입을 하시겠습니까?")) {

			//json 객체를 생성
			var json = {
				//m_id의 이름을 가지고 m_id의 id를 가지는 태그의 벨류값을 가져옴 아래도 동일
				email : $("#email").val(),
				password : $("#password").val(),
				nickname : $("#nickname").val()
			};

			//json을 포이치문 돌림
			for ( var str in json) {
				//json[m_id or m_pw]를 돌릴때 길이가 0이면 아래 출력
				if (json[str].length == 0) {
					//str은 json에 변수명을 가지고 #은 아이디 찾는것 attr은 에트류뷰트의 
					//placeholder를 찾는것
					alert($("#" + str).attr("placeholder") + "를 입력해주세요.");
					//포커스를 올려줌
					$("#" + str).focus();
					return;
				}
			}

			if (email.length == 0) {
				alert("이메일을 입력해 주세요.");
				$("#email").focus();
				return false;
			} else if (isCheckId == 0) {
				alert('아이디 중복체크를 해주세요');
				$("#email").focus();
				return false;
			} else if (nickname.length == 0) {
				alert("닉네임을 입력해 주세요.");
				$("#nickname").focus();
				return false;
			} else if (isCheckNickname == 0) {
				alert('닉네임 중복체크를 해주세요');
				$("#nickname").focus();
				return false;
			} else if (password.length == 0) {
				alert("비밀번호를 입력해 주세요.");
				$("#password").focus();
				return false;
			} else {
				alert("회원가입을 축하합니다");
				$("#joinform").submit();
			}
		}
	}
</script>

</head>

<body>
	<jsp:include page="search_navbar.jsp"></jsp:include>

	<div class="pageset">
		<h1>회원가입</h1>
		<div class="loginformdiv" align="center">
			<form class="form-inline" name="joinform" id="joinform"
				action="joininsert.do" method="post">
				<div class="form-group">
					<label for="email" class="control-label">아이디 :</label> <input
						style="width: 280px" type="email" class="form-control"
						name="email" id="email" placeholder="example@example.com" required>
					<input type="button" class="btn" value="중복확인"
						onclick="duplicationId();" />
				</div>
				<br>
				<div class="form-group">
					<label for="nickname" class="control-label joinformlist">닉네임
						:</label> <input style="width: 280px" type="text" class="form-control"
						name="nickname" id="nickname" placeholder="닉네임" required maxlength=6>
					<input type="button" class="btn" value="중복확인"
						onclick="duplicationNickname();" />
				</div>
				<br>
				<div class="form-group" style="padding-right: 82px;">
					<label for="password" class="control-label joinformlist">비밀번호
						:</label><input style="width: 280px" type="password"
						class="form-control loginformlist" name="password" id="password"
						placeholder="" required>
				</div>
				<br>
				<div style="padding-bottom: 0px;">
					<a href="loginform.do">로그인페이지</a>
				</div>
				<div class="form-group" align="center">

					<button class="btn btn-primary btn-lg" onclick="DoSignUp();"
						style="background: #2e9dfe;">회원가입</button>
				</div>
			</form>
		</div>
	</div>