<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<%
int dayIndex = CmmUtil.nvl(request.getAttribute("dayIndex"));
int percentD = CmmUtil.nvl(request.getAttribute("percentD"));
int timeIndex = CmmUtil.nvl(request.getAttribute("timeIndex"));
int percentT = CmmUtil.nvl(request.getAttribute("percentT"));
int percentM = CmmUtil.nvl(request.getAttribute("percentM"));
int percentF = CmmUtil.nvl(request.getAttribute("percentF"));

%>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>board</title>
	<%@ include file="/WEB-INF/view/seller/topCssScript.jsp" %>
	<!-- 합쳐지고 최소화된 최신 CSS -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
	
	<!-- 부가적인 테마 -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
	
	<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
	<!-- 차트 -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script>

	
</head>
<body>
	<table style="height: 100%; width: 100%">
		<tr height="7%" bgcolor="#333333">
			<td>
				<%@ include file="/WEB-INF/view/seller/topBody.jsp" %>
			</td>
		</tr>
		<tr bgcolor="">
			<td>
				<div class="container" style="height:100%">
					<h3>매출분석</h3>
					<hr>
					<h3>
						<span class="label label-Warning">수요일, 18~21시의 매출비중이 높고 , 40~44세 남성이 주요고객</span>
					</h3>
					<span>
						분석지역 내 매출특성은 수요일(16.6%), 18~21시(26.9%) 사이의 매출이 높은 것으로 나타났고 , 
						40~44세 남성 (10.5%)이 주요고객인 것으로 분석 되었습니다 .	
					</span>
					<div style="border:1px solid black;" class="col-sm-12">
					
						<div class="col-sm-6">
							<canvas id="myChart" width="400" height="400"></canvas>
						</div>
						<div class="col-sm-6">
							<canvas id="myChart2" width="400" height="400"></canvas>
						</div>
						
					</div>
					***********************************************************<br/>
					select to_char(sysdate, 'yy/mm/dd/dy/hh24/mi/ss') from dual;<br/>
					18/08/21/화/17/47/16 <br/>
					ORDER_WAIT ORD_DATE 값 INSERT 형식으로 넣으세요 까먹지말고<br/>
					***********************************************************
					
				</div>
			</td>
		</tr>
		<tr height="7%" bgcolor="#333333">
			<td>
				<%@ include file="/WEB-INF/view/seller/bottom.jsp" %>
			</td>
		</tr>
	</table>
	
	<!-- 요일별 차트 -->
	<script>
		var ctx = document.getElementById("myChart").getContext('2d');
		var myChart = new Chart(ctx, {
		    type: 'line',
		    data: {
		        labels: ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"],
		        datasets: [{
		            label: '# day',
		            data: [5, 10, 3, 7, 18, 15, 4],
		            backgroundColor: [
		                'rgba(255, 99, 132, 0.2)',
		                'rgba(54, 162, 235, 0.2)',
		                'rgba(255, 206, 86, 0.2)',
		                'rgba(75, 192, 192, 0.2)',
		                'rgba(153, 102, 255, 0.2)',
		                'rgba(255, 159, 64, 0.2)'
		            ],
		            borderColor: [
		                'rgba(255,99,132,1)',
		                'rgba(54, 162, 235, 1)',
		                'rgba(255, 206, 86, 1)',
		                'rgba(75, 192, 192, 1)',
		                'rgba(153, 102, 255, 1)',
		                'rgba(255, 159, 64, 1)'
		            ],
		            borderWidth: 1
		        }]
		    },
		    options: {
		        scales: {
		            yAxes: [{
		                ticks: {
		                    beginAtZero:true
		                }
		            }]
		        }
		    }
		});
		</script>
		<!-- 성별 차트 -->
	<script>
		var ctx = document.getElementById("myChart2").getContext('2d');
		var myChart2 = new Chart(ctx, {
		    type: 'pie',
		    data: {
		        labels: ["여성", "남성"],
		        datasets: [{
		            label: '# of Votes',
		            data: [60, 40],
		            backgroundColor: [
		                'rgba(255, 99, 132, 0.2)',
		                'rgba(54, 162, 235, 0.2)'
		            ],
		            borderColor: [
		                'rgba(255,99,132,1)',
		                'rgba(54, 162, 235, 1)'
		            ],
		            borderWidth: 1
		        }]
		    },
		    options: {
		        scales: {
		            yAxes: [{
		                ticks: {
		                    beginAtZero:true
		                }
		            }]
		        }
		    }
		});
		</script>
</body>
</html>