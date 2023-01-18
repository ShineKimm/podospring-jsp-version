<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>

<div class="middleBg2 zoomImg">
</div>
<ul class="mainMenuTitle text-focus-in">
    <li class="big">Podo cc Guide</li>
    <li>이용안내</li>
</ul>
<!-- 컨텐츠 시작 -->
<div id="wrap">
    <div class="navbarWrap">
        <ul class="navbarBox">
            <li class="on" onclick="location.href='/guide/reserGuide'">예약안내</li>
            <li class="" onclick="location.href='/guide/fee'">이용요금</li>
            <li class="" onclick="location.href='/guide/break'">위약안내</li>
            <li class="" onclick="location.href='/guide/etiquette'">에티켓</li>
            <li class="" onclick="location.href='/guide/inquiry'">예약/기타문의</li>

            <li class="homeBox"><img src="/images/home.jpg" alt="">&nbsp; 이용안내 &nbsp;<img src="/images/mini_arw.jpg" alt="">&nbsp; 예약안내</li>
        </ul>
    </div>
    <div class="contents">
        <div class="borderBox">
            <div class="guideTxt">
                <span class="bold title">자연을 느끼며 재충전 할 수 있는 공간, 포도 C.C</span>
                포도 컨트리클럽의 특별한 품격과 감동의 세계로 귀하를 초대합니다.
                <div class="padding20"></div>
                <span class="bold title2">예약안내</span>
                <span class="commonDot"></span> 원하시는 예약일자를 클릭하시면 다음 예약화면으로 이동합니다.

                <div class="dotLine padding10"></div>

                <div class="padding20"></div>
                <span class="bold title2">인터넷예약</span>
                <span class="commonDot"></span> 당 클럽에서는 예약 방법의 불편함을 해소하고, 올바른 예약 문화의 정착을 위해 인터넷 예약을 시행하고 있습니다. <br>
                <span class="commonDot"></span> 인터넷 회원으로 가입하신 고객에 한하여 예약이 가능합니다.<br>
                <span class="commonDot"></span> 예약은 인터넷 홈페이지, 모바일을 통하여 24시간 예약 운영됩니다. <br>
                <span class="commonDot"></span> 3팀 이상 예약은 전화예약 가능합니다.<br>
                <span class="commonDot purple bold dotum"> 예약실 운영 시간 : 09 : 00 ~ 18 : 00</span> <br>
                <span class="commonDot purple bold dotum"> 예약 문의 : 054-420-0200</span><br>

                <div class="dotLine padding10"></div>

                <div class="padding20"></div>
                <span class="bold title2">일반예약</span>
                <table class="guideTable" style="margin-top:10px;">
                    <colgroup>
                        <col width="33.3333%">
                        <col width="33.3333%">
                        <col width="33.3333%">
                    </colgroup>
                    <tbody>
                    <tr>
                        <th>구분</th>
                        <th>오픈시간</th>
                        <th>취소가능일</th>
                    </tr>
                    <tr>
                        <td>평일/주말/공휴일</td>
                        <td>
                            매주 화요일 9시 오픈<br> 오픈일로부터 2주 후의 일주일 단위<br>(화~월요일)로 예약이 오픈됩니다.
                        </td>
                        <td>예약일 제외 5일전 17:00까지</td>
                    </tr>
                    </tbody>
                </table>

                <div class="btnBox">
                    <a href="/reservation/reservation" class="motion">예약하기</a>
                    <a href="/index" class="whiteBtn">취소하기</a>
                </div>
                <div class="margin50"></div>
            </div>
        </div>
    </div><!-- contents End-->

</div>	<!-- wrap End -->
<%@ include file="../include/footer.jsp" %>