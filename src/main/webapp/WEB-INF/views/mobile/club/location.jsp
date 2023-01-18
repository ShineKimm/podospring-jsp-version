<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<div class="menuTabBox">
	<ul class="menuList">
		<li class="" ><a href="/mobile/club/intro">클럽소개</a></li>
		<li class="" ><a href="/mobile/club/greeting">인사말</a></li>
		<li class="on" ><a href="/mobile/club/location">오시는길</a></li>
	</ul>
</div>

<div class="contents">
	<ul class="commonTitle">
		<li class="title">오시는길</li>
		<li class="midBar"></li>
	</ul>

	<div class="boardTxt">포도C.C로 찾아 오시는 길을 알려드립니다. </div>


	<!-- * 카카오맵 - 지도퍼가기 -->
				<!-- 1. 지도 노드 -->
				<div id="daumRoughmapContainer1616567894248" class="root_daum_roughmap root_daum_roughmap_landing"></div>

				<!--
					2. 설치 스크립트
					* 지도 퍼가기 서비스를 2개 이상 넣을 경우, 설치 스크립트는 하나만 삽입합니다.
				-->
				<script charset="UTF-8" class="daum_roughmap_loader_script" src="https://ssl.daumcdn.net/dmaps/map_js_init/roughmapLoader.js"></script>

				<!-- 3. 실행 스크립트 -->
				<script charset="UTF-8">
					new daum.roughmap.Lander({
						"timestamp" : "1616567894248",
						"key" : "25zgx",
						"mapHeight" : "360"
					}).render();
				</script>

   <br>
	<div class="clubTxt">
		경상북도 김천시 구성면 남김천대로 2532 <br>
		(구 주소 : 경상북도 김천시 구성면 송죽리 661-2번지 ) 
		<br>
        <br>
		<div class="commonDot bold"> 문의전화: 054-420-0200</div>
		<div class="commonDot bold">  FAX: 054-420-0239</div>
		
</div>
<%@ include file="../include/footer.jsp" %>
