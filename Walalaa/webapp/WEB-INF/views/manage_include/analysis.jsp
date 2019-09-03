<%@page import="com.utf18.site.vo.UserVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!Doctype html>
<html lang="ko">
<head>
<meta charset="utf-8">
<title>관리자창 - 분석</title>
<script type="text/javascript"
	src="https://www.gstatic.com/charts/loader.js"></script>
<style type="text/css">
#analysisTable {
	border-bottom: 1px solid lightgray;
}

#analysisTable>tbody>tr>td {
	padding-bottom: 5px;
}

body {
	font-size: 15px;
}
</style>


<script type="text/javascript">
	var email = '${login.email}';
	var length = 0;
	var chatSplit = "";

	var min = 0; // 분(몫)
	var m = 0; // 분(차트 x축)
	var chattime = new Array(); // 채팅 입력 시간
	var minusTime = ""; // 입력타임-방송시작타임

	chatAmount = Array.apply(null, new Array(999)).map(Number.prototype.valueOf, 0); // 채팅량
	badChatAmount = Array.apply(null, new Array(999)).map(Number.prototype.valueOf, 0); // 비속어 채팅량

	$(document).ready(
		function() {
			var time = $("[name='broadcastStartTime']").val(); // 방송 시작 시간
			console.log("시간: " + time);

			//방송 시간을 초단위로 만들기
			var broadcastStartTime = (time.substr(0, 2) * 3600)
					+ (time.substr(3, 2) * 60)
					+ (time.substr(6, 2) * 1);
			console.log("--------------방송시작타임: "
					+ broadcastStartTime);

			// 실시간 채팅량 가져오기
			$.ajax({
				url : "${pageContext.request.contextPath}/userchat_amount.do",
				type : "post",
				data : { email : email },
				success : function(userchats) {
					for (var i = 0; i < userchats.length; i++) {
						console.log(userchats[i] + " ");
					}

					for (var i = 0; i < userchats.length; i++) {
						if (userchats[i].includes("B%A%D")) {
							chatSplit = userchats[i]
									.split("&/%!");
							chattime = chatSplit[3];
							console.log(chatSplit
									+ "////////////"
									+ chattime);

							//채팅입력 시간을 초단위로 만들기
							var chattime_sec = chattime
									.substr(8, 2)
									* 3600
									+ chattime
											.substr(10, 2)
									* 60
									+ (chattime.substr(12,
											2) * 1);
							console.log("--- 채팅입력타임: "
									+ chattime_sec);

							//minusTime = 입력시간 - 방송시작시간
							minusTime = chattime_sec
									- broadcastStartTime;

							// 분(몫) 구하기
							min = minusTime / 60;

							console.log("minusTime-----"
									+ minusTime
									+ "_________"
									+ Math.floor(min));

							// 비속어 채팅량 카운트
							badChatAmount[Math.floor(min)] = badChatAmount[Math
									.floor(min)] + 1;
							chatAmount[Math.floor(min)] = chatAmount[Math
									.floor(min)] + 1;

						} else {
							chatSplit = userchats[i]
									.split("&/%!");
							chattime = chatSplit[2];
							console.log(chatSplit
									+ "////////////"
									+ chattime);

							//채팅입력 시간을 초단위로 만들기
							var chattime_sec = chattime
									.substr(8, 2)
									* 3600
									+ chattime
											.substr(10, 2)
									* 60
									+ (chattime.substr(12,
											2) * 1);
							console.log("--- 채팅입력타임: "
									+ chattime_sec);

							//minusTime = 입력시간 - 방송시작시간
							minusTime = chattime_sec
									- broadcastStartTime;

							// 분(몫) 구하기
							min = minusTime / 60;

							console.log("minusTime-----"
									+ minusTime
									+ "_________"
									+ Math.floor(min));

							// 채팅량 카운트
							chatAmount[Math.floor(min)] = chatAmount[Math
									.floor(min)] + 1;
						}
					}
				},
				error : function(XHR, status, error) {
					console.error(status + " : " + error);
				}
			});

			//------------------- 차트 사용하기 위한 준비
			google.charts.load('current', {
				'packages' : [ 'corechart' ]
			});
			google.charts.setOnLoadCallback(drawChart);

			function drawChart() {
				console.log(length);
				//------------------- 차트 데이터 설정
				var data = google.visualization.arrayToDataTable([
						// 					if(방송시간이 30분 이하일떄)
						[ '방송시간', '채팅량', '비속어 사용량' ],
						[ (m) + '분', chatAmount[0],
								badChatAmount[0] ],
						[ (m + 1) + '분', chatAmount[1],
								badChatAmount[1] ],
						[ (m + 2) + '분', chatAmount[2],
								badChatAmount[2] ],
						[ (m + 3) + '분', chatAmount[3],
								badChatAmount[3] ],
						[ (m + 4) + '분', chatAmount[4],
								badChatAmount[4] ],
						[ (m + 5) + '분', chatAmount[5],
								badChatAmount[5] ]
				// 					else [30분 60분 90분]
				]);

				//------------------- 그래프 옵션
				var options = {
					title : '실시간 채팅량',
					vAxis : {
						title : '채팅량',
						maxValue : 30,
						minValue : 0
					},
					hAxis : {
						title : '시간 (분)'
					},
					width : 550,
					height : 300,
					curveType : 'function',
					format : 'decimal',
					legend : {
						//------------------- 항목 표시 여부
						position : 'bottom'
					}
				};

				var chart = new google.visualization.LineChart(
						document
								.getElementById('curve_chart_chatting_amount'));

				chart.draw(data, options);
			}

		});
