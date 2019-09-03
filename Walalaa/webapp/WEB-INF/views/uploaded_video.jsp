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
   font-family: 'Jeju Gothic', sans-serif;
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
   background:
      url(${pageContext.request.contextPath}/assets/images/send_icon.png)
      center no-repeat #2e9dfe;
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

#warnCnt {
   border: none;
}

.comment {
   width: 95%;
   height: 90%;
   padding: 0px;
   margin-left: 25px;
   text-align: center;
   display: flex;
}

.userimg {
   width: 50px;
   height: 50px;
   margin-top: 15px;
}

.profileimage {
   display: inline;
   float: left;
   width: 200px;
   height: 50px;
   position: relative;
}

.showcomment {
   margin-left: 25px;
   width: 95%;
}

.btnDelete {
   background:
   	  url(${pageContext.request.contextPath}/assets/images/delete03.png) center
      center no-repeat #fff;
   width: 30px;
   height: 35px;
   border: none;
}
.btnDelete:hover {
   background:
      url(${pageContext.request.contextPath}/assets/images/delete03_hover.png)
      center no-repeat #fff;
   width: 30px;
   height: 35px;
   border: none;
}
#commentContent{
	border: none;
	margin-top: 25px;
	margin-left: 3px;
	font-size: 20px;
}

</style>

<style type="text/css">
button, button::after {
   -webkit-transition: all 0.3s;
   -moz-transition: all 0.3s;
   -o-transition: all 0.3s;
   transition: all 0.3s;
}
*:focus{
	outline: none;
}
</style>



