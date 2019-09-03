<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- 위 3개의 메타 태그는 *반드시* head 태그의 처음에 와야합니다; 어떤 다른 콘텐츠들은 반드시 이 태그들 *다음에* 와야 합니다 -->


<!-- jQuery (부트스트랩의 자바스크립트 플러그인을 위해 필요합니다aa) -->
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/jquery-1.12.4.js"></script>

	<style>
	@import url(//fonts.googleapis.com/earlyaccess/jejugothic.css);
		
/* 		body{ */
/* 			font-family: 'Jeju Gothic', sans-serif; */
/* 		} */
		.loginformlist {
			font-family: serif;
		}
		
		form.form-inline>div {
			padding: 0px 0px 0px 0px;
		}
		
		.pageset_m {
			width: 100%;
			margin: 0 auto;
		}
		
		h1 {
			text-align: center;
		}
		
		label {
			width: 60%;
			text-align: left;
		}
		
		.loginformdiv {
			border-top: 1px solid lightgray;
			border-top-style: dotted;
		}
	</style>

<script type="text/javascript">

// 로그인시 비밀번호 확인 (일치하는지)
function checkPassword () {
        // 유저 정보를 param.
        var email =  $("#email").val();
        console.log(email);
        var password =  $("#password").val();
        console.log(password);
        
        
        // 공백 처리 ()
        if(email.length == 0) {
            alert("이메일을 입력해 주세요.");
            $("#email").focus();
            return false;
        } if(password.length == 0) {
            alert("비밀번호를 입력해 주세요.");
            $("#password").focus();
            return false;
        }
        
      $.ajax({
         type: "post",
         url: "checkPassword.do",
         data: email,
         success: function (data) {
            if(data == password) {
               $("#loginform").submit();
            } else {
               alert("비밀번호가 일치하지 않습니다");
               $("#password").focus();
            }
         },
         error: function(req, status, errThrown) {
            alert("값을 입력하세요");
         }
      });
   }
</script>


<title>로그인페이지</title>
</head>
<body>

	<jsp:include page="search_navbar_m.jsp"></jsp:include>


	<div class="pageset_m">
		<h1>로그인</h1>
		<div class="loginformdiv" align="center">
			<form class="form-inline" name="loginform" action="login_m.do"
				method="post">
				<div class="form-group" style="margin-bottom: 0px; padding-top: 10px;">
					<label for="email" class="control-label">아이디</label> 
					<input style="width: 80%;" type="email" class="form-control loginformlist" id="email"
						name='email' placeholder="example@example.com">
				</div>
				<br>
				<div class="form-group" style="margin-bottom: 5px;">
					<label for="password" class="control-label">비밀번호</label>
					<input style="width: 80%;" type="password"
						class="form-control loginformlist" id="password" name='password'>
				</div>
				<br>
				<div style="display: flex; padding-left: 30%;">
					<div style="padding-right: 3%; width: 25%;" >
					<button type="button" class="btn btn-primary btn-lg"
							onclick="parent.location.href='joinform_m.do'"  style="background: #2e9dfe; padding: 0px; width:100%;">가입</button>
					</div>
					<div class="form-group" align="center" style="width: 25%;">
						<button type="submit" class="btn btn-primary btn-lg"
							onclick="checkPassword();"  style="background: #2e9dfe;padding: 0px; width:100%; ">입장</button>
					</div>
				</div>
			</form>
		</div>
	</div>

</body>
</html>