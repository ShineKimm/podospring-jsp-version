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
            <li class="" onclick="location.href='/guide/reserGuide'">예약안내</li>
            <li class="" onclick="location.href='/guide/fee'">이용요금</li>
            <li class="" onclick="location.href='/guide/break'">위약안내</li>
            <li class="" onclick="location.href='/guide/etiquette'">에티켓</li>
            <li class="on" onclick="location.href='/guide/inquiry'">예약/기타문의</li>

            <li class="homeBox"><img src="/images/home.jpg" alt="">&nbsp; 이용안내 &nbsp;<img src="/images/mini_arw.jpg" alt="">&nbsp; 예약/기타문의</li>
        </ul>
    </div>
    <div class="contents">
        <img src="/images/inqImg.jpg" alt="">

        <p class="guideMiniTitle"> 카카오톡 상담 이용안내</p>
        <table class="inqTable" style="margin-top:10px;">
            <colgroup>
                <col width="20%">
                <col width="80%">
            </colgroup>
            <tbody>
            <tr>
                <td class="none">
                    <img src="/images/inqIcon.png" alt="" class="icon">
                    친구추가
                </td>
                <td class="left">
                    <ul class="infoBox">
                        <li class="txt">
                            1) 클릭! 한번으로 바로 친구추가 하기  <br>
                            2) APP(앱) & PC 카카오톡 친구추가 방법
                        </li>
                        <li class="link sq" onclick="alert('준비중입니다.')">
                            <img src="/images/kakao.jpg" alt="">&nbsp; 친구추가
                        </li>
                    </ul>
                </td>
            </tr>
            <tr>
                <td class="none">
                    <img src="/images/inqIcon2.png" alt="" class="icon">
                    상담내용 작성
                </td>
                <td class="left">
                    <ul class="infoBox">
                        <li class="txt">
                            <span class="bold">상담원이 답변내용을 카카오톡 메시지로 발송합니다.</span> <br>
                            문의사항에 대하여는 즉시 답변을 원칙으로 하고 있으나,<br>
                            즉시 처리가 어려운 경우 지연사유를 말씀드린 후 담당문의처를 연결해드립니다.<br>
                            지금 바로 문의를 원하시면 톡상담을 클릭해주세요!
                        </li>
                        <li class="link sq margin" onclick="alert('준비중입니다.')">
                            <img src="/images/kakao.jpg" alt="">&nbsp; 톡상담
                        </li>
                    </ul>
                </td>
            </tr>
            </tbody>
        </table>

    </div><!-- contents End-->

</div>	<!-- wrap End -->
<%@ include file="../include/footer.jsp" %>