</head>
<body>
   <%
      UserVO login = (UserVO) session.getAttribute("login");
   %>

   <!-- 세팅 부분 init -->
   <input type="hidden" id="userId" value="${login.email}">
   <!-- 유저아이디  -->
   <input type="hidden" id="room" value="${room}">
   <!-- 현재 유저가 접속한 방이름 -->
   <input type="hidden" id="showtime" value="${showtime}">

   <header>
      <jsp:include page="search_navbar.jsp"></jsp:include>
   </header>


   <div class="main sub">
      <!-- 현재 유저가 접속한 방이름 -->
      <form id=chat>
         <table id="broad">
            <tr>
               <td>
                  <h4>
                     <strong>${roomName }</strong>
                  </h4>

               </td>
               <td colspan="3" class="chatting_box_title">
                  <h4>&nbsp;저장된 채팅</h4>
               </td>
            </tr>
            <tr>
               <td rowspan="3" id="broadScreen">
                  <div class="video-container">
                     <!--  자동재생소스추가하려면   ?rel=0&autoplay=1 -->
                     <iframe height="100%" width="100%"
                        src="https://www.youtube.com/embed/CB6gwOJp_8U?rel=0&autoplay=1"
                        frameborder="0" allowfullscreen></iframe>
                  </div>
               </td>
               <td colspan="2" id="chatScreen">
                  <div id="chatLog" class="chat_log" style="overflow: auto;"></div>
               </td>
            </tr>
         </table>
      </form>
   </div>
   
   <div id="videoInfo" style="margin-left:25px; width:97%; margin-top: 10px; font-size:15px; display: inline-block; " >
	   	<div style="height: 40px; width: 100%;">
	   		<h5 style="margin-left: 4px;"> 조회수 <b id="viewCnt"></b>회      </h5>
	   	</div>
	   	
	   	<div style="display:flex; ">
	   		<div id="ownerImg" style="margin-right: 10px;">
	   			<!-- 이미지 -->
	   		</div>
		   	<div style="display: block; ">
		   		<div id="ownerNick" style="font-size: 17px;">
		   			<!-- 닉네임 -->
		   		</div>
		   		<div style="color: gray;">
		   			<!-- 게시일 -->
		   			${upload_date}
		   		</div>
		   		<div id="viewCont" style="margin-top: 10px;  font-size:15px; border:none; margin-bottom: 10px; ">
		   			<!-- 설명 -->
		   		</div>
		   	</div>
	   	</div>
   </div>
    
   <div id="commentAmount" style="margin-left: 25px; width: 95%; border-top: 1px solid lightgray; padding-top: 15px;"></div>

   <div class="comment sub" style="width:95%; ">

    <div class="userimg" style="width: 50px;">
		<img class="proimgsrc image img-circle" src="${pageContext.request.contextPath}${login.profile}" style="width: 50px; height: 50px;">
	</div>

      <div class="input-group" role="group" aria-label="..."
         style="margin-top: 10px; width: 100%; display: flex; margin-bottom: 20px;">
         <textarea rows="3" id="commentContent"
            placeholder="댓글을 입력하세요." style="width: 100%; height:30px; border-bottom:1px solid gray; resize: none; overflow:hidden;"></textarea>
         <div class="btn-group btn-group-sm" role="group" aria-label="...">
            <c:if test="${login.email == null}">
               <!--                   <input type="button" class="btn btn-default" value="댓글 쓰기" disabled="disabled"> -->
            </c:if>
            <c:if test="${login.email != null}">
               <input type="button" class="btn btn-default" value="작성" id="commentWrite" style="height: 55px;">
            </c:if>
            <%--               <input type="button" class="btn btn-default" value="댓글 읽기(${article.commentCount})"  --%>
            <!--                 onclick="getComment(1, event)" id="commentRead"> -->
         </div>
      </div>
   </div>

	
   <div id="showComment" class="showcomment"></div>

   <script>
      // 채팅 불러오기 관련 아작스
      var nick = [];
      var cont = [];
      var prof = [];
      var delay = [];
      var showtime = $("#showtime").val();
      var showtimehour = showtime.substr(0, 2) * 3600;
      var showtimemin = showtime.substr(2, 2) * 60;
      var showtimesec = showtime.substr(4, 2) * 1;
      standard = showtimehour + showtimemin + showtimesec;
      
      $(document).ready(
            function() {
               var room = $("#room").val();
               $.ajax({
                  type : "post",
                  url : "${pageContext.request.contextPath}/getuploaded_data.do",
                  data : {room : room},
                  success : function(data) {
                     $("#viewCnt").append(data.views);
                     $("#viewCont").append(data.content);
                     $.ajax({
                    	type : "post",
                    	url : "${pageContext.request.contextPath}/getowner_info.do",
                        data : {email : data.owner},
                        success : function(owner) {
                        	var img = "<img class='proimgsrc image img-circle' src='${pageContext.request.contextPath}"+owner.profile+"' style='width: 50px; height: 50px;'>";
                        	$("#ownerImg").append(img);
                        	$("#ownerNick").append(owner.nickname);
                        },
                        error : function(XHR, status, error) {
                            console.error(status + " : "+ error);
                         }
                     });
                  },
                  error : function(XHR, status, error) {
                     console.error(status + " : "+ error);
                  }
               });

               var j = 0;
               var data2 = [];
               $.ajax({
                  type : "post",
                  url : "${pageContext.request.contextPath}/getuploaded_Chatdata.do",
                  data : {room : room},
                  success : function(data) {
                     for (var i = 0; i < data.length; i++) {
                        var check = data[i].time
                        if (!check.includes("B%A%D")) {
                           data2[j] = data[i];
                           j++;
                        }
                     }
                     for (var i = 0; i < data2.length; i++) {
                        var msg = data2[i].time;
                        var hour = msg.substr(8, 2) * 3600;
                        var min = msg.substr(10, 2) * 60;
                        var sec = msg.substr(12, 2) * 1;
                        chattime = hour + min + sec;
   			
                        delay[i] = (chattime - standard) * 1000;
                        nick[i] = data2[i].nickname;
                        cont[i] = data2[i].content;
                        prof[i] = data2[i].profile;
                     }
                     loop();
                  },
                  error : function(XHR, status, error) {
                     console.error(status + " : "+ error);
                     }
               });
      });
   </script>

   <script>
      // 댓글 관련 아작스
      var room = $("#room").val();
      var email = $("#userId").val();
      
      var str = "";
      
      //댓글 보기
      $(document).ready(function() {
         $.ajax({
            type : "post",
            url : "${pageContext.request.contextPath}/showComment.do",
            data : {room : room},
            success : function(commentList) {
               str = "";
               var str_amount = commentList.length;
               
                     for(var i = 0; i<commentList.length; i++){
                        if(commentList[i] != null) {
                           showComment(commentList[i]);
                        }
                    }
                     
                     $("#commentAmount").empty();
                     $("#commentAmount").append(" 댓글 " + str_amount + "개");
                     
                     
                     $("#showComment").empty();
                     $("#showComment").append(str);                  
            },
            error : function(XHR, status, error) {
               console.error(status + " : "+ error);
            }
         });
      });
      
      function showComment(vo) {
         str += "<div id='commentbox' style='display:flex; flex-direction:row; border-bottom: 1px solid lightgray; margin-top: 5px; '>";
         str += "    <div class='profileimage' style='flex:none; width:50px; border-right: 1px solid lightgray;'>";
         str += "      <img class='proimgsrc image' src='${pageContext.request.contextPath}"+vo.profile+"' style='width: 50px; height: 50px;'>";
         str += "    </div>";
         
         str += "    <div style='margin-left: 3px; display:block; width:90%;'>";
         str += "        <div style='display:flex; margin-bottom: 10px; '>";
         str += "         <b style='font-size: 20px;'>"+ vo.nickname + "  &nbsp&nbsp&nbsp&nbsp </b> "+vo.time+"";
         str += "        </div>";
         str += "        <div style='display:block; font-size: 20px; '>";
         str += "         "+ vo.content;
         str += "        </div>";
         str += "    </div>";
         str += "    <div>";
         str += "         <button type='button' class='btn btnright btnDelete' onclick='delcom("+vo.com_num+")' >삭제</button>";
         //<img src='${pageContext.request.contextPath}/assets/images/delete03.png' class='btnDelete'>
         str += "    </div>";
         str += "</div>";
      }
      
      
      //댓글 입력
      $("#commentWrite").on('click', function(){
          var comment = $("#commentContent").val();

            $.ajax({
               type : "post",
               url : "${pageContext.request.contextPath}/addComment.do",
               data : {
                     comment : comment,
                     room : room,
                     email : email
                     },
               success : function() {
                  $("#commentContent").val("");
                  refresh();
               },
               error : function(XHR, status, error) {
                  console.error(status + " : "+ error);
               }
            });
      });
      
      
   
   </script>
