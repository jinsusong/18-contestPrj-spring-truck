<%@page import="poly.dto.seller.SELLER_OrderInfoDTO"%>
<%@page import="java.util.List"%>
<%@ page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%

	
    	String todayMD = (String)request.getAttribute("todayMD");
		String todayYMDhms = (String)request.getAttribute("todayYMDhms");
		String todayDD = (String)request.getAttribute("todayDD");
		List<SELLER_OrderInfoDTO> oList = (List<SELLER_OrderInfoDTO>)request.getAttribute("oList");
    	out.println(todayMD);
    	out.println(todayYMDhms);
    	out.println(todayDD);
    	//DateUtil.getDate();
    	//String todayDate = (String)DateUtil.getDate();
	   	int todayY = Integer.parseInt(todayYMDhms.substring(0, 4));
	   	out.println(todayY);
	   	int todayM = Integer.parseInt(todayYMDhms.substring(5, 7));
	   	out.println(todayM);
	   	int todayD = Integer.parseInt(todayYMDhms.substring(8, 10));
	   	out.println(todayD);
    %>

	
	<!-- 일간 매출액 시작 -->
	<%
		int sumpriceD = 0;
	   	for(int i=0; i<oList.size(); i++) {
		   	
			   	String str = oList.get(i).getOrd_date();
			   	int sumprice = oList.get(i).getOrd_sumprice();
			   	int orderY = Integer.parseInt(str.substring(0, 4));
			   	int orderM = Integer.parseInt(str.substring(5, 7));
			   	int orderD = Integer.parseInt(str.substring(8, 10));
			   	
			   	if(todayY == orderY && todayM == orderM && (todayD - orderD)<=7) {
			   		System.out.println("------------------------");
			   		System.out.println("substring 년도: " + orderY);
				   	System.out.println("substring 월: " + orderM);
				   	System.out.println("substring 일: " + orderD);
			   		System.out.println("일 수 차이: " + (todayD - orderD));
			   		System.out.println("------------------------");
			   		sumpriceD += sumprice;
			   		
			   	}
			
		
		}
	%>
	
	<%
		System.out.println("이번주 매출액: " + sumpriceD);
	%>
	<!-- 일간 매출액 끝 -->
    
    
    
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>chart</title>
<%-- <%@ include file="/WEB-INF/view/consumer/topCssScript.jsp" %> --%>

<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script>

</head>
<body>
	<%-- <div>
		<%@include file="/WEB-INF/view/consumer/topBody.jsp" %>	<!-- topBody에서 session으로 userEmail을 받는다. -->
	</div> --%>
	<div style="margin-bottom:20px">
	
		<div role="tabpanel" style="margin: 20px">

		 	 <!-- Nav tabs -->
			<ul class="nav nav-tabs" role="tablist">
				<li role="presentation" class="active"><a href="#Week" aria-controls="profile" role="tab" data-toggle="tab">이번주 매출</a></li>
				<li role="presentation"><a href="#Month" aria-controls="messages" role="tab" data-toggle="tab">이번달 매출</a></li>
			</ul>
		
			<!-- Tab panes -->
			<div class="tab-content">
				<div role="tabpanel" class="tab-pane fade in active" id="Week">
					<canvas id="myChartWeek" style="width: 100%;"></canvas>
				</div>
				<div role="tabpanel" class="tab-pane fade" id="Month">
					<canvas id="myChartMonth" style="width: 100%;"></canvas>
				</div>
			</div>
		</div>
		<div style="margin-top:35px;">
			<div style="float:left; width:48%;">	<!-- float은 구석으로 차곡차곡 밀어 넣는 속성이기 때문에 두 div를 같은 위치에 밀어 넣고 싶은 땐  style="clear:both"를 해주어야 함 -->
				<div style="padding-bottom:5px; border-bottom:1px solid #cccccc; margin-bottom:15px;">
					<span style="border:1px solid #cccccc; padding-left:20px; padding-right:20px; padding-top:8px; padding-bottom:8px;">today - <%=todayMD %></span>
				</div>
			</div>
			<div style="float:right; width:48%;">
				<div style="padding-bottom:5px; border-bottom:1px solid #cccccc; margin-bottom:15px;">
					<span style="border:1px solid #cccccc; padding-left:20px; padding-right:20px; padding-top:8px; padding-bottom:8px;">오늘 총매출</span> <span style="float:right;">7,500,000원</span>
				</div>
				<div style="padding-bottom:5px; border-bottom:1px solid #cccccc; margin-bottom:15px;">
					<span style="border:1px solid #cccccc; padding-left:20px; padding-right:20px; padding-top:8px; padding-bottom:8px;">이번주 총매출</span> <span style="float:right;">28,500,000원</span>
				</div>
				<div style="padding-bottom:5px; border-bottom:1px solid #cccccc; margin-bottom:15px;">
					<span style="border:1px solid #cccccc; padding-left:20px; padding-right:20px; padding-top:8px; padding-bottom:8px;">이번달 총매출</span> <span style="float:right;">120,000,000원</span>
				</div>
			</div>
			<div style="clear:both; border-bottom:1px solid #cccccc;"></div>
		</div>
		
		
		
	</div>
	


