<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<!-- jQuery (부트스트랩의 자바스크립트 플러그인을 위해 필요합니다) -->
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/jquery-1.12.4.js"></script>
<!-- 모든 컴파일된 플러그인을 포함합니다 (아래), 원하지 않는다면 필요한 각각의 파일을 포함하세요 -->

   <style>
      table.findpassword_table {
         margin: 20px auto;
         width: 80%;
      }
      
      tr td {
         padding-bottom: 15px;
      }
      td.findpasswordlist {
         text-align: center;
      }
      .pageset {
         width: 1080px;
         margin: 0 auto;
      }
      h1 {
         text-align: center;
      }
   </style>
<title>비밀번호 찾기</title>
</head>
<body>

   <jsp:include page="search_navbar.jsp"></jsp:include>
   
   <div class="pageset">
      <h3 style="text-align: center;">비밀번호찾기</h3>
      <div class="loginformdiv" align="center">
         <form class="form-inline" name="loginform" action="#" method="post">
            <div class="form-group">
               <label style="margin-right: 20px;" for="inputEmail" class="control-label">아이디:</label>
               <input type="email" class="form-control" style="width: 285px; margin:15px 0px 15px 0px;" id="inputEmail" placeholder="example@example.com">
            </div>
         <br>
            <div>
               <a href="loginform.do">로그인페이지</a>      
            </div>
            <div class="form-group" align="center">   
               <button style= "margin-top: 5px;" id="findpw_btn"type="button" class="btn btn-primary">비밀번호찾기</button>
               
            </div>   
         </form>
      </div>
   </div>
   <script>
   	$("#findpw_btn").on("click", function(){
   		var email = $("#inputEmail").val();
   		$.ajax({
            type: "post",
            url: "${pageContext.request.contextPath}/findpw.do",
            data : {email:email},
            success : function(data) {
            	alert(email + "의 비밀번호는 : " + data + "입니다.");
            }
         });
      });
   
   </script>
   
</body>
</html>