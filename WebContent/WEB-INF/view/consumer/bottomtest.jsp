<%@page import="poly.util.CmmUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width">
<style>

/* Sticky footer styles
-------------------------------------------------- */

html {
  position: relative;
  min-height: 100%;
}
body {
  margin-bottom: 60px; /* Margin bottom by footer height */
}
.footer {
  position: absolute;
  bottom: 0;
  width: 100%;
  height: 60px; /* Set the fixed height of the footer here */
  line-height: 60px; /* Vertically center the text there */
  /* background-color: #f5f5f5; */
  border-top: 1px solid #e6e6e6;
}


/* Custom page CSS
-------------------------------------------------- */
/* Not required for template or sticky footer method. */


footer>div.container {
  width: auto;
  max-width: 680px;
  padding: 0 15px;
}
</style>    
<footer class="footer">
	<div class="container" style="text-align: center">
		<span class="text-muted"> <a href="/maintest.do?">홈</a> | 
			<a href="/user/userReg.do">회원가입</a> | 
			<a href="#">이용약관</a> | 
			<a href="/chart.do?ftSeq=<%=ftSeq%>&userSeq=<%=userSeq%>">매출관리</a>
		</span>
	</div>
</footer>
	
