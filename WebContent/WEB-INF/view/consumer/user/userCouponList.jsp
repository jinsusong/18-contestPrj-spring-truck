<%@page import="poly.dto.consumer.CONSUMER_CouponIssueDTO"%>
<%@page import="poly.dto.consumer.CONSUMER_UserDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	CONSUMER_UserDTO uDTO = (CONSUMER_UserDTO)request.getAttribute("uDTO");
	List<CONSUMER_CouponIssueDTO> cList = (List<CONSUMER_CouponIssueDTO>)request.getAttribute("cList");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>트럭왔냠 - 내 쿠폰목록</title>
	<style>
		.mypageMenu > div {
			padding: 0px;
		}
	</style>
</head>
<body>
<%@ include file="/WEB-INF/view/consumer/topBody.jsp" %>
	<div class="container" style="width:90%; padding:15px 0; margin-bottom:10px; border-bottom:1px solid #bebebe;">
		<div class="row mypageMenu" style="text-align:center; font-size:14px;">
			<div class="col-xs-3">
				<a class="nav-link active" href="/consumer/user/mypage.do">회원 정보</a>
			</div>
			<div class="col-xs-3">
				<a class="nav-link active" href="/consumer/user/userOrderInfo.do">주문 내역</a>
			</div>
			<div class="col-xs-3">
				<a class="nav-link active" href="/consumer/user/userFavortieFt.do">관심 매장</a>
			</div>
			<div class="col-xs-3">
				<a class="nav-link" href="/consumer/user/userCouponList.do">내 쿠폰목록</a>
			</div>
		</div>
	</div>

</body>
</html>