<%@page import="com.utf18.site.vo.UserVO"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html lang="ko">
<head>
<title>방송 화면</title>
<!-- 위 3개의 메타 태그는 *반드시* head 태그의 처음에 와야합니다; 어떤 다른 콘텐츠들은 반드시 이 태그들 *다음에* 와야 합니다 -->
<title>제가 안했어요!! 이의제기</title>


<!-- 구글폰트 -->
<!-- <link href="https://fonts.googleapis.com/css?family=Hi+Melody" rel="stylesheet"> -->

<!-- jQuery (부트스트랩의 자바스크립트 플러그인을 위해 필요합니다) -->
<script type="text/javascript"
   src="${pageContext.request.contextPath}/assets/js/jquery-1.12.4.js"></script>

	<style>
		/*       로고 이미지 확대를 위한  css       */
		.scale {
		   transform: scale(1);
		   -webkit-transform: scale(1);
		   -moz-transform: scale(1);
		   -ms-transform: scale(1);
		   -o-transform: scale(1);
		   transition: all 0.3s ease-in-out; /* 부드러운 모션을 위해 추가*/
		}
		#userinfo{
			float: left;
			width: 100%;
		}
		#objbtn{
			width: 30%;
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
		body {
		   padding: 0px;
		   margin-top: 0px;
		}
		
		div.main {
		display: inline-block;
		   width: 100%;
		   height: 100%;
		   padding: 0px;
		   margin-top: 0px;
		   margin-left: 0px;
		   text-align: center;
		}
		
		
		h4, h5 {
		   float: left;
		   margin: 0px;
		}
		
		
		
		#chat {
		   width: 100%;
		   height: 100%;
		   margin-top: -1px;
		}
		
		.chat_log {
		   height: 200px;
		   width: 100%;
		   resize: none;
		   text-align: left;
		   padding: 10px 10px 10px 10px;
		   border: 1px solid #2e9dfe;
		   border-radius: 0;
		   font-size: 18px;
		   overflow:scroll;
		}
		
		/* 메세지 입력란 */
		#message {
		   width: 99%;
		   height: 100%;
		   margin-left: 6px;
		   padding: 0px;
		   border: 1px solid #2e9dfe;
		   border-right: none;
		   border-radius: 0 0 0 10px;
		   font-size: 17px;
		}
		
		/* 전송버튼 */
		#buttonMessage {
		   margin: 0;
		   border: none;
		   border-radius: 0 0 10px 0;
		   /*    부트스트랩 기본색 #337ab7  밝은파란색 2e9dfe*/
		   background: #2e9dfe;
		   color: #fff;
		   vertical-align: bottom;
		}
		
		#name {
		   width: 99%;
		   height: 100%;
		   margin-left: 5px;
		}
		
		#subscribe_img {
		   font-family: 'Hi Melody', cursive;
		}
		
		.subscribe {
		   width: 30px;
		   height: 30px;
		   position: relative;
		   float: left;
		   top: 3px;
		}
		
		
		/*   이의제기 버튼 */
		#objbtn {
		   background:
		      url(${pageContext.request.contextPath}/assets/images/eej2.png) center
		      no-repeat #fff;
		   border: none;
		}
		/* [호버] 이의제기 버튼 */
		#objbtn:hover {
		   background:
		      url(${pageContext.request.contextPath}/assets/images/eej2_hover.png) center
		      no-repeat #fff;
		   border: none;
		}
		#chatspace{
			display: flex;
			height: 20px;
			width: 100%;
		}
		.video-container {
		   position: relative;
		   padding-bottom: 50%;
		   padding-top: 30px;
		   height: 0;
		   overflow: hidden;
		   z-index: 1;
		}
		
		.video-container iframe, .video-container object, .video-container embed
		   {
		   position: absolute;
		   top: 0;
		   left: 0;
		   width: 100%;
		   height: 100%;
		}
		
		.col-xs-12w {
		   width: 100%;
		   height: 100px;
		}
		
		.col-xs-1w {
		   text-align: start;
		   padding-left: 5px;
		   padding-top: 6px;
		   /*           background-color: #ffc90e; */
		   margin-left: 10px;
		   width: 100px;
		   height: 30px;
		}
		
		input.chat {
		   height: 60px;
		}
		
		#warnCnt{
		   border: none;
		}
		#broadinfo{
			height: 35px;;
			width: 100%;
			margin-bottom: 10px;
			display: flex;
		}
	</style>
	
	<style type="text/css">
	
		button,
		button::after {
		  -webkit-transition: all 0.3s;
		   -moz-transition: all 0.3s;
		  -o-transition: all 0.3s;
		   transition: all 0.3s;
		}
	
	</style>

