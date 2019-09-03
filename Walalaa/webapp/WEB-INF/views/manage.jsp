<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- 위 3개의 메타 태그는 *반드시* head 태그의 처음에 와야합니다; 어떤 다른 콘텐츠들은 반드시 이 태그들 *다음에* 와야 합니다 -->
<title>관리자 창</title>


<!-- jQuery (부트스트랩의 자바스크립트 플러그인을 위해 필요합니다) -->
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/jquery-1.12.4.js"></script>
	<style>
		/*    이의제기 - 승인 */
		   .check_btn{
		    background: white;
		    border: none;
		    width: 30px;
		    height: 30px;
		   }   
		/*   [호버] 이의제기 - 승인*/
		   .check_btn_img_swap img:last-child{display:none;}
		   .check_btn_img_swap:hover img:first-child{display:none;}
		   .check_btn_img_swap:hover img:last-child{display:inline-block;}
		                
		/*    이의제기 - 거부 */
		   .no_check_btn{
		    background: white;
		    border: none;
		    width: 30px;
		    height: 30px;
		   }   
		/*   [호버] 이의제기 - 거부*/
		   .no_check_btn_img_swap img:last-child{display:none;}
		   .no_check_btn_img_swap:hover img:first-child{display:none;}
		   .no_check_btn_img_swap:hover img:last-child{display:inline-block;}
	</style>
	
</head>
<body>
	<jsp:include page="search_navbar.jsp"></jsp:include>
	
	<div class="container">
		<h4>${roomName }</h4>
		<!-- 아코디언 패널이 표시되는 경우는 true로, 숨겨지는 경우는 false로 표시합니다.
			 예: <button aria-expanded=”true”> (아코디언 패널이 확장된 경우) -->
		<ul id="myTab" class="nav nav-tabs" role="tablist">
			<li role="presentation" class="active">
				<a href="#objectionList"	id="objectionList-tab" role="tab" data-toggle="tab"	aria-controls="objectionList" aria-expanded="true">
				이의제기 신청 목록</a></li>
			<li role="presentation" class="">
				<a href="#userManage" role="tab" id="userManage-tab" data-toggle="tab" aria-controls="userManage" aria-expanded="false">
				사용자 관리</a></li>
			<li role="presentation" class="">
				<a href="#BadWordManage" id="BadWordManage-tab" role="tab" data-toggle="tab" aria-controls="BadWordManage" aria-expanded="false">
				비속어 단어 관리</a></li>
			<li role="presentation" class="">
				<a href="#analysis" role="tab" id="analysis-tab" data-toggle="tab" aria-controls="analysis"	aria-expanded="false">
				분석</a></li>
		</ul>
		<div id="myTabContent" class="tab-content">
			<div role="tabpanel" class="tab-pane fade active in" id="objectionList"	aria-labelledby="objectionList-tab">
				<jsp:include page="/WEB-INF/views/manage_include/objectionList.jsp"></jsp:include>
			</div>
			<div role="tabpanel" class="tab-pane fade" id="userManage" aria-labelledby="userManage-tab">
				<jsp:include page="/WEB-INF/views/manage_include/userManage.jsp"></jsp:include>
			</div>
			<div role="tabpanel" class="tab-pane fade" id="BadWordManage" aria-labelledby="BadWordManage-tab">
				<jsp:include page="/WEB-INF/views/manage_include/BadWordManage.jsp"></jsp:include>
			</div>
			<div role="tabpanel" class="tab-pane fade" id="analysis" aria-labelledby="analysis-tab">
			<jsp:include page="/WEB-INF/views/manage_include/analysis.jsp"></jsp:include>
			</div>
		</div>

	</div>


</body>
</html>