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
            <li class="on" onclick="location.href='/guide/break'">위약안내</li>
            <li class="" onclick="location.href='/guide/etiquette'">에티켓</li>
            <li class="" onclick="location.href='/guide/inquiry'">예약/기타문의</li>

            <li class="homeBox"><img src="/images/home.jpg" alt="">&nbsp; 이용안내 &nbsp;<img src="/images/mini_arw.jpg" alt="">&nbsp; 위약안내</li>
        </ul>
    </div>
    <div class="contents">
        <div class="borderBox">
            <div class="guideTxt">
                <span class="bold title" style="font-size:17px;">무분별한 예약 및 취소, 무단 위약 등으로 인한 골프장의 막대한 손실을 방지하고, 올바른 예약 시스템과 최상의 서비스를 제공하겠습니다. </span>
                <div class="padding20"></div>


                <span class="bold title2">임박취소</span>
                예약자가 라운드일로부터 5일전 17:00까지 예약을 취소한 경우에는 페널티 없이 정상취소가 가능합니다. 라운드일 5일 전 17:00 이후에 예약을 <br>
                취소하거나 예약 당일 통지없이 골프장을 이용하지 않을 경우에는 당 클럽이 정한 아래의 위약 처리 규정에 따라 처리됩니다. 위약 처리 규정은 <br>
                예약정지를 원칙으로 하되 위약자가 위약해지를 원할 경우 구제금을 납부하고 위약을 해지할 수 있습니다.
                <div class="padding10"></div>
                <table class="guideTable" style="margin-bottom:10px;">
                    <colgroup>
                        <col width="19%">
                        <col width="29%">
                        <col width="30%">
                    </colgroup>
                    <tbody>
                    <tr>
                        <th scope="col">구분</th>
                        <th scope="col">페널티 기간</th>
                        <th scope="col">구제금(위약해제금액)</th>
                    </tr>
                    <tr>
                        <td>라운드 5일  전 17:00 이후부터<br>3일전 17:00 이전  예약취소</td>
                        <td>1개월 예약정지</td>
                        <td>팀당 10만원</td>
                    </tr>
                    <tr>
                        <td>라운드 3일 전 17:00 이후부터<br>2일 전 17:00 이전 예약취소</td>
                        <td>2개월 예약정지</td>
                        <td>팀당 15만원</td>
                    </tr>
                    <tr>
                        <td rowspan="2">라운드 2일 전 17:00 이후부터<br>1일 전 17:00 이전 예약취소</td>
                        <td rowspan="2">3개월 예약정지</td>
                        <td>팀당 20만원(평일)</td>
                    </tr>
                    <tr>
                        <td>팀당 30만원(주말 및 공휴일)</td>
                    </tr>
                    <tr>
                        <td rowspan="2">라운드 1일 전 17:00 이후 취소,<br>당일 미내장(No-show)</td>
                        <td rowspan="2">위약금 납부시까지<br>영구 예약 및 내장 정지</td>
                        <td>팀당 30만원(평일)</td>
                    </tr>
                    <tr>
                        <td style="border-bottom:1px solid #c3c3c3;">팀당 50만원 (주말 및 공휴일)</td>
                    </tr>
                    </tbody>
                </table>

                ※ 예외규정 (예약자가 다음 사항에 해당 시 증빙을 당클럽에 제출한 후 위약을 해지할 수 있습니다.) <br>
                <br>
                <span class="commonDot"></span> 직계존비속의 상을 당했을 경우 - 부고장, 사망진단서 등 <br>
                <span class="commonDot"></span> 본인 및 직계존비속의 사고 또는 갑작스러운 병변의 악화 시 <br>
                &nbsp;&nbsp; - 진단서, 입원확인서, 보험회사 사고증명서 원본 제출 <br>
                <br>
                ※ 위 증빙서류로 페널티 해지 가능 횟수는 연 1회에 한함


                <div class="margin50"></div>
            </div>
        </div>
    </div><!-- contents End-->

</div>	<!-- wrap End -->
<%@ include file="../include/footer.jsp" %>