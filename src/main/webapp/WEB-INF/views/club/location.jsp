<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<div class="middleBg3 zoomImg">
</div>
<ul class="mainMenuTitle text-focus-in">
    <li class="big">Podo country club</li>
    <li>클럽소개</li>
</ul>

<!-- 컨텐츠 시작 -->
<div id="wrap">
    <div class="navbarWrap">
        <ul class="navbarBox">
            <li class="" onclick="location.href='/club/intro'">클럽소개</li>
            <li class="" onclick="location.href='/club/greeting'">인사말</li>
            <li class="on" onclick="location.href='/club/location'">오시는길</li>
            <li class="homeBox"><img src="/images/home.jpg" alt="">&nbsp; 시설안내 &nbsp;<img src="/images/mini_arw.jpg" alt="">&nbsp; 오시는길</li>
        </ul>
    </div>
    <div class="contents">
        <div class="locaTitle focus-in-expand">도심과 가까운 명문 골프장, <span class="tt">포도C.C</span></div>

        <ul class="locaTxt focus-in-expand" >
            <li class="img"><img src="/images/locaIcon.png" alt=""></li>
            <li>경상북도 김천시 구성면 남김천대로 2532 <br>
                (구 주소 : 경상북도 김천시 구성면 송죽리 661-2번지 ) <span class="bold">문의전화: 054-420-0200 &nbsp;&nbsp;&nbsp;&nbsp; FAX: 054-420-0239</span></li>
        </ul>

        <div class="mapTitle sq">카카오맵으로 보기</div>
        <!-- * 카카오맵 - 지도퍼가기 -->
        <!-- 1. 지도 노드 -->
        <div id="daumRoughmapContainer1617011376860" class="root_daum_roughmap root_daum_roughmap_landing"></div>

        <!--
            2. 설치 스크립트
            * 지도 퍼가기 서비스를 2개 이상 넣을 경우, 설치 스크립트는 하나만 삽입합니다.
        -->
        <script charset="UTF-8" class="daum_roughmap_loader_script" src="https://ssl.daumcdn.net/dmaps/map_js_init/roughmapLoader.js"></script>

        <!-- 3. 실행 스크립트 -->
        <script charset="UTF-8">
          new daum.roughmap.Lander({
            "timestamp" : "1617011376860",
            "key" : "254zz",
            "mapHeight" : "600"
          }).render();
        </script>
    </div><!-- contents End-->

</div>	<!-- wrap End -->
<%@ include file="../include/footer.jsp" %>
