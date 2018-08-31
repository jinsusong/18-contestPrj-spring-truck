<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<title>트럭왔냠 전체 관리자</title>

<!-- Bootstrap -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/admin/bootstrap.css">

<!-- 1) Load D3.js and billboard.js separately -->
    <!-- Load D3 -->
    <script src="https://d3js.org/d3.v4.min.js"></script>

    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/admin/billboard.css">
    <script src="<%=request.getContextPath()%>/resources/js/admin/billboard.js"></script>
    <link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/admin/demo.css"  type="text/css" /> 
    <link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/admin/editablegrid-1.0.10.css"  type="text/css" /> 
    <style>
    .table_Hline2{
		padding-top:6px;
		padding-bottom:6px;
		padding-left:15px;
		padding-right:15px;
		background-color:#F2F2F2;
		font-weight:bold;
		font-size:12px;
		border-right:1px solid #cccccc;
		text-align:center;
	}
	
	.table_Hline{
		padding-top:10px;
		padding-bottom:10px;
		padding-left:15px;
		padding-right:15px;
		background-color:#F2F2F2;
		font-weight:bold;
		font-size:12px;
		border-right:1px solid #cccccc;
		text-align:center;
		
	}
	.table_Dline2{
		padding-top:5px;
		padding-bottom:5px;
		padding-left:15px;
		padding-right:15px;
		font-size:11px;
		border-right:1px solid #cccccc;
		text-align:center;
	}
	
	.table_Dline{
		padding-top:8px;
		padding-bottom:8px;
		padding-left:15px;
		padding-right:15px;
		font-size:11px;
		border-right:1px solid #cccccc;
		text-align:center;
	}
	
	.table_line2{
		padding-top:5px;
		padding-bottom:5px;
		padding-left:15px;
		padding-right:15px;
		font-size:11px;
		border-right:1px solid #cccccc;
	}
	
	.table_line{
		padding-top:8px;
		padding-bottom:8px;
		padding-left:15px;
		padding-right:15px;
		font-size:11px;
		border-right:1px solid #cccccc;
		text-align:center;
	}
	
	body{
  background-color: #161616;  
}

#chartdiv {	
   width		: 100%;
	height		: 500px;
	background-color: #161616;  
}

.amcharts-graph-g2 .amcharts-graph-stroke {
  stroke-dasharray: 3px 3px;
  stroke-linejoin: round;
  stroke-linecap: round;
  -webkit-animation: am-moving-dashes 1s linear infinite;
  animation: am-moving-dashes 1s linear infinite;
}

@-webkit-keyframes am-moving-dashes {
  100% {
    stroke-dashoffset: -31px;
  }
}
@keyframes am-moving-dashes {
  100% {
    stroke-dashoffset: -31px;
  }
}


.lastBullet {
  -webkit-animation: am-pulsating 1s ease-out infinite;
  animation: am-pulsating 1s ease-out infinite;
}
@-webkit-keyframes am-pulsating {
  0% {
    stroke-opacity: 1;
    stroke-width: 0px;
  }
  100% {
    stroke-opacity: 0;
    stroke-width: 50px;
  }
}
@keyframes am-pulsating {
  0% {
    stroke-opacity: 1;
    stroke-width: 0px;
  }
  100% {
    stroke-opacity: 0;
    stroke-width: 50px;
  }
}

.amcharts-graph-column-front {
  -webkit-transition: all .3s .3s ease-out;
  transition: all .3s .3s ease-out;
}
.amcharts-graph-column-front:hover {
  fill: #496375;
  stroke: #496375;
  -webkit-transition: all .3s ease-out;
  transition: all .3s ease-out;
}