<script>
   String.prototype.replaceAll = function(search, replacement) {
       var target = this;
       return target.replace(new RegExp(search, 'g'), replacement);
   };

   function manage(roomNum) {
     //num = document.getElementById('roomNum').value;
      //window.open("about:blank").location.href = "manage.do";
      $("#manageform").submit();
   }

   
</script>

<script type="text/javascript">
   var i = 0;
   var sock = null;
   var id = '${login.email}';
  
   $(document).ready(
         function() {
            $("#message").focus(); // 처음 접속시, 메세지 입력창에 focus 시킴

            //서버로 접속할때는 localhost로 설정해줘야됨 (관리자)
            // 본인의 서버로 접속할경우, admin으로 들어가야만 채팅이 가능하다.
            if (id == 'admin@admin.com') {
               ws = new WebSocket("ws://localhost:8181/Walalaa/echo.do");
            } else {
               // 그 외 회원은 admin을 제외한 다른 아이디로 접속 시, 채팅참여가 가능하다.
               ws = new WebSocket("ws://175.209.90.138:1003/Walalaa/echo.do");
            }

            //서버로 메세지 보낼때
            ws.onopen = function() {
               //처음 접속 시에만 채팅방에 추가함(현재 방정보도 같이 출력)      
               $("#chatLog").append("<b>채팅방에 참여했습니다.</b> : " + $("#room").val()+ "<br>");

               //보내기 버튼 눌렀을때
               $("#buttonMessage").click(function() {
                  var msg = $('input[name=chatInput]').val(); //메시지
                  var room = $("#room").val(); //방이름(전체단톡방이면 all)

                  //전체에게 보낼때
                  if (msg != "") {
                  //소켓으로 메세지 전달
                  ws.send(msg + "!%/" + "time"+ "!%/" + room);
                  $("#message").val(""); //입력창 내용지우기
                  $("#message").focus(); //입력창 포커스 획득
                  }
               });
            
               //엔터키 입력처리
               $("#message").keypress(function(event) {
                  if (event.which == "13") {
                     event.preventDefault();
   
                     var msg = $('input[name=chatInput]').val(); //메시지
                     var room = $("#room").val(); //방이름(전체단톡방이면 all)
                     //전체에게 보낼때
                     if (msg != "") {
                        //소켓으로 메세지 전달
                        console.log(msg);
                        ws.send(msg + "!%/"+ "time" + "!%/"+ room);
                        $("#message").val(""); //입력창 내용지우기
                        $("#message").focus(); //입력창 포커스 획득
                     }
                  }
               });

               //이의제기버트을 눌렀을때
               $("#objbtn").click(function() {
                  var room = $("#room").val(); //방이름(전체단톡방이면 all)
                  ws.send(room);
               });
               //구독하기 버튼을 눌렀을때
              $("#doSubscribe").on("click", function(){
                var room = $("#room").val();
               var id = "";
                 id = $("#userId").val();
               $.ajax({
                     type : "post",
                     url : "subScribe.do",
                     data : id,
                     success : function(){
                        ws.send(room+"%!#Sub");
                           document.getElementById("doSubscribe").style.display="none";
                         document.getElementById("subscribe").style.display="";
                     },
                      error : function(XHR, status, error) {
                         console.error(status + " : " + error);
                      }     
                   });
           });
               //구독해제 버튼을 눌렀을때
           
           
               
               
               
               
               
               
               
            };
            
            //서버로 부터 받은 메세지 보내주기
            ws.onmessage = function(message) {
                var jsonData = JSON.parse(message.data);
                var msg = jsonData.message;
                var ownerCheck =false;
               var viewernick = $("#usernick").val();;
                //프로필 가져오기 작업
                var chatprofile="";
                if(msg.includes("[")){
		            var str = msg.split("]");
		            str = str[0].split("[");
		            var usernick = str[1];
                
            $.ajax({
                type : "post",
                url : "getprofile.do",
                data : {usernick : usernick},
                async: false,
                success : function(url){
                      chatprofile=url;
                },
                error : function(XHR, status, error) {
                    console.error(status + " : " + error);
                }     
            });
            
             $.ajax({
                     type : "post",
                     url : "${pageContext.request.contextPath}/ownerChecknick.do",
                     data : {usernick : usernick},
                     async: false,
                     success : function(check){
                     ownerCheck = check;
                     },
                      error : function(XHR, status, error) {
                          console.error(status + " : " + error);
                      }     
                   });
                }
               if (jsonData.message != null) {
            	   //메세지 분류 비속어일떄
               if (msg.includes("B%A%D")){
                  msg = msg.replaceAll("&/%!", ":");
                  msg = msg.replaceAll("B%A%D", "");
                 
            
                  console.log(msg);
                  window.open("sendobj.do?msg="+msg,"이의제기하기","toolbar = 0, scrollbars = 1, statusbar = 0, menubar = 0, resizable = 0, width=450px, height=200px, left= 1000, top= 200");
                //메세지 분류 ?!
               }else if(msg.includes("broadcast&end")){
                  loction.href="main.do";
               }else{
            	 //메세지 분류 비속어일떄 
                        if(msg.includes("#^$userbad")){
                           alert("사용자가 이 채팅을 싫어합니다. 하지마세요");
                           msg = msg.replace("[", "");
                             msg = msg.replace("]", "");
                           $("#chatLog").append("<div style='display: flex;'><img src='${pageContext.request.contextPath}"+chatprofile+"' class='img-responsive img-circle' style='width: 22px; height: 22px; margin-right: 3px;'><b style='color: orange;'>"+msg.substring(10)+"<b>"+"<br>");
                           $("#chatLog").scrollTop(99999999);
                        }else if (msg.includes("#^$bad")) {
                         alert("비속어감지");
                         msg = msg.replace("[", "");
                         msg = msg.replace("]", "");
                         $("#chatLog").append("<div style='display: flex;'><img src='${pageContext.request.contextPath}"+chatprofile+"' class='img-responsive img-circle' style='width: 22px; height: 22px;margin-right: 3px;'><b style='color: red;'>"+msg.substring(6)+"<b>"+"<br>");
                         $("#chatLog").scrollTop(99999999);
                      }else if(msg.includes("do%!#Sub")){
                         var subScribe = msg.split("do%!#");
                         $("#subNick").empty();
                         $("#subNick").append(subScribe[0]+ "님이 구독!");
                         subscribe_img.style.display="";
                         setTimeout("hideDiv()", 3000);
                         
                      }else{
                         msg = msg.replace("[", "");
                          msg = msg.replace("]", "");
                          if(ownerCheck){
                             msg = msg.replaceAll("color: gray;", "color: gray; background-color: #FFC000;");
                             $("#chatLog").append("<div style='display: flex;'><img src='${pageContext.request.contextPath}"+chatprofile+"' class='img-responsive img-circle' style='width: 22px; height: 22px;margin-right: 3px;'>"+msg + "<div><br>");
                          }else{
                             if(usernick==viewernick){
                               $("#chatLog").append("<div style='display: flex; font-style: italic;'><img src='${pageContext.request.contextPath}"+chatprofile+"' class='img-responsive img-circle' style='width: 22px; height: 22px;margin-right: 3px;'>"+msg + "<div><br>");
                             }else{
                               $("#chatLog").append("<div style='display: flex;'><img src='${pageContext.request.contextPath}"+chatprofile+"' class='img-responsive img-circle' style='width: 22px; height: 22px;margin-right: 3px;'>"+msg + "<div><br>");
                             }
                          }
                             
                         $("#chatLog").scrollTop(99999999);
                      }
                  }
            }
            };

            //닫힐때
            ws.onclose = function(event) {};
            
            //경고횟수
            
   });
   
   
