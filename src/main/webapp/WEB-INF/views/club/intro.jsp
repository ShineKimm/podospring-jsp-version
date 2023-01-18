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
            <li class="on" onclick="location.href='/club/intro'">클럽소개</li>
            <li class="" onclick="location.href='/club/greeting'">인사말</li>
            <li class="" onclick="location.href='/club/location'">오시는길</li>
            <li class="homeBox"><img src="/images/home.jpg" alt="">&nbsp; 시설안내 &nbsp;<img src="/images/mini_arw.jpg" alt="">&nbsp; 클럽소개</li>
        </ul>
    </div>
    <div class="clubContents">
        <div class="leftIntroImg"></div>
        <div class="rightIntroBox">
            <ul class="rightIntroTxt tracking-in-expand">
                <li class="title">자연과 하나되어 즐기는 힐링시간</li>
                <li class="title2">포도C.C</li>
                <li class="txt">그 누구도 상상하지 못했던 아주 특별한 컨셉의 컨트리클럽이 지금 귀하의 <br>
                    도전과 사랑을 기다리고 있습니다.</li>

                <li class="miniTitle">클럽개요 <span class="bar"></span></li>
                <li class="infoTxt">- 코스규모: 18 Hole / 72 Par <br>
                    - 총면적: 6900 yds<br>
                    - 골프코스 면적: IN Cours par 36 (3,700 yds) / OUT Cours Par 36 (3,200 yds)</li>
                <li class="dotLine padding15"></li>
                <li class="padding15"></li>

                <!--<li class="miniTitle">잔디종류</li>
                <li class="">- Teeing Ground :  <br>
                - F/W :  <br>
                - Green : </li>
                <li class="dotLine padding15"></li>
                <li class="padding15"></li>-->

                <li class="miniTitle">코스특징</li>
                <li class="">자연과 예술적인 감동은 늘 귀하에게 시간의 설레임으로 다가가고, 고품격 맞춤  <br>
                    서비스를 제공할 것입니다. <br>
                    퍼블릭 18홀 코스는 매홀마다 새로운 기대와 아름다움을 선사할것이며, 창의적인  <br>
                    코스 디자인으로 귀하에게 격조있는 흥분과 기쁨을 매순간 간직하게 할 것입니다. </li>
                <li class="dotLine padding15"></li>
                <li class="padding15"></li>

                <li class="miniTitle">클럽위치</li>
                <li class="infoBox">경상북도 김천시 구성면 남김천대로 2532 <br>
                    (구 주소 : 경상북도 김천시 구성면 송죽리 661-2번지 ) </li>
            </ul>
        </div>
    </div><!-- clubContents End-->

    <div class="contents">
        <div class="padding30"></div>
        <div class="ciTitle fromTopIn" data-scroll="toggle(.fromTopIn, .fromTopOut)">CI 소개</div>
        <img src="/images/ciImg.png" alt="" class="ciImg fromTopIn" data-scroll="toggle(.fromTopIn, .fromTopOut)">
    </div>

</div>	<!-- wrap End -->
<%@ include file="../include/footer.jsp" %>
