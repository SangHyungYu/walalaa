<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- 위 3개의 메타 태그는 *반드시* head 태그의 처음에 와야합니다; 어떤 다른 콘텐츠들은 반드시 이 태그들 *다음에* 와야 합니다 -->
<title>방송설정</title>

<!-- jQuery (부트스트랩의 자바스크립트 플러그인을 위해 필요합니다) -->
<script type="text/javascript"   src="${pageContext.request.contextPath}/assets/js/jquery-1.12.4.js"></script>


   <script type="text/javascript">
      $(function() {
         $("#uploadFile").on('change', function() {
            readURL(this);
         });
      });
   
      function readURL(input) {
         if (input.files && input.files[0]) {
            var reader = new FileReader();
   
            reader.onload = function(e) {
               $('#blah').attr('src', e.target.result);
            }
   
            reader.readAsDataURL(input.files[0]);
         }
      }
   
      $(function() {
         $("#imgInp1").on('change', function() {
            readURL1(this);
         });
      });
   
      function readURL1(input) {
         if (input.files && input.files[0]) {
            var reader = new FileReader();
   
            reader.onload = function(e) {
               $('#blah1').attr('src', e.target.result);
            }
   
            reader.readAsDataURL(input.files[0]);
         }
      }
   </script>
   <script type="text/javascript">
      var bDisplay = true;
      function doDisplay() {
         var con = document.getElementById("myDIV");
         if (con.style.display == 'none') {
            con.style.display = 'block';
         } else {
            con.style.display = 'none';
         }
      }
   
     
     
   
   </script>
   <style>
      form.form-inline>div {
         padding: 10px 0px 10px 0px;
      }
      
      div.tag {
         width: 100%;
      }
      .pageset{
               width: 1080px;
               margin:0 auto;
      }
      label{
      	font-size:  15px;
        width: 138px;
        text-align: right;
        margin-right: 30px;
      }
      .formcenter{
         margin-left: 210px;
      }
      .btn-file{
         width: 360px;
      }
   </style>