.amcharts-graph-g3 {
  stroke-linejoin: round;
  stroke-linecap: round;
  stroke-dasharray: 500%;
  stroke-dasharray: 0 \0/;    /* fixes IE prob */
  stroke-dashoffset: 0 \0/;   /* fixes IE prob */
  -webkit-animation: am-draw 40s;
  animation: am-draw 40s;
}
@-webkit-keyframes am-draw {
    0% {
        stroke-dashoffset: 500%;
    }
    100% {
        stroke-dashoffset: 0%;
    }
}
@keyframes am-draw {
    0% {
        stroke-dashoffset: 500%;
    }
    100% {
        stroke-dashoffset: 0%;
    }
}
</style>
<script>
	var rs_RankSet_Check;
	window.onload = function(){
		rs_RankSet_Check = 2;
		var currentDate = new Date();
        var divClock = document.getElementById("divClock");
        
        var dd = currentDate.getDate();
        var mm = currentDate.getMonth()+1; //January is 0!
        var yyyy = currentDate.getFullYear();

        var hour = currentDate.getHours();
        var minute = currentDate.getMinutes();
        
        if(hour<10){
        	hour='0'+hour
        }
        
        if(minute<10){
        	minute='0'+minute
        }
        
        if(dd<10) {
            dd='0'+dd
        } 

        if(mm<10) {
            mm='0'+mm
        } 

        var msg;
        msg = yyyy+".";
        msg += mm+".";
        msg += dd+"　";
        msg += hour+":"
        msg += minute+":";
        msg += "00 기준";
        
         
        document.getElementById("rs_rank").innerHTML=msg;
	}
	
	function rs_RankSet(){
		if(rs_RankSet_Check==1){
			document.getElementById('rs_RankSet_Btn1').style.backgroundColor="#ffffff";
			document.getElementById('rs_RankSet_Btn2').style.backgroundColor="#f2f2f2";
			document.getElementById('rs_RankSet_F1').style.display="block";
			document.getElementById('rs_RankSet_F2').style.display="none";
			
			rs_RankSet_Check=2;
		}else{
			document.getElementById('rs_RankSet_Btn1').style.backgroundColor="#f2f2f2";
			document.getElementById('rs_RankSet_Btn2').style.backgroundColor="#ffffff";
			document.getElementById('rs_RankSet_F1').style.display="none";
			document.getElementById('rs_RankSet_F2').style.display="block";
			
			rs_RankSet_Check=1;
		}
	}
