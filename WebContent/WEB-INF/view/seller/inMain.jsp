<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
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


</head>
<body>
	<div>
		<%@ include file="/WEB-INF/view/seller/topBody.jsp" %>
	</div>		
	
	<!-- 트럭관리  -->
	
<script>
	function truckConfig(){
		console.log(<%=userSeq%>);
		var userSeq = <%=userSeq%>;
		if(userSeq != ""){
			location.href="/seller/ft/truckConfig.do?userSeq="+userSeq;
		}
	}
</script>

	<div class="container" style="margin-bottom:20px">

		<!--github  test-->
		<div>
			<%@ include file="/WEB-INF/view/seller/inMainBody.jsp" %>
		</div>
	
	
	</div>
	
	<div>
		<%@ include file="/WEB-INF/view/seller/bottom.jsp" %>
	</div>

</body>
</html>