</script>


<script type="text/javascript">
	//------------------- 차트 사용하기 위한 준비
	google.charts.load('current', {
		'packages' : [ 'corechart' ]
	});
	google.charts.setOnLoadCallback(drawChart);

	function drawChart() {
		//------------------- 차트 데이터 설정
		var data = google.visualization.arrayToDataTable([ [ '방송시간', '조회수' ],
				[ '0분', 67 ], [ '1분', 1170 ], [ '2분', 660 ], [ '3분', 1030 ],
				[ '4분', 2045 ], [ '5분', 1994 ] ]);

		//------------------- 그래프 옵션
		var options = {
			title : '조회수 추이',
			vAxis : {
				title : '조회수'
			},
			hAxis : {
				title : '시간 (분)'
			},
			width : 550,
			height : 300,
			curveType : 'function',
			format : 'decimal',
			legend : {
				//------------------- 항목 표시 여부
				position : 'bottom'
			}
		};

		var chart = new google.visualization.LineChart(document
				.getElementById('curve_chart_views_amount'));

		chart.draw(data, options);
	}
</script>


<script type="text/javascript">
	//------------------- 차트 사용하기 위한 준비
	google.charts.load('current', {
		'packages' : [ 'corechart' ]
	});
	google.charts.setOnLoadCallback(drawChart);

	function drawChart() {
		//------------------- 차트 데이터 설정
		var data = google.visualization.arrayToDataTable([ [ '방송시간', '분' ],
				[ '30분', 67 ], [ '60분', 1170 ], [ '90분', 660 ],
				[ '120분', 1030 ], [ '150분', 2045 ], [ '180분', 1994 ],
				[ '210분', 2067 ] ]);

		//------------------- 그래프 옵션
		var options = {
			title : '평균 시청 지속시간',
			vAxis : {
				title : '분'
			},
			hAxis : {
				title : '시간 (분)'
			},
			width : 550,
			height : 300,
			curveType : 'function',
			format : 'decimal',
			legend : {
				//------------------- 항목 표시 여부
				position : 'bottom'
			}
		};

		var chart = new google.visualization.LineChart(document
				.getElementById('curve_chart_views_average'));

		chart.draw(data, options);
	}
</script>

<script type="text/javascript">
	//------------------- 차트 사용하기 위한 준비
	google.charts.load('current', {
		'packages' : [ 'corechart' ]
	});
	google.charts.setOnLoadCallback(drawChart);

	function drawChart() {
		//------------------- 차트 데이터 설정
		var data = google.visualization.arrayToDataTable([ [ '방송시간', '명' ],
				[ '30분', 31 ], [ '60분', 70 ], [ '90분', 75 ], [ '120분', 180 ],
				[ '150분', 209 ], [ '180분', 245 ], [ '210분', 299 ] ]);

		//------------------- 그래프 옵션
		var options = {
			title : '구독자수',
			vAxis : {
				title : '명(누적)'
			},
			hAxis : {
				title : '시간 (분)'
			},
			width : 550,
			height : 300,
			curveType : 'function',
			format : 'decimal',
			legend : {
				//------------------- 항목 표시 여부
				position : 'bottom'
			}
		};

		var chart = new google.visualization.LineChart(document.getElementById('curve_chart_subscribe_amount'));

		chart.draw(data, options);
	}
</script>

</head>
<body>
	<%
		UserVO login = (UserVO) session.getAttribute("login");
	%>
	<input type="hidden" id="roomNum" name="roomNum" value="${roomNum}" />
	<input type="hidden" id="broadcastStartTime" name="broadcastStartTime" value="${broadcastStartTime}" />


	<!-- 차트 생성 구역 -->
	<table id="analysisTable">
		<tr>
			<td><div id="curve_chart_chatting_amount" style="width: 550px; height: 300px"></div></td>
			<td><div id="curve_chart_views_amount" style="width: 550px; height: 300px"></div></td>
		</tr>
		<tr>
			<td><div id="curve_chart_views_average" style="width: 550px; height: 300px"></div></td>
			<td><div id="curve_chart_subscribe_amount" style="width: 550px; height: 300px"></div></td>
		</tr>
	</table>
</body>
</html>