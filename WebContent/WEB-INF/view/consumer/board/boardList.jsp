<%@page import="poly.dto.consumer.CONSUMER_UserDTO"%>
<%@page import="java.util.List"%>
<%@page import="poly.dto.consumer.CONSUMER_BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@page import="java.util.Arrays"%>
<%@page import="java.util.regex.Pattern"%>
	<%
	
	List<CONSUMER_BoardDTO> bList = (List<CONSUMER_BoardDTO>)request.getAttribute("bList");
	%>
<html>
<head>
<title>Write!</title>
<%@ include file="/WEB-INF/view/consumer/topCssScript.jsp" %>
<script src="//cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"></script>
<script>
$(document).ready( function () {	//진수형이 알려주신 게시판
    $('#boardList').DataTable();
} );

</script>

<style>
.ellipsis {
    white-space: nowrap; 
    overflow: hidden;
    text-overflow:ellipsis;
}
</style>
</head>
<body>
	<div>
		<%@include file="/WEB-INF/view/consumer/topBody.jsp" %>	<!-- topBody에서 session으로 userEmail을 받는다. -->
	</div>
	<div class="container" style="margin-bottom:20px">
		<div style="border:1px solid black; margin: 20px">
			<table class="table table-striped" id="boardList">
				<thead>
					<tr>
						<th style="text-align:center;">번호</th> 
						<th style="text-align:center;">제목</th>
						<th style="text-align:center;">작성일</th>
						<th style="text-align:center;">작성자</th>
					</tr>
				</thead>
				<tbody>
					<%for (int i = 0; i < bList.size(); i++) {%>
					<tr>
						<td style="text-align:center;"><%=bList.get(i).getBoardPSeq() %></td>
						<td class="ellipsis" style="text-align:center;"><a href="/board/boardDetail.do?boardPSeq=<%=bList.get(i).getBoardPSeq()%>"><%=bList.get(i).getTitle() %></a></td>			
						<td style="text-align:center;"><%=bList.get(i).getRegDate() %></td>
						<td style="text-align:center;"><%=bList.get(i).getUserEmail() %></td>
					</tr>
					<%}%>
				</tbody>
			</table>
		</div>
		<div style="margin:20px; align:right">
			<form action="/board/boardWrite.do">
				<input type="hidden" name="userSeq" value="<%=userSeq %>" />
				<input type="hidden" name="userNick" value="<%=userNick %>" /> 
				<input type="hidden" name="userEmail" value="<%=userEmail %>" />
				<div style="height:40px"></div>
				<div style="text-align:center"><button type="submit" class="btn btn-default">글쓰기</button></div>
			</form>
		</div>
	</div>
</body>
</html>

	