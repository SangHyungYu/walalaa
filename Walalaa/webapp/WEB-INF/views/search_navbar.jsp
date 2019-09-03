<%@page import="com.utf18.site.vo.UserVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- 위 3개의 메타 태그는 *반드시* head 태그의 처음에 와야합니다; 어떤 다른 콘텐츠들은 반드시 이 태그들 *다음에* 와야 합니다 -->

<!-- 파비콘 설정 (웹사이트 상단 탭 이미지)-->
<link rel="shortcut icon" href="${pageContext.request.contextPath}/assets/images/favicon.ico">

<!-- 로고 애니메이션 효과 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/wickedcss/wickedcss.css">



<!-- 부트스트랩 -->
<link href="${pageContext.request.contextPath}/assets/bootstrap/css/bootstrap.css" rel="stylesheet">

<!-- jQuery (부트스트랩의 자바스크립트 플러그인을 위해 필요합니다) -->
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/jquery-1.12.4.js"></script>
<!-- 모든 컴파일된 플러그인을 포함합니다 (아래), 원하지 않는다면 필요한 각각의 파일을 포함하세요 -->
<script   src="${pageContext.request.contextPath}/assets/bootstrap/js/bootstrap.js"></script>
<!-- <script type="text/javascript" src="js/bootstrap.min.js"></script> -->

 <style type="text/css">
@import url(//fonts.googleapis.com/earlyaccess/jejugothic.css);

/*    써치 빠 입력부분 */
   .searchtxt {
   padding: 10px 10px 10px 40px;
   width:600px;
   height: 40px;
   border: 2px solid #2e9dfe;
   border-right: none;
   border-radius: 30px 0 0 30px;
   font-size: 20px; 
   }
   
/*    써치 바 전송버튼 부분 */
   .searchbtn {
   margin: 0;
   border: none;
   padding: 0 20px;
   height: 40px;
   border-radius: 0 30px 30px 0;
   font-size: 12px;
/*    부트스트랩 기본색 #337ab7  밝은파란색 2e9dfe*/
   background: url(${pageContext.request.contextPath}/assets/images/search-icon-white-m.png) 10px center no-repeat #2e9dfe;
   color: #fff;
   vertical-align: bottom;
   }
      
/*    [호버] 써치 바 전송버튼 */
   .searchbtn:hover {
   background: url(${pageContext.request.contextPath}/assets/images/search-icon-white-m.png) 10px center no-repeat #337ab7;

   }
   
/*    로그인했을 때 나오는 프로필 이미지(아이콘) */
   #btn_profile{
   margin-top: -2px;
   	background: url(${pageContext.request.contextPath}${login.profile});
   	background-size: 40px;
   	background-repeat: no-repeat;
   }
   
/*    방송하기 버튼 호버 */
   .broadcast_img_swap img:last-child{display:none;}
   .broadcast_img_swap:hover img:first-child{display:none;}
   .broadcast_img_swap:hover img:last-child{display:inline-block;}
   </style>


   <script type="text/javascript">
      function broadcast_setting() {
         location.href = "broadcast_setting.do";
      }
   
      function broadcast_finish() {
         location.href = "broadcast_finish.do";
      }
   
      function btn_js_broadcast_finish_click() {
         /* confirm(문자열, 초기값) */
         var check = confirm("정말로 방송을 종료하시겠습니까?\n방송종료시 실시간 채팅은 비활성화됩니다");
         /* if(check == true) else false */
         if (check)
            alert("방송이 종료되었습니다");
      }
   </script>

   
   <style type="text/css">
body {
   margin-top: 10px;
   font-family: 'Jeju Gothic', sans-serif;
}

.navmenu {
   width: 240px;
   position: relative;
   vertical-align: middle;
}

.logo {
   margin-right: 20px;
}

.topbar {
   width: 1080px;
   height: 45px;
   display: flex;
   margin: 0 auto;
}

.dropdown {
   display: flex;
}

ul {
   list-style: none;
}

hr {
   margin-top: 3px;
}

