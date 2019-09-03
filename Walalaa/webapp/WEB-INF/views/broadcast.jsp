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
body {
   padding: 0px;
   margin-top: 0px;
}

div.main {
   width: 95%;
   height: 90%;
   padding: 0px;
   margin-top: -15px;
   margin-left: 15px;
   text-align: center;
}

table {
   width: 100%;
   height: 80%;
   border-collapse: collapse;
   border-spacing: 0px;
   margin-left: 10px;
   padding: 0px;
}

th, tr, td {
   /*          vertical-align: middle; */
   padding: 0px;
}

h4, h5 {
   float: left;
   margin: 0px;
}

#broadScreen {
   width: 80%;
   height: 90%;
}

/* 채팅로그가 뜨는 채팅 화면 */
#chatScreen {
   height: 100%;
   width: 20%;
}

#chat {
   width: 100%;
   height: 100%;
   margin-top: -1px;
}

.chat_log {
   height: 100%;
   /*          width: 100.7%; */
   width: 98%;
   margin-left: 5px;
   resize: none;
   text-align: left;
   /*    border: solid lightgray 1px; */
   padding: 10px 10px 10px 10px;
   border: 1px solid #2e9dfe;
   border-radius: 10px 10px 0 0;
   font-size: 18px;
}

/* 메세지 입력란 */
#message {
   /*    width: 99%; */
   /*    height: 100%; */
   /*    margin-left: 6px; */
   width: 99%;
   height: 100%;
   margin-left: 6px;
   padding: 10px 10px 10px 20px;
   border: 1px solid #2e9dfe;
   border-right: none;
   border-radius: 0 0 0 10px;
   font-size: 17px;
}

/* 전송버튼 */
#buttonMessage {
   margin: 0;
   border: none;
   padding: 0 20px;
   height: 40px;
   border-radius: 0 0 10px 0;
   font-size: 20px;
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

.btn_manage {
   float: right;
   position: relative;
}

#a_broadcast_setting {
   position: relative;
   float: left;
   top: 7px;
   /*          left: -240px; */
}

/*   방송 종료 버튼 */
#brFinish_btn {
   border: none;
   float: right;
   height: 35px;
   background: url(${pageContext.request.contextPath}/assets/images/broadcast_finish2.png) center no-repeat;
}
#brFinish_btn:hover{
    border: none;
    float: right;
   height: 35px;
   background: url(${pageContext.request.contextPath}/assets/images/broadcast_finish_hover2.png) center no-repeat;
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


/* 관리자창 버튼 */
.btn_manage {
   float: right;
   position: relative;
   height:30px;
   margin-top: 5px;
   margin-right:5px;
   background:
   url(${pageContext.request.contextPath}/assets/images/manage_btn.png) center
   no-repeat #fff;
   border: none;
}
/* [호버] 관리자창 버튼 */
.btn_manage:hover {
   float: right;
   position: relative;
   height:30px;
   margin-top: 5px;
   margin-right:5px;   
   background:
   url(${pageContext.request.contextPath}/assets/images/manage_btn_hover.gif) center
   no-repeat #fff;
   border: none;
}