<script>
function delcom(num) {
   alert("adsf");
      var num = num;
      $.ajax({
         type : "post",
         url : "${pageContext.request.contextPath}/deleteComment.do",
         data : {
               num : num,
               email : email,
               room : room
               },
         dataType: "json",
         success : function(data) {
            if(data.includes("not")){
               alert("권한이 없습니다.");
            }else{
               alert("삭제되었습니다.");
               refresh();
            }
         },
         error : function(XHR, status, error) {
            console.error(status + " : "+ error);
         }
      });
}
   
</script>

   <script>
      function loop() {
         for (var i = 0; i < cont.length; i++) {
            var realdelay = delay[i] + 1000;
            (function(i) {
               setTimeout(function() {
                  write(nick[i], cont[i], prof[i]);
               }, realdelay);
            })(i);

         }
      }

      function write(nickname, content, profile) {
         $("#chatLog").append("<img src='${pageContext.request.contextPath}"+profile+"' style='width: 22px; height: 22px;'>" +nickname + " : " + content + "<br>");
      }
   </script>
   
   <script>
   function refresh(){
      $.ajax({
         type : "post",
         url : "${pageContext.request.contextPath}/showComment.do",
         data : {room : room},
         success : function(commentList) {
            str = "";
            var str_amount = commentList.length;
            
                 for(var i = 0; i<commentList.length; i++){
                    if(commentList[i] != null) {
                        showComment(commentList[i]);
                    }
                 }
                 
                 $("#commentAmount").empty();
                 $("#commentAmount").append(" 댓글 " + str_amount + "개");
                 
                 
                 $("#showComment").empty();
                 $("#showComment").append(str);                  
         },
         error : function(XHR, status, error) {
            console.error(status + " : "+ error);
         }
      });
   }
   
   </script>

</body>
</html>