<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- 위 3개의 메타 태그는 *반드시* head 태그의 처음에 와야합니다; 어떤 다른 콘텐츠들은 반드시 이 태그들 *다음에* 와야 합니다 -->
<title>유저 채팅 관리창</title>

<!-- 부트스트랩 -->
<link href="${pageContext.request.contextPath}/assets/bootstrap/css/bootstrap.css" rel="stylesheet">
<!-- jQuery (부트스트랩의 자바스크립트 플러그인을 위해 필요합니다) -->
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/jquery-1.12.4.js"></script>

<style>
   @import url(//fonts.googleapis.com/earlyaccess/jejugothic.css);
   
   body {
	padding: 0px;
	margin: 0px;
	font-family: 'Jeju Gothic';
	font-size: 16px;
   }
   
   .pageset {
      width: 900px;
      margin: 0 auto;
   }
   
   .bigFont {
      color: #2e9dfe;
      font-size: 20px;
      margin-bottom: 5px;
   }
   
   #topchat{
   		margin-top: 5px;
   		text-align: center;
   }
   
   .msginput {
      background-color: white;
   /*    border-bottom-color: #2e9dfe; */
      border: none; 
   }
   
   .msginput:hover {
      background-color: #c5f0f7;
      font-style: oblique;
      border: none; 
   }
   
   .btnstyle {
      background-color: #2e9dfe;
   }
   
   .time{
   		color: gray;
   }
   
</style>

<script type="text/javascript">
   var userchats = "${userchat}";

   userchats = userchats.substr(1);   // 글자를 감싸고 있는 [ 빼기
   userchats = userchats.substr(0, userchats.length-1); // 글자를 감싸고 있는 ] 빼기
   var userchat = userchats.split(", ");   // 각각의 채팅 끊기
   
   var str = "";
   var str_user = "";
   var id = "";
   
   var num=0; // label과 체크박스 같이 누르게 할 변수
   

   $(document).ready(function() {
      
      for(var i=0; i<userchat.length; i++){
         var msg = userchat[i].split("&/%!");
            
         id = msg[0];
         if(msg.length ==3){
        	 
         showChat(msg[1], msg[2], msg[0]);   // 채팅내용, 시간, 유저이메일
         }else{
        	 showChat(msg[1], msg[3], msg[0]);   // 채팅내용, 시간, 유저이메일
         }
      }
      
      $.ajax({
         url: "${pageContext.request.contextPath}/getUserInfo.do",
           type: "post",
           data : {id : id},
         success: function(userVO){
           showUser(userVO.nickname, id);   
           $("#showUserInfo").append(str_user);
        } , 
        error : function(XHR, status, error) {
              console.error(status + " : " + error);
          } 
      });
      
      
      $("#showUserChat").append(str);
   });

   function showUser(nickname, email) {
     str_user += " <div style='border-bottom: solid 1px lightgray; padding-bottom: 5px; padding-top: 5px;' >";
     str_user += "    <img src='${pageContext.request.contextPath}/assets/images/user.png'> " + nickname + "님의 채팅 모아보기 ";
     str_user += "    <button class='doNochat btn' data-email='"+email+"' style='float: right;'>채팅금지</button>";
     str_user += " </div>";
   }
   
   function showChat(msg, time, email) {
     var hour = time.substr(8,2)+":";
     var min = time.substr(10,2)+":";
     var sec = time.substr(12,2);
     
      str += "<div style='display:flex; font-size: 17px; padding-left:15px; padding-right:0px; ' >";
      str += "    <div style='width: 800px; height: 30px; ' >";
      str += "       <label for ='list"+num+"' class='msginput' style='width: 700px; height: 30px; cursor:pointer'>"+msg+"</label>";
      str += "       <input id ='list"+num+"' type='checkbox' name='chatselect' style='width: 30px; ' value="+email+" >";
      str += "    </div>";
      str += "    <div class='time'>";
      str += "    " + hour+min+sec;
      str += "    </div>";
      str += "</div>";
      num++;
   }
</script>

<script type="text/javascript">
   function btn_js_report_click() {
      /* confirm(문자열, 초기값) */
      var check = confirm("정말로 신고하시겠습니까?\n허위 신고시 제재를 받을 수 있습니다");
      /* if(check == true) else false */
      if (check)
         alert("신고되었습니다");
   }
   function btn_js_delete_click() {
      /* confirm(문자열, 초기값) */
      var check = confirm("정말로 삭제하시겠습니까?");
      /* if(check == true) else false */
      if (check)
         alert("삭제되었습니다");
   }
</script>

</head>
<body>
   <%--    <jsp:include page="/WEB-INF/views/search_navbar.jsp"></jsp:include> --%>


   <div class="pageset">
      <div id="topchat"><b class="bigFont"> 사용자 채팅 모아보기 </b></div>
      <div id="showUserInfo"></div>
      
      <div id="showUserChat"></div>

      <div style="margin-top: 5px; margin-right: 10px; border-top: solid 1px lightgray">
         <input class="btn btn-primary btn-lg btnstyle" type="button" value="신고" name="btn_js_report" id="btn_js_report" onclick="btn_js_report_click();" style="float: right; margin-top: 5px;"> 
      </div>
   </div>


   <script>
   $("#showUserInfo").on('click', '.doNochat', function(){
      var $this = $(this);
        var email = $this.data("email");
        
        $.ajax({
           type: "post",
           url: "${pageContext.request.contextPath}/Nochat.do",
           data : {email:email},
           success : function() {
              alert("사용자의 채팅이 금지되었습니다.");
           }
        });
   });
   </script>
   
</body>
</html>