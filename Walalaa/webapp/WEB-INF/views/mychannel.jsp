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
<title>MyChannel</title>

<!-- jQuery (부트스트랩의 자바스크립트 플러그인을 위해 필요합니다) -->
<script type="text/javascript"
	src="${pageContext.request.contextPath}/assets/js/jquery-1.12.4.js"></script>



<style type="text/css">
@import url(//fonts.googleapis.com/earlyaccess/jejugothic.css);

body {
	margin: 0;
	font-family: 'Jeju Gothic', sans-serif;
}

.profileinfo {
	height: 60px;
	width: 970px;
	resize: none;
	margin-left: 20px;
	margin-top: -10px;
	margin-bottom: 5px;
	padding : 5px;
	float: left;
	border-radius: 5px;
	border: 1;
}

.channelimage {
	margin-left: auto;
	margin-right: auto;
	width: 1140px;
	height: 150px;
}

/*       채널 이름 */
.channelName {
	margin-left: 170px;
	font-size: 35px;
}

.profileimage {
	display: inline;
	float: left;
	width: 150px;
	height: 150px;
	position: relative;
}

.profilebg {
	display: inline;
	float: left;
	width: 1140px;
	height: 150px;
	position: relative;
}

.image {
	width: 150px;
	height: 150px;
	position: absolute;
	opacity: 1;
	display: block;
	transition: .5s ease;
	backface-visibility: hidden;
}

.image2 {
	width: 1140px;
	height: 150px;
	position: absolute;
	opacity: 1;
	display: block;
	transition: .5s ease;
	backface-visibility: hidden;
}

.middle {
	transition: .5s ease;
	opacity: 0;
	position: absolute;
	top: 50%;
	left: 12%;
	transform: translate(-50%, -50%);
	-ms-transform: translate(-50%, -50%);
	text-align: center;
}

.filebox {
	transition: .5s ease;
	opacity: 0;
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	-ms-transform: translate(-50%, -50%);
	text-align: center;
}

.profileimage:hover .middle {
	opacity: 1;
}

.profileimage:hover .image {
	opacity: 0.3;
}

.profilebg:hover .filebox {
	opacity: 1;
}

.profilebg:hover .image2 {
	opacity: 0.3;
}

.middle label {
	display: inline-block;
	padding: .5em .75em;
	color: #999;
	font-size: inherit;
	line-height: normal;
	vertical-align: middle;
	background-color: #fdfdfd;
	cursor: pointer;
	border: 1px solid #ebebeb;
	border-bottom-color: #e2e2e2;
	border-radius: .25em;
}

.middle input[type="file"] { /* 파일 필드 숨기기 */
	position: absolute;
	width: 1px;
	height: 1px;
	padding: 0;
	margin: -1px;
	overflow: hidden;
	clip: rect(0, 0, 0, 0);
	border: 0;
}

.filebox label {
	display: inline-block;
	padding: .5em .75em;
	color: gray;
	font-size: inherit;
	line-height: normal;
	vertical-align: middle;
	background-color: #fdfdfd;
	cursor: pointer;
	border-bottom-color: #e2e2e2;
	border-radius: .25em;
}

.filebox input[type="file"] { /* 파일 필드 숨기기 */
	position: absolute;
	width: 1px;
	height: 1px;
	padding: 0;
	margin: -1px;
	overflow: hidden;
	clip: rect(0, 0, 0, 0);
	border: 0;
}

/*    프로필 업로드 버튼 */
#uploadlabel {
	margin-left: 115px;
	margin-top: 8px;
	color: gray;
	width: 100px;
}

/*    배경 업로드 버튼 */
#bglabel {
	margin-left: 1018px;
	margin-top: 110px;
	margin-right: 10px;
	width: 120px;
}

.boradbox {
	width: 263px;
	margin-right: 15px;
}

.pageset {
	width: 1080px;
	margin: 0 auto;
}
</style>
<script type="text/javascript">
   
   var stri = "";
   var email = '${login.email}';
   
      $(document).ready(function(){
         $.ajax({
            url : "${pageContext.request.contextPath}/getMyUploadList.do",
            type : "post",
            data : { email : email },
            dataType : "json",
            success : function(myUploadList){
            	lineStart2();
            	for(var j=0; j<myUploadList.length; j++){
                  if(j%4==0 && j!=0){
                     lineRender2(myUploadList[j]);
                  }else{
                     render2(myUploadList[j]);
                  }
            	}
	               lineEnd2();
	               $("#uploaded").append(stri);
            },
            error : function(XHR, status, error) {
               console.error(status + " : " + error);
            }                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
         });
      });

      function lineStart2(){
         stri += "<div class='plzrow'>";
         stri += " <div class='row' style='display: flex; margin-left:0px;'>";
      }
      function render2(ChatVO){
         stri += "   <div class='boradbox img_scale'>";
         stri += "      <div class='thumbnail scale'>";
         stri += "         <a href=\"#\" onclick=\"myUploadedRoom('"+ChatVO.name+"', "+ChatVO.remaincount+", "+ChatVO.totalcount+", '"+ChatVO.pwd+"')\">";
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
         stri += "         <a href=\"#\" onclick=\"myUploadedRoom('"+ChatVO.name+"', "+ChatVO.remaincount+", "+ChatVO.totalcount+", '"+ChatVO.pwd+"')\">";
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
         stri += " </div>";
         stri += "</div>";
         //$("#liveroom").append(str);   
      }
   </script>
   
   <script type="text/javascript">
   //업로드영상 접근
   function myUploadedRoom(room,remaincount,totalcount,pwd) {
       $("[name='roomName']").val(room);               
       $("#playUploaded").submit();   
	}
   </script>


