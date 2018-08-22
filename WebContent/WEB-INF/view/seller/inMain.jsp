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
	<table style="height: 100%; width: 100%">
		<tr height="7%" bgcolor="#333333">
			<td>
				<%@ include file="/WEB-INF/view/seller/topBody.jsp" %>
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
			</td>
			<!--github  test-->
		</tr>
		<tr bgcolor="">
			<td>
			<div class="container">
			
			<%@ include file="/WEB-INF/view/seller/inMainBody.jsp" %>
			
			
			</div>

			</td>
		</tr>
		<tr height="7%" bgcolor="#333333">
			<td>
				<%@ include file="/WEB-INF/view/seller/bottom.jsp" %>
			
			</td>
		</tr>
	</table>
	

</body>
</html>