</script>
   
   <script>
      // 방송 시작시 사용자 지정단어 0으로 설정
      $(document).ready(function() {
           var id = "";
           id = $("#userId").val();
           $.ajax({
                type : "post",
                url : "${pageContext.request.contextPath}/settingcustomword.do",
                data : id,
                success : function(){
                },
                error : function(XHR, status, error) {
                     console.error(status + " : " + error);
                }     
              });
        });
   
   </script>
   
</head>
<body>
   <% UserVO login = (UserVO) session.getAttribute("login"); %>
   <!-- 세팅 부분 init -->
   <input type="hidden" id="userId" value="${login.email}">
   <input type="hidden" id="usernick" value="${login.nickname}">
    <input type="hidden" id="roomNum" name="roomNum" value='${roomNum}'>
   <input type="hidden" id="room" value="${room}">
   <input id="name" class="name" type="hidden" readonly>

<!--    <header> -->
<%--          <jsp:include page="search_navbar_m.jsp"></jsp:include> --%>
<!--    </header> -->
    
	<div class="main sub">
      <!-- 현재 유저가 접속한 방이름 -->
		<form id=chat>
			<div id="broadinfo">
				<div class="img_scale logo">
					<a href="main_m.do"><img class="floater" src="${pageContext.request.contextPath}/assets/images/2.png" width="100px"></a>
				</div>		
				<h4><strong>${roomName }</strong></h4>
				<h5 style="margin-left: 4px;">·<b id="rmCnt"></b>명 시청중 ·</h5> 
				<a href="#"><img id="subscribe" class="subscribe" alt="구독누름(구독중)" src="${pageContext.request.contextPath}/assets/images/subscribe_on.png"></a>
				<a href="#"><img id="doSubscribe"class="subscribe" alt="구독안누름" src="${pageContext.request.contextPath}/assets/images/subscribe_off.png"></a>
			</div>

			<div class="video-container">
				<!-- 구독시 이미지  -->
				<div id="subscribe_img" style="position: relative; z-index: 2; float: left; top: 0px; display: none;">
					<img src="${pageContext.request.contextPath}/assets/images/heart_moving2.gif" alt="구독 감사"> 
					<font color="white" size="5px" style="position: relative; z-index: 3; float: left; top: 55px; left: 20px;">
						<strong id="subNick"></strong>
		      		</font>
	   			</div>
	   			<!-- 방송화면 -->
	   			<iframe height="30%" width="100%" src="https://www.youtube.com/embed/CB6gwOJp_8U?rel=0&autoplay=1" frameborder="0" allowfullscreen></iframe>
			</div>
	
	
			<div id="chatLog" class="chat_log" style="overflow:auto;"></div>
	
			<div id="userinfo">
				<img src="${pageContext.request.contextPath}${login.profile}" class="name img-circle" alt="유저이미지" width="30px" height="30px" >
				<strong>${login.nickname }</strong> · 
				<font color="red" size="2">
				   <input type='button' id='objbtn' value=''>
				   <input type='text' id='warnCnt' value=''>
				</font>
			</div>
			<div id="chatspace">
				<input type="text" id="message" name="chatInput" class="message" value="" maxlength="140">
				<input type="button" id="buttonMessage" value="전송" class="chat btn-primary" style="height: 22px; width: 60px; border: 0px">
			</div>
		</form>
	</div>
   

   <script>
       $(document).ready(
            function() {
                 var id = "";
                 id = $("#userId").val();
                  $.ajax({
                       type : "post",
                       url : "${pageContext.request.contextPath}/subScribecheck.do",
                       data : id,
                       success : function(check){
                             var doSubscribeBtn = document.getElementById('doSubscribe');
                             var delSubscribeBtn = document.getElementById('subscribe');
                          if(check){
                             doSubscribeBtn.style.display = "none";
                             delSubscribeBtn.style.display = "";
                          }else{
                             doSubscribeBtn.style.display = "";
                             delSubscribeBtn.style.display = "none";
                          }
                       },
                        error : function(XHR, status, error) {
                            console.error(status + " : " + error);
                        }     
                     });
            });
   </script>
   
   
   <script>   
      
   $(function() {
      timer = setInterval( function () {
         var id = "";
         id = $("#userId").val();
               $.ajax({
                    type : "post",
                    url : "getWarnCnt.do",
                    async: true,
                    data : id,
                    success : function(warnCnt){
                       if(warnCnt[0]>=warnCnt[1]){
                          $("#warnCnt").val("경고" + warnCnt[0] + "회 로 인해 채팅금지상태입니단");
                          $('#message').attr('readonly',true);
                          $('#message').attr('style','background-color:gray;'); 
                       }else{
                          $("#warnCnt").val("경고" + warnCnt[0] + "회");
                          $('#message').attr('readonly',false);
                          $('#message').attr('style','background-color:none;'); 
                       }
                    },
                     error : function(XHR, status, error) {
                         console.error(status + " : " + error);
                     }     
                  });
      }, 1000); // 1초에 한번씩 받아온다.
   });

</script>
   <script>   
      
	   $(function() {
	      timer = window.setInterval( function () {
	         var num = $("#roomNum").val();
	               $.ajax({
	                    type : "post",
	                    url : "${pageContext.request.contextPath}/getremainCnt.do",
	                    data : {num: num},
	                    success : function(Rcount){
	                       $("#rmCnt").empty();
	                  $("#rmCnt").append(Rcount);
	                    
	                    },
	                     error : function(XHR, status, error) {
	                         console.error(status + " : " + error);
	                     }     
	                  });
	      }, 1000); // 1초에 한번씩 받아온다.
	   });

	</script>
	<script>
   $("#subscribe").on("click", function(){
      
       var id = "";
       id = $("#userId").val();
       $.ajax({
           type : "post",
           url : "delsubScribe.do",
           data : id,
           success : function(){
               document.getElementById("doSubscribe").style.display="";
               document.getElementById("subscribe").style.display="none";
           },
            error : function(XHR, status, error) {
               console.error(status + " : " + error);
            }     
         });
   });
   </script>
   <script>
	   function hideDiv() {
	      document.getElementById("subscribe_img").style.display = "none";
	      }
	</script>
</body>
</html>