<script>
	//Ajax 댓글
	<%-- function ajaxTest(){
		
			var content = $('#contentAjax').val();
			var boardPSeq = $('#boardPSeqAjax').val();
			var userSeq	 = $('#userSeqAjax').val();
			var repleSeq = $('#repleSeqAjax').val();
			var ssUserSeq = <%=userSeq%>;
			
		if(userSeq) {
			
			$.ajax({
				type:'post',
				url: "/board/reple.do",
				data: {
					'content':content,
					'boardPSeq':boardPSeq,
					'userSeq':userSeq
				},
				success: function(data) {
					console.log(data);
					var contents ='';
	                
	                $.each(data,function (key,value){
	                	
	                    contents += "<div><h6><strong>userSeq : " + value.userSeq + "&nbsp;&nbsp;Date : " + value.regDate +"</strong></h6>";
	                    contents += "<span>" + value.content + "</span>";
	                    
	                    /* if(ssUserSeq.equals(value.userSeq)){
	                    contents += "<div class='btn-group' role='group' aria-label='...' style='float:right'>";
	                    contents += "<button type='button' class='btn btn-default'>수정</button><button type='button' class='btn btn-default'>삭제</button></div>";
	                    } */
	                    
	                    contents += "<div class='btn-group' role='group' aria-label='...' style='float:right'>";
	                    contents += "<button type='button' class='btn btn-default'>수정</button><button type='button' class='btn btn-default'>삭제</button></div>";
	                    
	                    contents += "</div><input type='hidden' id='repleSeqAjax' value='" + value.repleSeq + "'/>";
	        			contents += "<hr style='margin:20px '/>";
	                 });
	                    
					$('#ListAjax').html(contents);
				},  
				error : function(error) {
		            alert("error : " + error);
				}
				
			})
			
		} else {
			alert("로그인 후 이용해 주시기 바랍니다.");
			location.href="/user/userLogin.do";
		}
		
	} --%>

</script>

<script>//이번주 매출
var ctx = document.getElementById("myChartWeek").getContext('2d');
var myChartWeek = new Chart(ctx, {
    type: 'bar',
    data: {
    	
	    labels: [<%-- "<%=todayM %>월 <%=todayD%>일", --%>"8월 첫째주",  "8월 둘째주", "8월 셋째주", "8월 넷째주", "8월 다섯째주", "9월 첫째주", "9월 둘째주"],		
	    
	    datasets: [{
	            label: '최근 일주일간 매출',
	            data: [28700000, 26600000, 26540000, 30140000, 28890000, 24500000, 41200000],	//데이터 들어가는 곳
	            backgroundColor: 
	                'rgba(75, 192, 192, 0.2)',
	            borderColor: 
	                'rgba(75, 192, 192, 1)',
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

<script>//이번달 매출
var ctx = document.getElementById("myChartMonth").getContext('2d');
var myChartMonth = new Chart(ctx, {
    type: 'bar',
    data: {
        labels: ["4월", "5월", "6월", "7월", "8월", "9월", "10월"],		//월간
        datasets: [{
            label: '최근 한달간 매출',
            data: [287000000, 266000000, 265400000, 301400000, 288900000, 245000000, 412000000],	//데이터 들어가는 곳
            backgroundColor: 
                'rgba(255, 99, 132, 0.2)',
            borderColor: 
                'rgba(255,99,132,1)',
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