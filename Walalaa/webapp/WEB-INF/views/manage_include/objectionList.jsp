<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 위 3개의 메타 태그는 *반드시* head 태그의 처음에 와야합니다; 어떤 다른 콘텐츠들은 반드시 이 태그들 *다음에* 와야 합니다 -->
    <title>부트스트랩 101 템플릿</title>

    <!-- 부트스트랩 -->
    <link href="${pageContext.request.contextPath}/assets/bootstrap/css/bootstrap.css" rel="stylesheet">
   
    <!-- jQuery (부트스트랩의 자바스크립트 플러그인을 위해 필요합니다) -->
    <script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/jquery-1.12.4.js"></script>
    <!-- 모든 컴파일된 플러그인을 포함합니다 (아래), 원하지 않는다면 필요한 각각의 파일을 포함하세요 -->
    <script src="${pageContext.request.contextPath}/assets/bootstrap/js/bootstrap.js"></script>
        <style>
            body{
                padding: 0px;
                margin: 0px;
                font-size: 17px;
            }
                           
            .tr_bottomline{
               border-bottom: 1px solid;
                border-bottom-color: lightgray;
                margin-bottom: 40px;
            }        
                   
            .no_border_table{
               border: none;
               margin: 5px;
               width: 99%;
                font-size: 17px;
                text-align: center;
                border-collapse:collapse;
                border-bottom:  1px solid lightgray;
            }
            table th{
                text-align: center;
                margin-bottom: 5px;
            }
            
            tr.ob_list td{
                text-align: center;
                font-size: 15px;
            }
                        
         .btn_color{
            background-color: white;
              color: #4682B4;
              margin: 5px;            
         }
         .btn_color:hover {
            background-color: #f2f2f2;
            color: #4682B4;  
         }
         
         .padding_td {
            padding-left: 20px;
         }  
       </style>

   <script type="text/javascript">
   	var timerPaused = false;
      var str = "";
      
      $(document).ready(function() {
         var num =  $("#roomNum").val();
         
         var timer = window.setInterval( function () {
        	 if(!timerPaused){
	            $.ajax({
	               url: "getObjList.do",
	               type: "post",
	               data : num,
	               contentType : "application/json",
	               dataType: "json",
	               success: function(ObjList){   
	                  str = "";
	                  start();
	                  for(var i = 0; i<ObjList.length; i++){
	                     showObjList(ObjList[i]);
	                  }
	                  end();
	                  $("#objshow").empty();
	                  $("#objshow").append(str);
	                  
	                  
	                  
	               },
	                  error : function(XHR, status, error) {
	                      console.error(status + " : " + error);
	                  }                   
	            });
        	 }
         }, 2000);   //5초에 한번
         
         function start() {
            str += "<table class=\"no_border_table\">";
            str += "    <tr class=\"tr_bottomline\">";
            str += "        <th class='col-xs-1'>닉네임</th>";
            str += "        <th class='col-xs-5'>내용</th>";
            str += "        <th class='col-xs-1'>경고 </th>";
            str += "        <th class='col-xs-1'>승인여부</th>";
            str += "        <th class='col-xs-1'>상태</th>";
            str += "        <th class='col-xs-2'>시간</th>";
            str += "    </tr>";
         }
         
         function showObjList(ObjectionVO) {
            str += "<tr class=\"ob_list\">";
            str += "    <td class=\"dropdown padding_td\">";
            str += "        <button class=\"btn dropdown-toggle btn_color btn-group pause\" type=\"button\" data-toggle=\"dropdown\">";
            str += "            "+ ObjectionVO.usersNickname;
            str += "            <span class=\"caret\"></span></button>";
            str += "            <ul class=\"dropdown-menu\">";
            str += "                <li><a href=\"#\" class='doNochat' data-email='"+ObjectionVO.id+"'>채팅금지</a></li>";
            str += "                <li><a href=\"#\" data-email='"+ObjectionVO.id+"'>추방하기</a></li>";
            str += "                <li><a href=\"#\" data-email='"+ObjectionVO.id+"'>신고하기</a></li>";
            str += "                <li><a href=\"#\" class='addblacklist' data-value='black' data-email='"+ObjectionVO.id+"'>블랙리스트 등록</a></li>";
            str += "            </ul>";
            str += "    </td>";
            str += "    <td>" + ObjectionVO.content + "</td>";
            str += "    <td>" + ObjectionVO.chatmemWarningCount + "</td>";
            str += "    <td> ";
            if(ObjectionVO.approv_state == 0){
               str += "        <button id='acceptBtn' class='check_btn check_btn_img_swap' data-number='" + ObjectionVO.objnum + "' >";
               str += "            <img src=\"${pageContext.request.contextPath}/assets/images/check.png\">";
               str += "            <img src=\"${pageContext.request.contextPath}/assets/images/check_hover2.png\">";
               str += "        </button>";
               str += "        <button id='rejectBtn' class='no_check_btn no_check_btn_img_swap'  data-number='" + ObjectionVO.objnum + "' >";
               str += "            <img src=\"${pageContext.request.contextPath}/assets/images/no_check.png\">";
               str += "            <img src=\"${pageContext.request.contextPath}/assets/images/no_check_hover2.png\">";
               str += "        </button>";
            } else if(ObjectionVO.approv_state == 1) {
               str += "        <button class='check_btn ' >";
               str += "            <img src=\"${pageContext.request.contextPath}/assets/images/check_hover2.png\">";
               str += "        </button>";
            } else if(ObjectionVO.approv_state == 2) {
               str += "        <button class='no_check_btn ' >";
               str += "            <img src=\"${pageContext.request.contextPath}/assets/images/no_check_hover2.png\">";
               str += "        </button>";
            }
            str += "    </td>";
            var status = ObjectionVO.chatmemChatstatus.substr(0,6);
            str += "    <td> " + status + "</td>";
            str += "    <td> " + ObjectionVO.time +" </td>";
            str += "</tr>";
         }
         
         function end() {
            str += "</table>";
         }
      
      });
  
   
   </script>

    </head>
    <body>
       <input type="hidden" id="roomNum" name="roomNum" value="${roomNum}" />
    
       <!-- 등록된 이의신청 보여주는 테이블 -->
       <div id="objshow"></div>   
    
    <script>
    
        //승인버튼 클릭했을때
       $("#objshow").on("click", ".check_btn", function(){
          //승인 버튼을 변수에 넣음
          var $acceptBtn = $(this);
          //button 의 숨겨진 data 값 변수에 넣기
          var num = $acceptBtn.data("number");
          //새로고침 후 버튼클릭 시 오류 방지를 위함
          if(num != null){
             //accept 아작스 함수 처리
             accept(num);
             // 같은 형제위치의 버튼 변수넣기
             var $rejectBtn = $(this).siblings();
             // 버튼지우기
             $rejectBtn.remove();
          }
       });
        //거절버튼 클릭했을때
       $("#objshow").on("click", ".no_check_btn", function(){
          //거절 버튼을 변수에 넣음
          var $rejectBtn = $(this);
          //button 의 숨겨진 data 값 변수에 넣기
          var num = $rejectBtn.data("number");
          //새로고침 후  버튼클릭 시 오류 방지를 위함
          if(num != null){
             //reject 아작스 함수 처리
             reject(num);
             // 같은 형제위치의 버튼 변수넣기
             var $acceptBtn = $(this).siblings();
             // 버튼지우기as
             $acceptBtn.remove();
          }
       });
        
    
       function accept(num){
          var objnum = num;
            $.ajax({
               type : "post",
               data : {objnum: objnum},
               url : "${pageContext.request.contextPath}/objAccept.do",
               success : function(){
               alert("승인되었습니다");
               },
               error : function(XHR, status, error) {
                  console.error(status + " : " + error);
               }                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
      
          });
      }
       function reject(num){
          var objnum = num;
            $.ajax({
               type : "post",
               url : "${pageContext.request.contextPath}/objReject.do",
               data : {objnum: objnum},
               success : function(){
                  alert("반려되었습니다.");
               },
               error : function(XHR, status, error) {
                  console.error(status + " : " + error);
               }                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
         
         });
      }                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
                  
    </script>
	<script>
	var ajaxstatus = 0;
	    $("#objshow").on('click', '.pause', function() {   
	    	timerPaused = true;
	    	setTimeout(function(){
				ajaxstatus = 1;
	    	}, 1000);
	      });
	   	
	   	$("#objshow").on('click', function(){
	   		if(ajaxstatus==1){
	   			timerPaused = false;
	   			ajaxstatus =0;
	   		}
	   	});
	 </script>
	 <script>   
	   	$("#objshow").on('click', '.doNochat', function() {
	         var $this = $(this);
	         var email = $this.data("email");
	         
	         $.ajax({
	            type: "post",
	            url: "${pageContext.request.contextPath}/Nochat.do",
	            data : {email:email},
	            success : function() {
	            	alert("채팅금지되었습니다.");
	            }
	         });
	      });
	</script>
	   <script>
   
      $(document).on('click', '.addblacklist', function() {   
         var $this = $(this);
         var email = $this.data("email");
         var value = $this.data("value");
         var num = ${roomNum};
         
         
         $.ajax({
            type: "post",
            url: "${pageContext.request.contextPath}/listupdate.do",
            data : {email:email, value:value, num : num},
            success : function() {
            }
         });
      });
   
   
   </script>
    </body>
    


</html>