</head>
<body>
   <%
      UserVO login = (UserVO) session.getAttribute("login");
   %>
	<jsp:include page="/WEB-INF/views/search_navbar.jsp"></jsp:include>

	<div class="channelimage">
		<div class="profilebg">
			<img class="image2"
				src="${pageContext.request.contextPath}${user.bgimg}">
			<div class="filebox">
				<form action="#" enctype="multipart/form-data" method="post"
					id="backgroundupload">
					<label id="bglabel" for="bgimg">사진 변경</label>
					<input type="file" id="bgimg" class="bgimg">
				</form>
			</div>
		</div>
	</div>

	<br>

	<div class="channelimage">
		<div class="profileimage">
			<img class="proimgsrc image img-circle"
				src="${pageContext.request.contextPath}${user.profile}">
			<div class="middle">
				<form action="#" enctype="multipart/form-data" method="post"
					id="profileupload">
					<label id="uploadlabel" for="proimg">사진 변경</label> <input type="file"
						class="proimg" id="proimg">
				</form>
			</div>
		</div>
		<div>
			<div class="channelName">${user.nickname}</div>
		</div>
		<div>
			<div>
				<h4>
					<textarea class="profileinfo " name="profileinfo" id="profileinfo"
						for="textsubmit" readonly="readonly" maxlength="200" 
						placeholder="여기에 채널 설명을 적어주세요">${user.channelInfo}</textarea>
				</h4>
			</div>
			<div align="right">
				<input type="button" class="btn btn-primary" value="수정"
					id="myButton" name="myButton" style="background: #2e9dfe;">
			</div>
		</div>
	</div>

	<div class="pageset">
	
		<h3>내 동영상</h3>
		<form action="playUploaded.do" method="post" id="playUploaded">
			<input type="hidden" name="roomName" value="">
			<div id="uploaded" style="display: flex; margin-left: 0px;"></div>
		</form>
	
	</div>


	<script>
		$(document).ready(function() {

			var readURL = function(input) {
				if (input.files && input.files[0]) {
					var reader = new FileReader();

					reader.onload = function(e) {
						$('.proimgsrc').attr('src', e.target.result);
					}

					reader.readAsDataURL(input.files[0]);

					var form = $('#profileupload')[0];
					var formData = new FormData(form);
					formData.append("profile", input.files[0]);

					$.ajax({
						url : "profileuplaod.do",
						type : "post",
						data : formData,
						processData : false,
						contentType : false,
						success : function() {
							alert("프로필 변경완료");

						},
						error : function(XHR, status, error) {
							console.error(status + " : " + error);
						}

					});
				}
			}
			var readURL2 = function(input) {
				if (input.files && input.files[0]) {
					var reader = new FileReader();

					reader.onload = function(e) {
						$('.image2').attr('src', e.target.result);
					}

					reader.readAsDataURL(input.files[0]);

					var form = $('#backgorundupload')[0];
					var formData = new FormData(form);
					formData.append("bgimg", input.files[0]);

					$.ajax({
						url : "backgrounduplaod.do",
						type : "post",
						data : formData,
						processData : false,
						contentType : false,
						success : function() {
							alert("프로필 변경완료");

						},
						error : function(XHR, status, error) {
							console.error(status + " : " + error);
						}

					});
				}
			}

			$(".proimg").on('change', function() {
				var img = readURL(this);
			});
			$(".bgimg").on('change', function() {
				var img = readURL2(this);
			});

		});
	</script>


	<script type="text/javascript">
		document.getElementById('myButton').onclick = function() {
			
			if (this.value == "수정") {
				document.getElementById('profileinfo').readOnly = false;
				this.value = '적용';
			} else {
				
				var channelInfo = $("#profileinfo").val();
				var email = '${login.email}';

				$.ajax({
					url : "changeChannelInfo.do",
					type : "post",
					data : {
						email : email,
						channelInfo : channelInfo
					},
					success : function() {
						alert("채널 설명을 [ "+ channelInfo + " ]로 수정합니다.");
					},
					error : function(XHR, status, error) {
						console.error(status + " : " + error);
					}
				});

				document.getElementById('profileinfo').readOnly = true;
				this.value = '수정';
			}
		};
	</script>
</body>
</html>