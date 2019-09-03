<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- 위 3개의 메타 태그는 *반드시* head 태그의 처음에 와야합니다; 어떤 다른 콘텐츠들은 반드시 이 태그들 *다음에* 와야 합니다 -->
<title>lalaTown</title>

<!-- jQuery (부트스트랩의 자바스크립트 플러그인을 위해 필요합니다) -->
<script type="text/javascript"
	src="${pageContext.request.contextPath}/assets/js/jquery-1.12.4.js"></script>

<style>
.scale {
	transform: scale(1);
	-webkit-transform: scale(1);
	-moz-transform: scale(1);
	-ms-transform: scale(1);
	-o-transform: scale(1);
	transition: all 0.3s ease-in-out; /* 부드러운 모션을 위해 추가*/
}

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
.boradbox {
	width: 263px;
	margin-right: 12px;
}

.pageset {
	width: 1080px;
	margin: 0 auto;
	margin-top: 30px;
}

.thumbnail {
	width: 260px;
	height: 280px;
}
</style>

<script type="text/javascript">
   
   var str = "";

      $(document).ready(function(){
    	  var i=0;
         //데이타요청(채팅방 리스트)aa
         $.ajax({
            url : "getRoomList.do",
            type : "post",
            contentType: "application/json; charset=utf8",
            dataType : "json",
            success : function(RoomList){
            	
            	lineStart();
            	for(var i=0; i<RoomList.length; i++){
                  if(i%4==0 && i!=0){
                     lineRender(RoomList[i]);
                     
                  }else{
                     render(RoomList[i]);
                  }
            	 
            	}
	               lineEnd();
	               $("#liveroom").append(str);
            	
            },
            error : function(XHR, status, error) {
               console.error(status + " : " + error);
            }                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
      
         });
         //그리기 render사용as
         
      });

      function lineStart(){
         //var str = "";
         
         str += "<div class='plzrow'>";
         str += " <div class='row' style='display: flex; margin-left:0px;'>";
         
         //$("#liveroom").append(str);   
      }
      function render(ChatVO){
          //var str = "";
          str += "   <div class='boradbox img_scale'>";
          str += "      <div class='thumbnail scale'>";
          str += "         <a href=\"#\" onclick=\"moveRoom('"+ChatVO.name+"', "+ChatVO.remaincount+", "+ChatVO.totalcount+", '"+ChatVO.pwd+"')\">";
          str += "         <img src='${pageContext.request.contextPath}"+ChatVO.thumbnail+"' class='img-responsive' alt='썸네일 ' style='width: 240px; height: 140px;'></a>";
          str += "        		 <div class='caption'>";
          str += "					<h4>" +ChatVO.name+"</h4>";
          str += "           		 <div style='float:left; margin-right:5px; margin-bottom: 2px;'><img src='${pageContext.request.contextPath}"+ChatVO.profile+"' class='img-responsive img-circle' style='width: 20px; height: 20px;'></div>";
          str += "           		 <div style='float:left;'>"+ChatVO.usersNickname+"</div>";
          str += "        		 </div>";
          str += "          <div style='margin-top:15px; padding-left:10px;'>조회수 "+ChatVO.views+"회 · "+ChatVO.uploadtime+"</div>";
          str += "      </div>";
          str += "   </div>";
       }   
       function lineRender(ChatVO){
           str += "</div>";
           str += "<div class='row' style='display: flex; margin-left:0px;'>";
           str += "   <div class='boradbox img_scale'>";
           str += "      <div class='thumbnail scale'>";
           str += "         <a href=\"#\" onclick=\"moveRoom('"+ChatVO.name+"', "+ChatVO.remaincount+", "+ChatVO.totalcount+", '"+ChatVO.pwd+"')\">";
           str += "         <img src='${pageContext.request.contextPath}"+ChatVO.thumbnail+"' class='img-responsive' alt='썸네일 ' style='width: 240px; height: 140px;'></a>";
           str += "        		 <div class='caption'>";
           str += "					<h4>" +ChatVO.name+"</h4>";
           str += "           		 <div style='float:left; margin-right:5px; margin-bottom: 2px;'><img src='${pageContext.request.contextPath}"+ChatVO.profile+"' class='img-responsive img-circle' style='width: 20px; height: 20px;'></div>";
           str += "           		 <div style='float:left;'>"+ChatVO.usersNickname+"</div>";
           str += "        		 </div>";
           str += "          <div style='margin-top:15px; padding-left:10px;'>조회수 "+ChatVO.views+"회 · "+ChatVO.uploadtime+"</div>";
           str += "      </div>";
           str += "   </div>";
       }   
      function lineEnd(){
         //var str = "";
         
         str += " </div>";
         str += "</div>";
         
         //$("#liveroom").append(str);   
      }
         
//       }   
   </script>
