<%@page import="poly.dto.consumer.CONSUMER_FtMenuCateDTO"%>
<%@page import="java.util.List"%>
<%@page import="poly.dto.consumer.CONSUMER_Ft_InfoDTO"%>
<%@page import="poly.dto.consumer.CONSUMER_Menu_InfoDTO"%>
<%@page import="poly.dto.consumer.CONSUMER_ImageDTO"%>
<%@page import="poly.dto.consumer.CONSUMER_FtMenuCateDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("euc-kr");
	List<CONSUMER_Menu_InfoDTO> menuDTOs = (List<CONSUMER_Menu_InfoDTO>) request.getAttribute("menuDTOs"); // 메뉴 DTO 리스트
	List<CONSUMER_ImageDTO> imgDTOs = (List<CONSUMER_ImageDTO>) request.getAttribute("imgDTOs"); // 이미지 DTO 리스트
	List<CONSUMER_FtMenuCateDTO> cateDTOs = (List<CONSUMER_FtMenuCateDTO>) request.getAttribute("cateDTOs"); //카테고리 데이터 리스트
%>

<html>
<style>
	#goToOrder{
		width:100%;
		position: fixed;
		bottom: 0;
	}
	/* 행의 margin제거 */
	.ftMenuRow{
		margin:0; 
		padding:6px 0;
		text-align:center;
		
	}
	/* 메뉴의 이미지를 높이를 고정 */
	.imgRow > img{
		height:auto; margin:10px 0;
		min-height:180px; max-height:300px;
	}
</style>
<body>
	
	
	<div class="container-fluid">
	<%if(menuDTOs.isEmpty() == false) {%>
		<%for(int k = 0; k < cateDTOs.size(); k++) {%>
			<div class="row">
				<div class="col-sm-12">
				<div class="panel panel-default">
  					<div class="panel-body" style="text-align:center;">
						<!-- 메뉴카테고리 명 출력 -->
						<h3><%=cateDTOs.get(k).getCate_name() %></h3>
  					</div>
				</div>
				</div>
			</div>
			
			<%for (int i = 0; i < menuDTOs.size(); i++) { %>
				<%if(cateDTOs.get(k).getCate_sort_no() == menuDTOs.get(i).getCate_sort_no()) {%>
					<div class="col-sm-6">
						<div class="contentBox" style="text-align:center;">
							<!-- 메뉴 이미지 -->
							<div class="row ftMenuRow imgRow">
								<%for(int j = 0; j < imgDTOs.size(); j++) {%>
									<!--fileId NULL 확인 -->
									<%if(!"".equals(imgDTOs.get(j).getFileSevname())) {%>
										<!-- imgDTO와 menuDTOs 같은 fileId일 경우 출력-->
										<%if(imgDTOs.get(j).getFileId().equals(menuDTOs.get(i).getFile_id())) {%>
											<!-- 메뉴 사진 -->
											<img src="<%=request.getContextPath()%>/resources/files/<%=imgDTOs.get(j).getFileSevname()%>" 
												style="max-height:240px; max-width:240px; width:auto;">
										<%} %> 		
									<%} else {%>
										<img src="/resources/img/consumer/temp.png" alt="메뉴이미지준비중" style="max-height:300px; width:100%;"/>
									<%} %>
								<%} %>
							</div>
							<div class="row ftMenuRow">음식명:&nbsp;<%=menuDTOs.get(i).getMenu_name() %></div>
							<div class="row ftMenuRow">소개:&nbsp;<%=menuDTOs.get(i).getMenu_intro() %></div>
							<div class="row ftMenuRow">가격:&nbsp;<%=menuDTOs.get(i).getMenu_price() %></div>
						</div>
					</div>
					<%if(i%2 == 1 && i > 0) {%> <!-- 각각 높이가 같은 각 행에 2개씩 들어가도록 위치를 맞춰 줌 -->
						<div class="clearfix visible-sm"></div> 
					<%} %>
				<%} %>
			<%} %>
			<!-- 등록된 음식이 없을 경우 -->	
			<%} %>
		<%} else{%>
			<h2>등록된 메뉴가 없습니다.</h2>
		<%} %>	
	</div>
	<br/><br/> <!-- 메뉴가 버튼에 가리지 않도록 공백 설정 -->
	<div class="header" id="myHeader2">
		<button type="button" class="btn btn-primary" id="goToOrder">주문하러 가기</button>
	</div>

</body>
</html>