</script>
</head>
<body background="<%=request.getContextPath()%>/resources/img/admin/truck_background.jpg" style="background-size: 100%;">
	<%@include file="admin_top.jsp"%>
	<div class="container" style="background-color:rgba(255,255,255,0.9); padding-top:15px; padding-bottom:30px;">
		<div class="row" style="margin-bottom:15px;">
			<div class="col-xs-12 col-sm-9">
				<div style="height:320px; border:1px solid #cccccc;">
					<h5 style="float:left;">&nbsp;&nbsp;&nbsp;<b>공지사항</b></h5>
					<div style="border-bottom:1px solid #cccccc; margin-bottom:10px; clear:both;"></div>
					<div style="width:auto; height: 262px; margin-left:10px; margin-right:10px;">
						<table style="width:100%; border:1px solid #cccccc;" id="htmlgrid" class="testgrid">
							<tr style="border-bottom:1px solid #cccccc;">
								<th width="12%" class="table_Hline2">게시물 번호</th>
								<th width="60%" class="table_Hline2">제목</th>
								<th width="10%" class="table_Hline2">조회수</th>
								<th width="18%" class="table_Hline2">날짜</th>
							</tr>
							<tr>
								<td class="table_Dline2">1</td>
								<td class="table_line2">공지사항ㅇ입니다아ㅏㅏㅏㅏ <b>[0]</b></td>
								<td class="table_line2" align="center">3</td>
								<td class="table_line2" align="center">2018. 08. 28</td>
							</tr>
						</table>
					</div>
				</div>
			</div>
			<div class="col-xs-12 col-sm-3">
				<div style="height:320px; border:1px solid #cccccc;">
					<h5>&nbsp;&nbsp;&nbsp;<b>실시간 검색 순위</b></h5>
					<div style="border-bottom:1px solid #cccccc; margin-bottom:10px; clear:both;"></div>
					<div style="width:auto; height: 242px; margin-left:10px; margin-right:10px;"> 
						<div class="row" align="center">
							<span style="cursor:pointer; border:1px solid #cccccc; font-size:11px; padding-left:33px; padding-right:33px; padding-top:3px; padding-bottom:3px;"
							id="rs_RankSet_Btn1" onclick="javascript:rs_RankSet()" >
								1~10위
							</span>
							<span style="cursor:pointer; border:1px solid #cccccc; font-size:11px; padding-left:30px; padding-right:30px; padding-top:3px; padding-bottom:3px; background-color:#f2f2f2;"
							id="rs_RankSet_Btn2" onclick="javascript:rs_RankSet()" >
								11위 20위
							</span>
							<div style="border-bottom:1px solid #cccccc; margin-top:3px; margin-left:24px; margin-right:24px; padding-top:10px; height:215px; display:block;" id="rs_RankSet_F1">
							
							</div>
							<div style="border-bottom:1px solid #cccccc; margin-top:3px; margin-left:24px; margin-right:24px; padding-top:10px; height:215px; display:none;" id="rs_RankSet_F2">
							
							</div>
						</div>
					</div>
					<div style="border-top:1px solid #cccccc; margin-bottom:10px; background-color:#f2f2f2; height:30px;clear:both;">
						<h6 style="padding-left:15px; padding-right:15px;" id="rs_rank"></h6>
					</div>
				</div>			
			</div>
		</div>
		<div style="width:100%; border-top:1px solid #333333; border-bottom:1px solid #333333; height:102px; background-color:#161616;">
			<table style="width:100%; height:100%;">
				<tr height="60px" style="border-bottom:1px solid #333333;">
					<td style="border-right:1px solid #333333; width:25%;"></td>
					<td style="border-right:1px solid #333333; width:25%;"></td>
					<td style="border-right:1px solid #333333; width:25%;"></td>
					<td style="width:25%;"></td> 
				</tr>
				<tr height="40px">
					<td style="border-right:1px solid #333333; width:25%;"></td>
					<td style="border-right:1px solid #333333; width:25%;"></td>
					<td style="border-right:1px solid #333333; width:25%;"></td>
					<td style="width:25%;"></td>
				</tr>
			</table>
		</div>
		<script src="https://www.amcharts.com/lib/3/amcharts.js?x"></script>
		<script src="https://www.amcharts.com/lib/3/serial.js?x"></script>
		<script src="https://www.amcharts.com/lib/3/themes/dark.js"></script>
		<div id="chartdiv"></div>
		<div class="row" style="margin-bottom:25px; margin-top:25px;">
			<div class="col-xs-12 col-sm-12" align="center">
				<h5 style="float:left;">&nbsp;|&nbsp;<b>매출통계</b></h5>
				<div style="border-bottom:1px solid #cccccc; margin-bottom:10px; clear:both;"></div>
			</div>
			<div class="col-xs-12 col-sm-6" align="center">
				<div id="LineChart"></div>
			</div>
			<div class="col-xs-12 col-sm-6"  align="center">
				<table class="testgrid" style="width:100%; border:1px solid #cccccc;">
					<tr style="border-bottom:1px solid #cccccc;">
						<th class="table_Hline" width="30%">날짜</th>
						<th class="table_Hline" width="23%">주문</th>
						<th class="table_Hline" width="23%">결제</th>
						<th class="table_Hline" width="23%">환불</th> 
					</tr>
					<tr style="border-bottom:1px solid #e2e2e2;">
						<td class="table_Dline">1</td>
						<td class="table_line"></td>
						<td class="table_line"></td>
						<td class="table_line"></td>
					</tr>
					<tr style="border-bottom:1px solid #e2e2e2;">
						<td class="table_Dline">2</td>
						<td class="table_line"></td>
						<td class="table_line"></td>
						<td class="table_line"></td>
					</tr>
					<tr style="border-bottom:1px solid #e2e2e2;">
						<td class="table_Dline">3</td>
						<td class="table_line"></td>
						<td class="table_line"></td>
						<td class="table_line"></td>
					</tr>
					<tr style="border-bottom:1px solid #e2e2e2;">
						<td class="table_Dline">4</td>
						<td class="table_line"></td>
						<td class="table_line"></td>
						<td class="table_line"></td>
					</tr>
					<tr style="border-bottom:1px solid #e2e2e2;">
						<td class="table_Dline">최근 7일 평균</td>
						<td class="table_line"></td>
						<td class="table_line"></td>
						<td class="table_line"></td>
					</tr>
					<tr style="border-bottom:1px solid #e2e2e2;">
						<td class="table_Dline">최근 7일 합계</td>
						<td class="table_line"></td>
						<td class="table_line"></td>
						<td class="table_line"></td>
					</tr>
					<tr style="border-bottom:1px solid #e2e2e2;">
						<td class="table_Dline">최근 30일 평균</td>
						<td class="table_line"></td>
						<td class="table_line"></td>
						<td class="table_line"></td>
					</tr>
					<tr style="border-bottom:1px solid #e2e2e2;">
						<td class="table_Dline">최근 30일 합계</td>
						<td class="table_line"></td>
						<td class="table_line"></td>
						<td class="table_line"></td>
					</tr>
				</table>
			</div>
		</div>
		<div class="row">
			<div class="col-xs-12 col-sm-12" align="center">
				<h5 style="float:left;">&nbsp;|&nbsp;<b>푸드트럭 랭크</b></h5>
				<div style="border-bottom:1px solid #cccccc; margin-bottom:10px; clear:both;"></div>
				<div style="width:100%; height:auto;">
					<%@include file="admin_truck_slider.jsp"%>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-xs-12 col-sm-12" align="center">
				<h5 style="float:left;">&nbsp;|&nbsp;<b>푸드트럭 위치검색</b></h5>
				<div style="border-bottom:1px solid #cccccc; margin-bottom:10px; clear:both;"></div>
				<div style="width:100%; height:auto;">
					<%@include file="admin_truck_loc.jsp"%>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-xs-12 col-sm-8"  align="center" style="margin-top:15px;">
				<h5 style="float:left;">&nbsp;|&nbsp;<b>사용자 통계</b></h5>
				<div style="border-bottom:1px solid #cccccc; margin-bottom:10px; clear:both;"></div>
				<div id="demo-5"></div>
			</div>
			<div class="col-xs-12 col-sm-4"  align="center" style="margin-top:15px;">
				<h5 style="float:left;">&nbsp;|&nbsp;<b>사용자 성비분포</b></h5>
				<div style="border-bottom:1px solid #cccccc; margin-bottom:10px; clear:both;"></div>
				<div id="Padding"></div>
			</div>
		</div>
	</div>
	<footer class="text-center">
		<hr>
		<%@include file="admin_bottom.jsp"%>
	</footer>
	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<script src="<%=request.getContextPath()%>/resources/js/admin/bootstrap.min.js"></script>
	<script src="<%=request.getContextPath()%>/resources/js/admin/jquery-1.11.2.min.js"></script>
	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script src="<%=request.getContextPath()%>/resources/js/admin/Easygraphs.js"></script>
	<script>
	var chart = bb.generate({
		  data: {
		    columns: [
			["data1", 30, 200, 100, 400, 150, 250],
			["data2", 50, 20, 10, 40, 15, 25]
		    ]
		  },
		  bindto: "#LineChart"
		});
	
	</script>
	<script>
	var chart = bb.generate({
		  data: {
		    columns: [
			["남자", 60],
			["여자", 40],
		    ],
		    type: "pie"
		  },
		  pie: {
		    padding: 2
		  },
		  bindto: "#Padding"
		});
	</script>
	<script>
	var eg5 = new Easygraphs({
	  container: document.getElementById('demo-5'),
	  width: 600,
	  height: 200,
	  color: '#282B2E',
	  padding: {
	    top: 60,
	    right: 30,
	    left: 60
	  },
	  tooltip: {
	    template: '{{ category }}: {{ value }}',
	    widthAuto: true
	  },
	  yAxis: {
	    text: {
	      toFixed: 0,
	      color: '#D6D6D6'
	    },
	    title: {
	      text: 'Share prices',
	      color: '#D6D6D6'
	    },
	    grid: {
	      show: false
	    },
	    border: {
	      color: '#43484C'
	    },
	    segment: {
	      color: '#43484C',
	      width: 5
	    }
	  },
	  xAxis: {
	    text: {
	      color: '#D6D6D6'
	    },
	    labels: ['00', '01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12', '13', '14', '15', '16'],
	    grid: {
	      dasharray: '1%',
	      color: '#43484C'
	    },
	    segment: {
	      width: 1,
	      height: 5,
	      color: '#43484C'
	    },
	    border: {
	      color: '#43484C'
	    }
	  },
	  legends: {
	    color: '#D6D6D6'
	  },
	  dotsOptions: {
	    rx: 0,
	    ry: 0
	  },
	  data: [
	    {
	      name: 'EURO / RUB',
	      dots: {
	        color: 'rgb(231, 93, 93)'
	      },
	      line: {
	        width: 2,
	        color: 'rgb(231, 93, 93)',
	        fill: 'rgba(231, 93, 93, 0.3)'
	      },
	      values: [25, 26, 26, 33, 36, 37, 34, 34, 36, 41, 43, 40, 38, 40, 45, 75, 91]
	    },
	    {
	      name: 'USD / RUB',
	      dots: {
	        color: 'rgb(47, 173, 100)'
	      },
	      line: {
	        width: 2,
	        color: 'rgb(47, 173, 100)',
	        fill: 'rgba(47, 173, 100, 0.3)'
	      },
	      values: [26, 28, 30, 31, 28, 28, 27, 26, 24, 30, 31, 29, 31, 30, 33, 62, 76]
	    }
	  ]
	});
	eg5.render();
	</script>
	<script>
	var chartData = [
	    {
	        "date": "2012-01-01",
	        "distance": 227,
	        "townName": "New York",
	        "townName2": "New York",
	        "townSize": 25,
	        "latitude": 40.71,
	        "duration": 408
	    },
	    {
	        "date": "2012-01-02",
	        "distance": 371,
	        "townName": "Washington",
	        "townSize": 14,
	        "latitude": 38.89,
	        "duration": 482
	    },
	    {
	        "date": "2012-01-03",
	        "distance": 433,
	        "townName": "Wilmington",
	        "townSize": 6,
	        "latitude": 34.22,
	        "duration": 562
	    },
	    {
	        "date": "2012-01-04",
	        "distance": 345,
	        "townName": "Jacksonville",
	        "townSize": 7,
	        "latitude": 30.35,
	        "duration": 379
	    },
	    {
	        "date": "2012-01-05",
	        "distance": 480,
	        "townName": "Miami",
	        "townName2": "Miami",
	        "townSize": 10,
	        "latitude": 25.83,
	        "duration": 501
	    },
	    {
	        "date": "2012-01-06",
	        "distance": 386,
	        "townName": "Tallahassee",
	        "townSize": 7,
	        "latitude": 30.46,
	        "duration": 443
	    },
	    {
	        "date": "2012-01-07",
	        "distance": 348,
	        "townName": "New Orleans",
	        "townSize": 10,
	        "latitude": 29.94,
	        "duration": 405
	    },
	    {
	        "date": "2012-01-08",
	        "distance": 238,
	        "townName": "Houston",
	        "townName2": "Houston",
	        "townSize": 16,
	        "latitude": 29.76,
	        "duration": 309
	    },
	    {
	        "date": "2012-01-09",
	        "distance": 218,
	        "townName": "Dalas",
	        "townSize": 17,
	        "latitude": 32.8,
	        "duration": 287
	    },
	    {
	        "date": "2012-01-10",
	        "distance": 349,
	        "townName": "Oklahoma City",
	        "townSize": 11,
	        "latitude": 35.49,
	        "duration": 485
	    },
	    {
	        "date": "2012-01-11",
	        "distance": 603,
	        "townName": "Kansas City",
	        "townSize": 10,
	        "latitude": 39.1,
	        "duration": 890
	    },
	    {
	        "date": "2012-01-12",
	        "distance": 534,
	        "townName": "Denver",
	        "townName2": "Denver",
	        "townSize": 18,
	        "latitude": 39.74,
	        "duration": 810
	    },
	    {
	        "date": "2012-01-13",
	        "townName": "Salt Lake City",
	        "townSize": 12,
	        "distance": 425,
	        "duration": 670,
	        "latitude": 40.75,
	        "alpha":0.4
	    },
	    {
	        "date": "2012-01-14",
	        "latitude": 36.1,
	        "duration": 470,
	        "townName": "Las Vegas",
	        "townName2": "Las Vegas",
	        "bulletClass": "lastBullet"
	    },
	    {
	        "date": "2012-01-15"
	    },
	    {
	        "date": "2012-01-16"
	    },
	    {
	        "date": "2012-01-17"
	    },
	    {
	        "date": "2012-01-18"
	    },
	    {
	        "date": "2012-01-19"
	    }
	];
	var chart = AmCharts.makeChart("chartdiv", {
	  type: "serial",
	  theme: "dark",
	  dataDateFormat: "YYYY-MM-DD",
	  dataProvider: chartData,

	  addClassNames: true,
	  startDuration: 1,
	  color: "#FFFFFF",
	  marginLeft: 0,

	  categoryField: "date",
	  categoryAxis: {
	    parseDates: true,
	    minPeriod: "DD",
	    autoGridCount: false,
	    gridCount: 50,
	    gridAlpha: 0.1,
	    gridColor: "#FFFFFF",
	    axisColor: "#555555",
	    dateFormats: [{
	        period: 'DD',
	        format: 'DD'
	    }, {
	        period: 'WW',
	        format: 'MMM DD'
	    }, {
	        period: 'MM',
	        format: 'MMM'
	    }, {
	        period: 'YYYY',
	        format: 'YYYY'
	    }]
	  },

	  valueAxes: [{
	    id: "a1",
	    title: "distance",
	    gridAlpha: 0,
	    axisAlpha: 0
	  },{
	    id: "a2",
	    position: "right",
	    gridAlpha: 0,
	    axisAlpha: 0,
	    labelsEnabled: false
	  },{
	    id: "a3",
	    title: "duration",
	    position: "right",
	    gridAlpha: 0,
	    axisAlpha: 0,
	    inside: true,
	    duration: "mm",
	    durationUnits: {
	        DD: "d. ",
	        hh: "h ",
	        mm: "min",
	        ss: ""
	    }
	  }],
	  graphs: [{
	    id: "g1",
	    valueField:  "distance",
	    title:  "distance",
	    type:  "column",
	    fillAlphas:  0.9,
	    valueAxis:  "a1",
	    balloonText:  "[[value]] miles",
	    legendValueText:  "[[value]] mi",
	    legendPeriodValueText:  "total: [[value.sum]] mi",
	    lineColor:  "#263138",
	    alphaField:  "alpha",
	  },{
	    id: "g2",
	    valueField: "latitude",
	    classNameField: "bulletClass",
	    title: "latitude/city",
	    type: "line",
	    valueAxis: "a2",
	    lineColor: "#786c56",
	    lineThickness: 1,
	    legendValueText: "[[description]]/[[value]]",
	    descriptionField: "townName",
	    bullet: "round",
	    bulletSizeField: "townSize",
	    bulletBorderColor: "#786c56",
	    bulletBorderAlpha: 1,
	    bulletBorderThickness: 2,
	    bulletColor: "#000000",
	    labelText: "[[townName2]]",
	    labelPosition: "right",
	    balloonText: "latitude:[[value]]",
	    showBalloon: true,
	    animationPlayed: true,
	  },{
	    id: "g3",
	    title: "duration",
	    valueField: "duration",
	    type: "line",
	    valueAxis: "a3",
	    lineColor: "#ff5755",
	    balloonText: "[[value]]",
	    lineThickness: 1,
	    legendValueText: "[[value]]",
	    bullet: "square",
	    bulletBorderColor: "#ff5755",
	    bulletBorderThickness: 1,
	    bulletBorderAlpha: 1,
	    dashLengthField: "dashLength",
	    animationPlayed: true
	  }],

	  chartCursor: {
	    zoomable: false,
	    categoryBalloonDateFormat: "DD",
	    cursorAlpha: 0,
	    valueBalloonsEnabled: false
	  },
	  legend: {
	    bulletType: "round",
	    equalWidths: false,
	    valueWidth: 120,
	    useGraphSettings: true,
	    color: "#FFFFFF"
	  }
	});
	</script>
</body>
</html>