/*       로고 이미지 확대를 위한  css       */
.scale {
   transform: scale(1);
   -webkit-transform: scale(1);
   -moz-transform: scale(1);
   -ms-transform: scale(1);
   -o-transform: scale(1);
   transition: all 0.3s ease-in-out; /* 부드러운 모션을 위해 추가*/
}

/*       로고 이미지 호버시 확대        */
.scale:hover {
   transform: scale(1.2);
   -webkit-transform: scale(1.2);
   -moz-transform: scale(1.2);
   -ms-transform: scale(1.2);
   -o-transform: scale(1.2);
}

.img_scale { /*width:325px; height:280px;*/
   overflow: hidden
} /* 부모를 벗어나지 않고 내부 이미지만 확대 */
.userbtn {
   width: 40px;
   height: 40px;
   padding-left: 0px;
   padding-right: 0px;
   color: #4682B4;
}

.navbar-right {
   float: right !important;
   margin-right: -15px;
   margin-top: 2px;
   display: flex;
}

.logintext {
   margin: auto;
   padding-left: 10px;
   margin-right: 1em;
}

.usernick {
   min-width: 10px !important;  
   max-width: 100% !important; 
   transition: width 0.25s;
   border: none;
   font-size: 18px;
}
</style>

</head>
<body>
   <% UserVO login = (UserVO)session.getAttribute("login"); %>

   
   <div class="topbar">
      
      <div class="img_scale logo">
         <a href="main.do">
            <img class="floater" src="${pageContext.request.contextPath}/assets/images/2.png" width="100px">
         </a>
      </div>
      
      <div class="col-xs-8 searchbar">
         <form id="searchForm" action="search_result.do" method="post">
         	<input type="text" id="tag" name="tag" class="searchtxt"><button type="submit" class="searchbtn" style="width: 45px;"></button>
         </form>
         
      </div>
      
      <div class="navmenu">
         <form class="navbar-form navbar-right">
            <div id="login" class="logintext" > 
               <a href="loginform.do">로그인</a> 
            </div> 
             
            <div class="dropdown" id="usrimg" style="margin-right:1em;" >
               <button id="btn_profile" class="btn dropdown-toggle userbtn btn-group img-circle"
                type="button" data-toggle="dropdown" style="padding-left: 1px; padding-right: 1px; width:44px; height:44px;"></button>
                 <input class="usernick" type="text" value="${login.nickname}" id="usernick" style="margin-left:10px;" readonly/>
                  <ul class="dropdown-menu" style="left: 0;">
                     <li><a href="mychannel.do">내 채널</a></li>
                     <li><a href="#">마이페이지</a></li>
                     <li><a href="logout.do">로그아웃</a></li>
                  </ul>
             </div> 
       
           <div id="brStart" class="broadcast_img_swap">
              <a href="broadcast_setting.do">
                    <img src="${pageContext.request.contextPath}/assets/images/video_icon2.png" height="40px">
                    <img src="${pageContext.request.contextPath}/assets/images/video_icon6.png" height="40px">
              </a>
           </div>
         </form>          
      </div>
   </div>

   <script>
      var usernick = document.getElementById('usernick');
      var nickleng = document.getElementById('usernick').value.length;

      var inputWidth = nickleng;
      inputWidth = inputWidth + "em";
      
      usernick.style.width = inputWidth;
             
   </script>

<hr>
   <script type="text/javascript">
      $(document).ready(function(){
         var email = "${login.email}";
            //데이타요청
            $.ajax({
               url : "checkChatmember.do",
               type : "post",
               data: email,
               success : function(data){
                  if(data == 0){
                     console.log("방송 안함");
                    $("#brStart").show();
                  } else{
                     console.log("방송 함");
                    $("#brStart").show().hide();
                  }
                  
                  //$("#liveroom").append(str);     
               },
               error : function(XHR, status, error) {
                  console.log("로그인 안함");
                 $("#brStart").show();
               }                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
            
            });
      });
   
      if("${login.email}" !=""){
         console.log("세션 연결 됨");
         $("#login").show().hide();
         $("#usrimg").show();
         
      }else{
         console.log("세션 연결 안됨");
         $("#login").show();
         $("#usrimg").show().hide();
      }
      
      
      
   </script>
</body>

</html>