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
	width: 100%;
	margin-right: 12px;
}

.pageset {
	width: 100%;
	margin: 0 auto;
	margin-top: 15px;
}

.thumbnail {
	width: 100%;
	height: 50%;

}
.row{
	height: 300px;
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
                  if(i%2==0 && i!=0){
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
         str += " <div class='row' style='display: flex; margin-left:0px; width: 100%;'>";
         
         //$("#liveroom").append(str);   
      }
      function render(ChatVO){
          //var str = "";
          str += "   <div class='boradbox img_scale' style='width: 50%;'>";
          str += "      <div class='thumbnail scale' style='border: 1px solid lightgray; height: 50%;  margin-bottom: 10px;'>";
          str += "         <a href=\"#\" onclick=\"moveRoom('"+ChatVO.name+"', "+ChatVO.remaincount+", "+ChatVO.totalcount+", '"+ChatVO.pwd+"')\">";
          str += "         <img src='${pageContext.request.contextPath}"+ChatVO.thumbnail+"' class='img-responsive' alt='썸네일 ' style='width: 100%; height: 100%;'></a>";
          str += "      </div>";
          str += "         <div class='caption'>";
          str += "				<h4>" +ChatVO.name+"</h4>";
          str += "        		<div style='display: flex;'>";
          str += "           		<div style='float:left; margin-right:5px; margin-bottom: 2px; width:20%;'><img src='${pageContext.request.contextPath}"+ChatVO.profile+"' class='img-responsive img-circle' style='width: 100%; height: 100%;'></div>";
          str += "           		<div style='float:left;width:50%;'>"+ChatVO.usersNickname+"</div>";
          str += "        		</div>";
          str += "        	</div>";
          str += "          <div style='margin-top:15px; padding-left:10px; height: 10%;'>조회수 "+ChatVO.views+"회 · "+ChatVO.uploadtime+"</div>";
          str += "   </div>";
       }   
       function lineRender(ChatVO){
           str += "</div>";
           str += "<div class='row' style='display: flex; margin-left:0px;'>";
           str += "   <div class='boradbox img_scale' style='width: 50%;'>";
           str += "      <div class='thumbnail scale' style='border: 1px solid lightgray; height: 50%;  margin-bottom: 10px;'>";
           str += "         <a href=\"#\" onclick=\"moveRoom('"+ChatVO.name+"', "+ChatVO.remaincount+", "+ChatVO.totalcount+", '"+ChatVO.pwd+"')\">";
           str += "         <img src='${pageContext.request.contextPath}"+ChatVO.thumbnail+"' class='img-responsive' alt='썸네일 ' style='width: 100%; height: 100%;'></a>";
           str += "      </div>";
           str += "         <div class='caption'>";
           str += "				<h4>" +ChatVO.name+"</h4>";
           str += "        		<div style='display: flex;'>";
           str += "           		<div style='float:left; margin-right:5px; margin-bottom: 2px; width:20%;'><img src='${pageContext.request.contextPath}"+ChatVO.profile+"' class='img-responsive img-circle' style='width: 100%; height: 100%;'></div>";
           str += "           		<div style='float:left;width:50%;'>"+ChatVO.usersNickname+"</div>";
           str += "        		</div>";
           str += "        	</div>";
           str += "          <div style='margin-top:15px; padding-left:10px; height: 10%;'>조회수 "+ChatVO.views+"회 · "+ChatVO.uploadtime+"</div>";
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



</head>
<body>
	<header>
		<jsp:include page="search_navbar_m.jsp"></jsp:include>
	</header>

	<div class="pageset">

		<div class="channelimage">
			<div class="profilebg">
				<a href="http://pubg.game.daum.net/pubg/index.daum"> 
				<img class="image2" src="${pageContext.request.contextPath}/assets/images/ad_PUBG200.gif" style="width: 100%; height:10%;"></a>
			</div>
		</div>

		<h3>실시간 스트리밍</h3>
		<form action="MoveChatRoom_m.do" method="post" id="moveChatForm">
			<input type="hidden" name="roomName" value="">
			<div id="liveroom" style="display: flex; margin-left: 0px;"></div>
		</form>
	

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