<script type="text/javascript">
   
   var stri = "";

      $(document).ready(function(){
    
         //데이타요청(업로드 된 영상)aa
         $.ajax({
            url : "getUploadList.do",
            type : "post",
            contentType: "application/json; charset=utf8",
            dataType : "json",
            success : function(uploadList){
            	lineStart2();
            	for(var j=0; j<uploadList.length; j++){
                  if(j%4==0 && j!=0){
                     lineRender2(uploadList[j]);
                     
                  }else{
                     render2(uploadList[j]);
                  }
            	 
            	}
	               lineEnd2();
	               $("#uploaded").append(stri);
            	
            },
            error : function(XHR, status, error) {
               console.error(status + " : " + error);
            }                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
      
         });
         //그리기 render사용as
         
      });

      function lineStart2(){
         //var str = "";
         
         stri += "<div class='plzrow'>";
         stri += " <div class='row' style='display: flex; margin-left:0px;'>";
         
         //$("#liveroom").append(str);   
      }
      function render2(ChatVO){
         stri += "   <div class='boradbox img_scale'>";
         stri += "      <div class='thumbnail scale'>";
         stri += "         <a href=\"#\" onclick=\"uploadedRoom('"+ChatVO.name+"', "+ChatVO.remaincount+", "+ChatVO.totalcount+", '"+ChatVO.pwd+"')\">";
         stri += "         <img src='${pageContext.request.contextPath}"+ChatVO.thumbnail+"' class='img-responsive' alt='썸네일 ' style='width: 240px; height: 140px;'></a>";
         stri += "        		 <div class='caption'>";
         stri += "					<h4>" +ChatVO.name+"</h4>";
         stri += "           		 <div style='float:left; margin-right:5px; margin-bottom: 2px;'><img src='${pageContext.request.contextPath}"+ChatVO.profile+"' class='img-responsive img-circle' style='width: 20px; height: 20px;'></div>";
         stri += "           		 <div style='float:left;'>"+ChatVO.usersNickname+"</div>";
         stri += "        		 </div>";
         stri += "          <div style='margin-top:15px; padding-left:10px;'>조회수 "+ChatVO.views+"회  · "+ChatVO.uploadtime+"</div>";
         stri += "      </div>";
         stri += "   </div>";
      }   
      function lineRender2(ChatVO){
         stri += "</div>";
         stri += "<div class='row' style='display: flex; margin-left:0px;'>";
         stri += "   <div class='boradbox img_scale'>";
         stri += "      <div class='thumbnail scale'>";
         stri += "         <a href=\"#\" onclick=\"uploadedRoom('"+ChatVO.name+"', "+ChatVO.remaincount+", "+ChatVO.totalcount+", '"+ChatVO.pwd+"')\">";
         stri += "         <img src='${pageContext.request.contextPath}"+ChatVO.thumbnail+"' class='img-responsive' alt='썸네일 ' style='width: 240px; height: 140px;'></a>";
         stri += "        		 <div class='caption'>";
         stri += "					<h4>" +ChatVO.name+"</h4>";
         stri += "           		 <div style='float:left; margin-right:5px; margin-bottom: 2px;'><img src='${pageContext.request.contextPath}"+ChatVO.profile+"' class='img-responsive img-circle' style='width: 20px; height: 20px;'></div>";
         stri += "           		 <div style='float:left;'>"+ChatVO.usersNickname+"</div>";
         stri += "        		 </div>";
         stri += "          <div style='margin-top:15px; padding-left:10px;'>조회수 "+ChatVO.views+"회  · "+ChatVO.uploadtime+"</div>";
         stri += "      </div>";
         stri += "   </div>";
      }   
      function lineEnd2(){
         //var str = "";
         
         stri += " </div>";
         stri += "</div>";
         
         //$("#liveroom").append(str);   
      }
         
//       }   
   </script>


</head>
<body>
	<header>
		<jsp:include page="search_navbar.jsp"></jsp:include>
	</header>

	<div class="pageset">

		<div class="channelimage">
			<div class="profilebg">
				<a href="http://pubg.game.daum.net/pubg/index.daum"> <img
					class="image2"
					src="${pageContext.request.contextPath}/assets/images/ad_PUBG200.gif"></a>
			</div>
		</div>

		<h3>실시간 스트리밍</h3>
		<form action="MoveChatRoom.do" method="post" id="moveChatForm">
			<input type="hidden" name="roomName" value="">
			<div id="liveroom" style="display: flex; margin-left: 0px;"></div>
		</form>
		<h3>인기 업로드</h3>
		<form action="playUploaded.do" method="post" id="playUploaded">
			<input type="hidden" name="roomName" value="">
			<div id="uploaded" style="display: flex; margin-left: 0px;"></div>
		</form>
		<!-- 방송 들어가기 -->

	</div>
	<script>
     //생방접근
     function moveRoom(room,remaincount,totalcount,pwd) {
         $("[name='roomName']").val(room);               
         $("#moveChatForm").submit();   
	}
     //업로드영상 접근
     function uploadedRoom(room,remaincount,totalcount,pwd) {
         $("[name='roomName']").val(room);               
         $("#playUploaded").submit();   
	}
   </script>
</body>
</html>