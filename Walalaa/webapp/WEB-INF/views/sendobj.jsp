<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이의제기 신청하기</title>
<!-- 부트스트랩 -->
<link href="${pageContext.request.contextPath}/assets/bootstrap/css/bootstrap.css" rel="stylesheet">
<!-- jQuery (부트스트랩의 자바스크립트 플러그인을 위해 필요합니다) -->
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/jquery-1.12.4.js"></script>

<style>
@import url(//fonts.googleapis.com/earlyaccess/jejugothic.css);

#topchat {
   margin-top: 5px;
   margin-bottom: 5px;
   width: 450px;
   display: inline-flex;
   border-bottom: 1px solid lightgray;
   padding-left: 150px;
   /*    부트스트랩 기본색 #337ab7  밝은파란색 2e9dfe*/
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

/* 이의제기 신청하기 글자 크기 */
.bigFont {
   color: #2e9dfe;
   font-size: 20px;
   margin-bottom: 5px;
}

.object {
/*    border-bottom: 1px solid lightgray; */
}

/*    이의제기 버튼    */
.eej {
   margin-top: 10px;
   margin-right: 170px;
   background-color: #2e9dfe;
}

body {
   padding: 0px;
   margin: 0px;
   width: 450px;
   font-family: 'Jeju Gothic';
   font-size: 16px;
}
</style>
</head>
<body>

   <div id='obj' style="border-bottom: 1px solid lightgray;">
   <label id="topchat"><b class="bigFont"> 이의제기 신청하기 </b></label>
      <form id="objgogo" action="insertObj.do">
      
         <div id="objlist"></div>
      
         <button type="button" class="btn btn-primary btn-lg eej" onclick="request()" style="float: right;">이의제기</button>
      </form>
   </div>
   <script>
   var objlist = "${objlist}";
   objlist = objlist.substr(1);
   objlist = objlist.substr(0, objlist.length-1);
   var objs= objlist.split(", ");
   var str = ""; 
   var num = 0;
      $(document).ready(function(){         
         for(var i = 0; i<objs.length; i++){
            var msg = objs[i].split(":");
            render(msg[1],msg[2], objs[i]);
            
         };
            $("#objlist").append(str);
         });
      function render(msg, time, objectionInfo){
        if(msg != null) {
            str += "<div class='object' style='padding-left: 10px;'>";
            //str += "<input type = 'text' class='msginput' readonly style='width: 400px; height: 30px;' value="+msg+">";
            str += "<label for='list"+num+"' class='msginput' style='width: 400px; height: 30px; cursor:pointer'>"+msg+"</label>";
            str += "<input id='list"+num+"' type='checkbox' name='objection' style='width: 30px;' value='"+objectionInfo+"'><br>";
            str += "</div>";
            num++;
        } else {
           str += "<div class='object' style='padding-left: 10px;'>";
           str += "<label class='msginput' style='width: 400px; height: 30px;'> 이의제기할 내용이 없습니다 </label>";
           str += "</div>";
        }
      };
   </script>

   <script>
      function request(){
         var send = confirm("이의신청을 하시겠습니까?'\n'허위 신청시 제재를 받을 수 있습니다.");
         if(send){   //확인 버튼 눌렀 -> YES
            $("#objgogo").submit();
            alert("신청완료");
         }
      }      
   </script>
</body>
</html>