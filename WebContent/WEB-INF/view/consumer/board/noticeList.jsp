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
</head>
<body>
<%@include file="/WEB-INF/view/consumer/topBody.jsp" %>
				<div class="container-fluid">
					<div class="row" style="border-bottom:1px solid #eeeeee; padding:8px 0;">
						<div class="col-xs-12" style="font-size:20px;">
							<h5>트럭왔냠 공지사항</h5>
						</div>
						<div class="clearfix visible-xs"></div>
					</div>
				<%for (int i = 0; i < bList.size(); i++) {%>
					<div class="row" style="border-bottom:1px solid #eeeeee; padding:8px 0;">
						<div class="col-xs-12" style="font-size:20px;">
							<a href="/consumer/board/boardDetail.do?boardPSeq=<%=bList.get(i).getBoardPSeq()%>&boardSeq=1">
								<%=bList.get(i).getTitle() %>
							</a>
						</div>
						<div class="col-xs-3" style="color:#9f9f9f;">관리자</div>
							<!-- 현재날짜와 같을 경우 mm:ss 만 표시 -->
						<div class="col-xs-6" style="color:#9f9f9f;">
							<%String regDate[] = bList.get(i).getRegDate().split("/"); %>
							<%String []regDateSub = regDate[0].split("\\. "); %>
							<%if(regDateSub[0].equals(today[0]) && regDateSub[1].equals(today[1]) && regDateSub[2].equals(today[2])) {%>
								<%=regDate[1].substring(0,6) %>
							<%}else { %>
								<%=regDate[0]%>
							<%} %>
						</div>
						<div class="clearfix visible-xs"></div>
					</div>
				<%}%>
				</div>
				
</body>
</html>

	