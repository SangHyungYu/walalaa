<%@page import="com.utf18.site.vo.UserVO"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
   <style>
      .backgr{
         display: flex;
      }
      .header {
         width: 100%;
         height: 30px;
         align-content: center;
         margin-top: 20px;
         border-bottom: 1px solid lightgray;
      }
      .divsize {
         width: 380px;
         height: 300px;
      }
      
      .labeltxt {
         width: 313px;
         text-align: center;
      }
      
      .content {
         margin-top: 10px;
         text-align: center;
      }
      
      .dropdown-menu {
          position:absolute;
          background-color: white;
          right: auto;
          width : 100px;
          transform: translate(50%);
      }
      
      .dropposition {
         position: relative;
      }
      
      .btnDelete {
        background:
           url(${pageContext.request.contextPath}/assets/images/delete03.png) center
           no-repeat #fff;
        width: 30px; height : 33px;
        border: none;
      }
      /* [호버] 삭제 버튼 */
      .btnDelete:hover {
         background:
            url(${pageContext.request.contextPath}/assets/images/delete03_hover.png)
            center no-repeat #fff;
         width: 30px; height : 33px;
         border: none;
      }
         
   </style>
   
   <script type="text/javascript">
      var str_ppl = "";   // 현재 접속 중인 시청자 그리기용
      var str_bl = "";   // 방송자의 블랙리스트 그리기 용
      var str_op = "";   // 방송자의 운영자 그리기용
      var id = '${login.email}';
      var timerPaused2 = false;
      
      $(document).ready(function() {
         var num = $("#roomNum").val();
         timer = setInterval( function () {
         if(!timerPaused2){
            $.ajax({
               url: "${pageContext.request.contextPath}/getCnntPPL.do",
               type: "post",
               data: {num: num},
               success: function(userVOs){   
                  str_ppl = "";
                  for(var i=0; i < userVOs.length; i++) {
                     showPPL(userVOs[i]);
                  }
                  $("#showCnntPPL").empty();
                  $("#showCnntPPL").append(str_ppl);
               },
                  error : function(XHR, status, error) {
                      console.error(status + " : " + error);
                  }  
            });
            
            $.ajax({
               url: "${pageContext.request.contextPath}/getBlackListUser.do",
               type: "post",
               data: {id : id},
               success: function(info){
                  str_bl = "";
                  $("#showBlacklist").empty();
                  if(info[0]!=null){
	                  for(var i=0; i<info.length; i++){
	                     showBlacklist(info[i]);
	                  }
	                  $("#showBlacklist").append(str_bl);
                  }
               }, error : function(XHR, status, error) {
                      console.error(status + " : " + error);
               }  
            });
            
            $.ajax({
                url: "${pageContext.request.contextPath}/getOperListUser.do",
                type: "post",
                data: {id : id},
                success: function(info){
                   str_op = "";
                   if(info[0]!=null){
	                   $("#showOperList").empty();
	                   for(var i=0; i<info.length; i++){
	                      showOperList(info[i]);
	                   }
	                   $("#showOperList").append(str_op);
                   }
                }, error : function(XHR, status, error) {
                       console.error(status + " : " + error);
                }  
             });
         }
         }, 3000);   //5초에 한번
         function showPPL(userVOs) {
           if(userVOs.email != id) {
               str_ppl += " <div class='dropposition'>";
               str_ppl += "   <button class='btn dropdown-toggle btn-group btn_color pause' type='button' data-toggle='dropdown' > ";
               str_ppl +=       userVOs.nickname;
               str_ppl += "      <span class='caret'> </span>";
               str_ppl += "   </button>";
               str_ppl += "   <ul class='dropdown-menu' id='dropvalue' >";
               str_ppl += "      <li><a href='#' data-value='userchat' data-email='"+userVOs.email+"'>채팅 모아보기</a></li>";
               str_ppl += "      <li class='divider'></li>";
               str_ppl += "      <li><a href='#' data-value='black' data-email='"+userVOs.email+"' >블랙리스트 추가</a></li>";
               str_ppl += "      <li><a href='#' data-value='oper' data-email='"+userVOs.email+"' >운영자 추가</a></li>";
               str_ppl += "   </ul>";
               str_ppl += "   <br>";
               str_ppl += " </div>";
           }
         }
         
         function showBlacklist(UserVO) {
               str_bl += "   <div style='display:flex;' >";
               str_bl += "       <div style='width:270px; height:42px; padding-top:10px;' >";
               str_bl += "   "       + UserVO.nickname;
               str_bl += "       </div>";
               str_bl += "       <div>";
               str_bl += "          <button id='delBL' class='delBL btnDelete' data-email='"+ id +"' data-list='"+ UserVO.email +"' style='position=right;' >";
               str_bl += "          </button>";
               str_bl += "       </div>";
               str_bl += " </div>";
         }
         
         function showOperList(UserVO) {
               str_op += "   <div style='display:flex;' >";
               str_op += "       <div style='width:270px; height:42px; padding-top:10px;' >";
               str_op += "   " + UserVO.nickname;
               str_op += "       </div>";
               str_op += "       <div>";
               str_op += "          <button id='delOL' class='delOL btnDelete' data-email='"+ id +"' data-list='"+ UserVO.email +"'>";
               str_op += "          </button>";
               str_op += "       </div>";
               str_op += " </div>";
         }
      });
   </script>


