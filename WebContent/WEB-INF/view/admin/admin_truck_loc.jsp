<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="poly.dto.consumer.CONSUMER_Ft_InfoDTO" %>
<%@page import="poly.dto.consumer.CONSUMER_ImageDTO" %>
<%@page import="java.util.List"%>

<%
	
	List<CONSUMER_Ft_InfoDTO> ftList = (List<CONSUMER_Ft_InfoDTO>)request.getAttribute("ftList");
	List<CONSUMER_ImageDTO> imgDTOs = (List<CONSUMER_ImageDTO>)request.getAttribute("imgDTOs");
	String myLocLat = (String)request.getAttribute("locPositionLat");
	String myLocLon = (String)request.getAttribute("locPositionLon");
	
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
.map_wrap {position:relative;overflow:hidden;width:100%;height:350px;}
.radius_border{border:1px solid #919191;border-radius:5px;}     
.custom_typecontrol {position:absolute;top:10px;right:10px;overflow:hidden;width:130px;height:30px;margin:0;padding:0;z-index:1;font-size:12px;font-family:'Malgun Gothic', '맑은 고딕', sans-serif;}
.custom_typecontrol span {display:block;width:64px;height:30px;float:left;text-align:center;line-height:30px;cursor:pointer;}
.custom_typecontrol .nbtn {background:#fff;background:linear-gradient(#fff,  #e6e6e6);}       
.custom_typecontrol .nbtn:hover {background:#f5f5f5;background:linear-gradient(#f5f5f5,#e3e3e3);}
.custom_typecontrol .nbtn:active {background:#e6e6e6;background:linear-gradient(#e6e6e6, #fff);}    
.custom_typecontrol .selected_btn {color:#fff;background:#425470;background:linear-gradient(#425470, #5b6d8a);}
.custom_typecontrol .selected_btn:hover {color:#fff;}   
</style>
</head>
<body>
<!-- 다음 맵이 차지할 공간 -->
<div class="map_wrap">
	<div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>
	<div class="custom_typecontrol radius_border">
        <span id="btnRoadmap" class="selected_btn" onclick="setMapType('roadmap')">지도</span>
        <span id="btnSkyview" class="nbtn" onclick="setMapType('skyview')">스카이뷰</span>
    </div>
</div>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=60f4f121242d90c886eacd9609c92e78&libraries=services,clusterer,drawing"></script>
	<script>
	
		var mapContainer = document.getElementById('map') 
	    var mapOption = { 
	        center: new daum.maps.LatLng(<%=myLocLat%>, <%=myLocLon%>), 
	        level: 3 
	    };
	
		var map = new daum.maps.Map(mapContainer, mapOption); // 지도를 생성합니다	
	
		// 마커를 표시할 위치와 title 객체 배열입니다  
		// 위도경도 정보를 split하여 double형으로 형변환
		var positions = [
			<%for(int i =0; i< ftList.size(); i++) {%>
				<% double truckPositionLat = Double.parseDouble(ftList.get(i).getGps_x()); %>
				<% double truckPositionLon = Double.parseDouble(ftList.get(i).getGps_y()); %>
			{
				title: '<%=ftList.get(i).getFt_name() %>', 
		        latlng: new daum.maps.LatLng(<%=truckPositionLat%>, <%=truckPositionLon%>)
		    },
			<%} %>
			
		];
		
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = { 
	        center: new daum.maps.LatLng(<%=Double.parseDouble(myLocLat) %>,<%=Double.parseDouble(myLocLon)%>), // 지도의 중심좌표
	        level: 3 // 지도의 확대 레벨
	    };

		var map = new daum.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
		
		var imageSrc = 'http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_red.png', // 마커이미지의 주소입니다    
	    imageSize = new daum.maps.Size(64, 69), // 마커이미지의 크기입니다
	    imageOption = {offset: new daum.maps.Point(27, 69)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.
	      
		// 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
		var markerImage = new daum.maps.MarkerImage(imageSrc, imageSize, imageOption),
	    markerPosition = new daum.maps.LatLng(<%=Double.parseDouble(myLocLat) %>,<%=Double.parseDouble(myLocLon)%>); // 마커가 표시될 위치입니다
		
		// 마커를 표시할 위치입니다 
		var position =  new daum.maps.LatLng(<%=Double.parseDouble(myLocLat) %>,<%=Double.parseDouble(myLocLon)%>);
	
		// 마커를 생성합니다
		var marker = new daum.maps.Marker({
		  position: position,
		  clickable: true // 마커를 클릭했을 때 지도의 클릭 이벤트가 발생하지 않도록 설정합니다
		});
	
		// 아래 코드는 위의 마커를 생성하는 코드에서 clickable: true 와 같이
		// 마커를 클릭했을 때 지도의 클릭 이벤트가 발생하지 않도록 설정합니다
		// marker.setClickable(true);
	
		// 마커를 지도에 표시합니다.
		marker.setMap(map);
	
		// 마커를 클릭했을 때 마커 위에 표시할 인포윈도우를 생성합니다
		var iwContent = '<div style="padding:5px;">Hello World!</div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
		    iwRemoveable = true; // removeable 속성을 ture 로 설정하면 인포윈도우를 닫을 수 있는 x버튼이 표시됩니다
	
		// 인포윈도우를 생성합니다
		var infowindow = new daum.maps.InfoWindow({
		    content : iwContent,
		    removable : iwRemoveable
		});
	
		// 마커에 클릭이벤트를 등록합니다
		daum.maps.event.addListener(marker, 'click', function() {
		      // 마커 위에 인포윈도우를 표시합니다
		      infowindow.open(map, marker);  
		});
		
		
		// 지도타입 컨트롤의 지도 또는 스카이뷰 버튼을 클릭하면 호출되어 지도타입을 바꾸는 함수입니다
		function setMapType(maptype) { 
		    var roadmapControl = document.getElementById('btnRoadmap');
		    var skyviewControl = document.getElementById('btnSkyview'); 
		    if (maptype === 'roadmap') {
		        map.setMapTypeId(daum.maps.MapTypeId.ROADMAP);    
		        roadmapControl.className = 'selected_btn';
		        skyviewControl.className = 'nbtn';
		    } else {
		        map.setMapTypeId(daum.maps.MapTypeId.HYBRID);    
		        skyviewControl.className = 'selected_btn';
		        roadmapControl.className = 'nbtn';
		    }
		}
	</script>
</body>
</html>