</head>
<body>
   
   <jsp:include page="/WEB-INF/views/search_navbar.jsp"></jsp:include>
   <div class="pageset">
      <div class="formcenter" >
      <h3>방송 설정</h3>
      <br>
      <form class="form-inline" name="my_form" id="createForm" action="createChatRoom.do" method="POST"  enctype="multipart/form-data">
         <input type="hidden" id="chkRoomName" value=""> <!-- 방 제목 중복 확인 여부 -->
         <div class="form-group">
            <label for="exampleInputName2">방송제목: </label> 
            <input type="text" class="form-control" name="name" style="width: 360px;">
         </div>
         <br>

         <div class="form-inline form-group form-group-sm">
            <label for="exampleInputEmail2">카테고리:</label>
            <select   class="form-control input-lg" style="width: 360px;">
               <option>게임</option>
               <option>스포츠</option>
               <option>음악</option>
            </select>
         </div>
         <br>

         <div class="form-inline form-group">
            <label for="exampleInputName2">썸네일: </label>
            <span class="btn btn-default btn-file">
               <input type="file" id="uploadFile" class="btn" name ="thumbnail">
               <img id="blah" src="#" alt="(권장)240*140 " style="width:240px; height:140px;">
            </span>
         </div>
         <br>

         <div class="form-group">
            <label for="exampleInputName2">워터마크 이미지: </label>
            <span class="btn btn-default btn-file">
               <input type="file" id="imgInp1" class="btn">
               <img id="blah1" src="#" alt="(권장)50*50 ">
            </span>
         </div>
         <br>

         <div class="form-group">
            <label for="exampleInputName2">설명: </label>
            <textarea class="form-control" name="content" rows="3" style="width: 360px;"></textarea>
         </div>
         <br>

          <div class="tag">
            <label for="exampleInputName2">태그 설정:</label>
           <textarea class="form-control" name="tag" rows="3" placeholder="ex) 배그, 치킨먹는법, 사녹" style="width: 360px;"></textarea>
         </div>
         <br>

         <div class="form-inline form-group form-group-sm">
            <label for="exampleInputName2">화면 공유:</label>
            <select   class="form-control input-lg" style="width: 360px;">
               <option>게임 자동 인식</option>
               <option>화면 공유</option>
               <option>사용자 지정 공유</option>
            </select>
         </div>
         <br>

         <div class="form-group">
            <fieldset id="setting_radio1">
               <label for="exampleInputName2">공개 범위:</label>
               <input type="radio" name="setting_radio1" checked>공개
               <input type="radio" name="setting_radio1">비공개
            </fieldset>
         </div>
         <br>

         <div class="form-group" style="display:flex; ">
            <div>
               <fieldset id="setting_radio2">
                  <label for="exampleInputName2">실시간 채팅:</label>
                  <input type="radio" name="setting_radio2" checked>활성화
                  <input type="radio" name="setting_radio2">비활성화
               </fieldset>
            </div>
            <div style="margin-left:6px; ">
               <input value="고급설정" class="btn" onclick="if(this.parentNode.getElementsByTagName('div')[0].style.display != ''){this.parentNode.getElementsByTagName('div')[0].style.display = '';this.value = '숨기기';}else{this.parentNode.getElementsByTagName('div')[0].style.display = 'none'; this.value = '고급설정';}"
               type="button"/>
               <div id='checkbox_div' style="display:none; border: 1px solid; padding: 10px 10px 10px 10px; border-color:lightgrey;">
                  <input type="checkbox" class="check-all" id="check-all" name='filterword' value='' />전체<br />
                  <input type="checkbox" class="filtercheck" name='filterword1' value='badword' checked>비속어<br>
                  <input type="checkbox" class="filtercheck" name='filterword2' value='ilbe_megal'>일베/메갈<br>
                  <input type="checkbox" class="filtercheck"name='filterword3'  value='adult'>성인<br>
               </div>
            </div>
         </div>
         <div align="center" style="padding-top: 30px; top:9px;">
            <input class="btn btn-primary btn-lg" type="submit" value="방송하기" style="background: #2e9dfe;">
            <input class="btn btn-primary btn-lg" type="submit" value="설정저장" style="background: #2e9dfe;">
         </div>
      </form>
      </div>
   </div>
   <!-- 방 중복 처리 -->
   <script type="text/javascript">
      $("[name='name']").blur(function() {
      var name = $("[name='name']").val();
         if(name !=""){
            $.ajax({
               type:"post",
               url:"checkRoom.do",
               async:true,
               data:"name="+name,
               success:function(msg){
                  if(msg=="1"){
                     $("#chkRoomName").val(name);
                  }
                  else if(msg=="0"){
                     alert("이미 존재하는 방이름 입니다.");
                     $("[name='name']").val("");
                     $("[name='name']").focus();
                  }
               }
            });
         }
      });
   </script>
   <!--  방 생성 정보처리 -->
   <script type="text/javascript">
      $("#submitBtn").click(function() {
         if($("[name='name']").val().length<1){
            alert("방제목을 입력하세요");
            $("[name='name']").focus();
         }
         else if($("[name='name']").val()=="all"){
            alert("해당 방제목은 사용할 수 없습니다.");
         }
         else if($("#chkRoomName").val() ==""){
            alert("이미 방이 존재합니다.");
            $("[name='name']").focus();
         }
         else if($("[name='content']").val().length<1){
            alert("방을 설명하기위한 내용을 입력하세요");
            $("[name='content']").focus();
         }
         else{
            //form처리
            $("#createForm").submit();
         }
      });
      
      $("#backBtn").click(function() {
         $("form").each(function() {
            this.reset();
         });
         $("#listPeople").slideToggle(300);
         $("#showCreateRoom").slideToggle(300);
      });
   </script>
   
   <script>
   // 전채선택 클릭시 기능
   $('.check-all').click( function() {
       $('.filtercheck').prop( 'checked', this.checked );
    });
   $('.filtercheck').click( function() {
	   var checkallbox = document.getElementById("check-all");
       if(checkallbox.checked == true){
    	   $('.check-all').prop( 'checked', this.checked );
       };
    });
   </script>
</body>