</head>
<body>
   <% UserVO login = (UserVO) session.getAttribute("login"); %>
   <input type="hidden" id="roomNum" name="roomNum" value="${roomNum}" />
   
         
   <div id="backgr" class="backgr">
      <div class="divsize">
         <div class="header">
            <label class="labeltxt">현재 접속중</label>
         </div>
         <div class="content" id="showCnntPPL">
         </div>
      </div>   

      <div class="divsize" id="">
         <div class="header">
            <label class="labeltxt">블랙리스트</label>
         </div>
         <div class="content" id="showBlacklist">
         </div>
      </div>
   
      <div class="divsize">
         <div class="header">
            <label class="labeltxt">운영자리스트</label> 
         </div>
         <div class="content" id="showOperList">
         </div>
      </div>
   </div>
   
   <script>
      $("#showBlacklist").on("click", ".delBL", function(){
          //승인 버튼을 변수에 넣음
          var $DelBtn = $(this);
          //button 의 숨겨진 data 값 변수에 넣기
          var email = $DelBtn.data("email");
          var list = $DelBtn.data("list");
         deleteBList(email, list);
       });
      
      $("#showOperList").on("click", ".delOL", function(){
          //승인 버튼을 변수에 넣음
          var $DelBtn = $(this);
          //button 의 숨겨진 data 값 변수에 넣기
          var email = $DelBtn.data("email");
          var list = $DelBtn.data("list");
          deleteOList(email, list);
       });
      
      function deleteBList(email, delBList) {
         $.ajax({
            type: "post",
            url : "${pageContext.request.contextPath}/delBlackList.do",
               data : {email: email, delBList: delBList}, 
               success : function(){
               },
               error : function(XHR, status, error) {
                  console.error(status + " : " + error);
               }   
         });
      }

      function deleteOList(email, delOList) {
         $.ajax({
            type: "post",
            url : "${pageContext.request.contextPath}/delOperList.do",
               data : {email: email, delOList: delOList}, 
               success : function(){
               },
               error : function(XHR, status, error) {
                  console.error(status + " : " + error);
               }   
         });
      }
   </script>
   <script>
	var ajaxstatus2 = 0;
	    $("#backgr").on('click', '.pause', function() {   
	    	timerPaused2 = true;
	    	setTimeout(function(){
				ajaxstatus2 = 1;
	    	}, 1000);
	      });
	   	
	   	$("#backgr").on('click', function(){
	   		if(ajaxstatus2==1){
	   			timerPaused2 = false;
	   			ajaxstatus2 =0;
	   		}
	   	});
	</script>
   <script>
   
      $(document).on('click', '.dropdown-menu li a', function() {   
         var $this = $(this);
         var email = $this.data("email");
         var value = $this.data("value");
         var num = ${roomNum};
         
         if(value === 'userchat') {
             window.open("userchatlog.do?email="+email, "유저채팅", "toolbar = 0, scrollbars = 1, statusbar = 0, menubar = 0, resizable = 0, width=1080px, height=500px, left= 300, top= 200");
          } else {
	         $.ajax({
	            type: "post",
	            url: "${pageContext.request.contextPath}/listupdate.do",
	            data : {email:email, value:value, num : num},
	            success : function() {
	            }
	         });
          }
      });
   
   
   </script>
   
</body>

</html>