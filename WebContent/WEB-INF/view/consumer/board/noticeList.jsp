<%@page import="java.util.List"%>
<%@page import="poly.dto.consumer.CONSUMER_BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	List<CONSUMER_BoardDTO> bList = (List<CONSUMER_BoardDTO>)request.getAttribute("bList");
	String []today = (String[]) request.getAttribute("today");
	
%>

<html>
<head>
<title>트럭왔냠 - 공지사항</title>
<%@ include file="/WEB-INF/view/consumer/topCssScript.jsp" %>
<style>
	
</style>
</head>
<body>
<%@include file="/WEB-INF/view/consumer/topBody.jsp" %>
				<div class="container-fluid" style="text-align:left;">
					<div class="row" style="border-bottom:1px solid #eeeeee; padding:8px 0;">
						<div class="col-xs-12" style="font-size:20px;">
							<h5>트럭왔냠 공지사항</h5>
						</div>
						<div class="clearfix visible-xs"></div>
					</div>
				<%for (int i = 0; i < bList.size(); i++) {%>
					<%String regDate[] = bList.get(i).getRegDate().split("/"); %>
					<%String []regDateSub = regDate[0].split("\\. "); %>
					<%boolean newListCheck = regDateSub[0].equals(today[0]) && regDateSub[1].equals(today[1]) && regDateSub[2].equals(today[2]);%>
					<div class="row" style=" padding:8px 0;">
						<span style="font-size:15px; color:red; padding:0px; position:absolute; margin-top:5px; ">
							<%if(newListCheck) {%>
								ㆍ
							<%}%>	
						</span>
						<div class="col-xs-12" style="font-size:20px;">
							<a href="/consumer/board/boardDetail.do?boardPSeq=<%=bList.get(i).getBoardPSeq()%>&boardSeq=1">
								<%=bList.get(i).getTitle() %>
							</a>
						</div>
						<div class="clearfix visible-xs"></div>
					</div>
					<div class="row" style="border-bottom:1px solid #eeeeee; padding:8px 0;">
						<div class="col-xs-3" style="color:#9f9f9f;">관리자</div>
							<!-- 현재날짜와 같을 경우 mm:ss 만 표시 -->
						<div class="col-xs-6" style="color:#9f9f9f;">
							<%if(newListCheck) {%>
								<%=regDate[1].substring(0,6) %>
							<%}else { %>
								<%=regDate[0]%>
							<%} %>
						</div>
						<div class="clearfix visible-xs"></div>
					</div>
				<%}%>
					<div class="row" style="text-align:center;">
						<button type="button" onclick="loadList()" class="btn btn-light" style="width:100%;">더 보기</button>
					</div>
				</div>
				
</body>
<script>
	var count = 2;
	
	function loadList(){
		var request = $.ajax({
			url : "/consumer/board/getListMore.do",
			method : "POST",
			data :{ boardSeq : 1,
					count : count},
		})
		
		request.done(function(data){
			var contents = '';
			$.each(data, function(key,value){
				console.log(key, value);
				
			})
			count++;
		});
		request.fail(function  (jqXHR, textStatus ) {
			  alert( "Request failed: " + textStatus );
		});
	}
</script>
</html>

	