.video-container {
   position: relative;
   padding-bottom: 56.25%;
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
               if (msg.includes("B%A%D")){
                  msg = msg.replaceAll("&/%!", ":");
                  msg = msg.replaceAll("B%A%D", "");
                 
            
                  console.log(msg);
                  window.open("sendobj.do?msg="+msg,"이의제기하기","toolbar = 0, scrollbars = 1, statusbar = 0, menubar = 0, resizable = 0, width=450px, height=200px, left= 1000, top= 200");
               }else if(msg.includes("broadcast&end")){
                  loction.href="main.do";
               }else{
                        //메세지 
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
       $(document).ready(
            function() {
                    var id = "";
                    id = $("#userId").val();
                          $.ajax({
                               type : "post",
                               url : "${pageContext.request.contextPath}/ownerCheck.do",
                               data : id,
                               success : function(check){
                                  if(check){
                                  }else{
                                     var settingBtn = document.getElementById('a_broadcast_setting');
                                     var manageBtn = document.getElementById('manageBtn');
                                     var brFinishBtn = document.getElementById('brFinish_btn');
                              settingBtn.style.display = 'none';
                              manageBtn.style.display = 'none';
                              brFinishBtn.style.display = 'none';
                                  }
                               },
                                error : function(XHR, status, error) {
                                    console.error(status + " : " + error);
                                }     
                             });
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
   <!-- 유저아이디  -->
   <input type="hidden" id="room" value="${room}">
   <!-- 현재 유저가 접속한 방이름 -->

   <header>
         <jsp:include page="search_navbar.jsp"></jsp:include>
   </header>
    
   <form id="finishform" action="broadcast_finish.do">
         <input type="hidden" id="roomNum" name="roomNum" value='${roomNum}'>
   </form>
   
   <form id="manageform" action="manage.do" target="_blank">
         <input type="hidden" id="roomNum" name="roomNum" value='${roomNum}'>
   </form>
   
   <div class="main sub">
      <!-- 현재 유저가 접속한 방이름 -->
      <form id=chat>
         <table id="broad">
            <tr>
               <td>
                  <h4>
                     <strong>${roomName }</strong>
                  </h4> <a id="a_broadcast_setting" href="broadcast_setting.do">&nbsp;·&nbsp;방송설정</a>
               
<!-- 방송종료버튼 --><input type="button" id="brFinish_btn" value='          ' onclick="finish('${roomNum}');">
               </td>
               <td colspan="3" class="chatting_box_title">
                  <h4>&nbsp;실시간 채팅</h4>
                  <h5 style="margin-left: 4px;">· <b id="rmCnt"></b>명 시청중 ·</h5> <a href="#"> 
                  <img id="subscribe" class="subscribe" alt="구독누름(구독중)" src="${pageContext.request.contextPath}/assets/images/subscribe_on.png"></a>
                  <a href="#"> 
                  <img id="doSubscribe"class="subscribe" alt="구독안누름" src="${pageContext.request.contextPath}/assets/images/subscribe_off.png"></a>
                  <input type="button" id="manageBtn" class="btn_manage" value="   " onclick="manage('${roomNum}');" style="width: 30px;">
               </td>
            </tr>
            <tr>
               <td rowspan="3" id="broadScreen">
                  <div class="video-container">
                     <div id="subscribe_img" style="position: relative; z-index: 2; float: left; top: 0px; display: none;">
<%--                         <img src="${pageContext.request.contextPath}/assets/images/heart_moving2.gif" alt="구독 감사">  --%>
                        <img src="${pageContext.request.contextPath}/assets/images/subscribeThx.png" alt="구독 감사"> 
                        <font color="white" size="5px" style="position: relative; z-index: 3; float: left; top: 55px; left: 20px;">
                           <strong id="subNick"></strong>
                        </font>
                     </div>
                     <!--  자동재생소스추가하려면   ?rel=0&autoplay=1 -->
                     <iframe height="100%" width="100%" src="https://www.youtube.com/embed/ZOWEVG87Z8k" frameborder="0" allowfullscreen></iframe>
                  </div>
               </td>
               <td colspan="2" id="chatScreen">
                  <div id="chatLog" class="chat_log" style="overflow:auto;"></div>
               </td>
            </tr>
            <tr>
               <td class="col-xs-1w" colspan="3">
                  <input id="name" class="name" type="hidden" readonly>
                 <img src="${pageContext.request.contextPath}${login.profile}" class="name img-circle" alt="유저이미지" width="30px" height="30px" >
                  <strong>${login.nickname }</strong> · 
                  <font color="red" size="2">
                     <input type='button' id='objbtn' value='                       '>
                     <input type='text' id='warnCnt' value='' style="width:100%; ">
                  </font>
               </td>
            </tr>
            <tr>
               <td class="col-xs-12w">
                  <input type="text" id="message" name="chatInput" class="message" value="" maxlength="140">
               </td>
               <td>
                  <input type="button" id="buttonMessage" value="전송" class="chat btn-primary" style="height: 100px; width: 100px; border: 0px">
               </td>
            </tr>
         </table>
      </form>
   </div>
   

   <script>
      function finish(roomNum) {
         $("#finishform").submit();
      }
      
   </script>
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
                  
                
  /*              
                 // 유저 프로필 이미지 가져오기
                  $.ajax({
                     url : "getProfileImage.do",   //    안될때 ${pageContext.request.contextPath}/
                     type : "post",
                     data : { email : id },
                     contentType: "application/json; charset=utf8",
                     dataType : "json",
                     success : function(profileImage){
                        alert(profileImage);
                     },
                     error : function(XHR, status, error) {
                        console.error(status + " : " + error);
                     }                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
                  });
  */
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
                    	if(warnCnt[2] > 0) {
                    		$("#warnCnt").val("사용자의 요청으로 채팅금지 상태입니다");
                            $('#message').attr('readonly',true);
                            $('#message').attr('style','background-color:gray;'); 
                    	}
                    	else if(warnCnt[0]>=warnCnt[1]){
                          $("#warnCnt").val("경고" + warnCnt[0] + "회 로 인해 채팅금지상태입니다");
                          $('#message').attr('readonly',true);
                          $('#message').attr('style','background-color:gray;'); 
                       }else{
                          $("#warnCnt").val("경고" + warnCnt[0] + "회");
                          $('#message').attr('readonly',false);
                          $('#message').attr('style','background-color:none;'); 
                       }
                    },
                     error : function(XHR, status, error) {
//                         console.error(status + " : " + error);
                     }     
                  });
      }, 5000); // 1초에 한번씩 받아온다.
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
//                         console.error(status + " : " + error);
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
   function hideDiv() {
      document.getElementById("subscribe_img").style.display = "none";
      }
</script>
<script>
$(document).keydown(function (e) {
    // F5, ctrl + F5, ctrl + r 새로고침 막기
    var allowPageList   = new Array('/a.php', '/b.php');
    var bBlockF5Key     = true;
    for (number in allowPageList) {
        var regExp = new RegExp('^' + allowPageList[number] + '.*', 'i');
        if (regExp.test(document.location.pathname)) {
            bBlockF5Key = false;
            break;
        }
    }
     
    if (bBlockF5Key) {
        if (e.which === 116) {
            if (typeof event == "object") {
                event.keyCode = 0;
            }
            return false;
        } else if (e.which === 82 && e.ctrlKey) {
            return false;
        }
    }
});
</script>
</body>
</html>