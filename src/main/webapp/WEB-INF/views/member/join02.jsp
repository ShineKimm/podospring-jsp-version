<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<div class="middleBg6 zoomImg">
</div>
<ul class="mainMenuTitle text-focus-in">
    <li class="big">Join Membership</li>
    <li>회원가입</li>
</ul>

<!-- 컨텐츠 시작 -->
<div id="wrap">
    <div class="navbarWrap">
        <ul class="navbarBox">
            <li class="" onclick="location.href='/member/login'">로그인</li>
            <li class="on" onclick="location.href='/member/join01'">회원가입</li>
            <li class="" onclick="location.href='/member/find'">아이디/비번찾기</li>
            <li class="homeBox"><img src="/images/home.jpg" alt="">&nbsp; 회원가입 &nbsp;<img src="/images/mini_arw.jpg" alt="">&nbsp; 회원가입</li>
        </ul>
    </div>
    <div class="contents">
        <div class="joinStep">
            <ul>
                <li class="">STEP1 회원약관동의
                    <div class="tri"></div>
                </li>
                <li class="on">STEP2 회원실명확인
                    <div class="tri on"></div>
                </li>
                <li class="">STEP3 회원정보입력
                    <div class="tri"></div>
                </li>
                <li class="">STEP4 회원가입완료
                    <div class="tri"></div>
                </li>
            </ul>
        </div>

        <div class="joinBox" style="margin-bottom:10px;">
            <h2 class="commonDot"> 회원인증 및 가입여부확인</h2>
            <div class="grayBgBox">
                <a href="javascript:certification_phone()"><img src="/images/btn_self.png"></a>
                <a href="javascript:certification_ipin()"><img src="/images/btn_ipin.png"></a>
            </div>
            <div class="joinTextBox">
                <p>• <span class="bold">기존에 실명인증을 받은 아이디가 있는 고객님은 추가로 아이디를 만드실 수 없습니다.</span></p>
                <p>
                    • 2012년 8월 18일 부터 시행되는 [정보통신망 이용 촉진 및 정보보호 등에 관한 법률(이하 정보통신망법)] 제 23조의 2 "주민등록번호의 사용 제한" 에 따라 <br>
                    주민등록번호를 입력받지 않습니다. 이에 따라 <span class="bold">회원가입 시 주민등록번호를 입력하는 실명인증 대신 아이핀 또는 본인명의로 가입된 휴대폰을 이용하여 본인인증</span>을<br> 하셔야 회원가입을 하실 수 있습니다.</p>
                <p>•<span class="bold"> 아이핀(I-Pin)이란?</span><br>
                    인터넷상에서 주민등록번호로 도용 범죄를 방지하기 위해 정부가 개발한 인터넷 신원확인 번호입니다. </p>
                <hr>
                <div class="joinTextBox">
                    <p>• 본인인증에 실패하셨나요? <br>
                        - 정보가 해당 인증기관에 등록되어 있지 않거나 기타 다른 사유로 실패한 경우일 수 있습니다. <br>
                        - 인증이 안되시는 경우 <span class="bold" style="color:#000000;">나이스신용평가정보 고객센터(1600-1522)</span>로 문의하여 주시기 바랍니다. <br>
                        - 통화 가능시간(평일:09~18시, 토/일요일(공휴일):휴무) <br>
                        - <span>국내거주 외국인의 회원가입은 법무부 출입국관리사무소에서 등록번호를 부여 받은 경우에만 가능합니다.</span></p>
                </div>
            </div>
            <div class="padding10"></div>
        </div>
        <div class="joinTextBox">
            <p>• 팝업차단으로 인해 본인인증에 실패하셨을 경우에는 팝업차단 가이드를 참조하세요.
                <a href="javascript:fpopupOpen(1)" class="popupBan">팝업차단 가이드</a>
            </p>
        </div>
    </div><!-- contents End-->

</div>	<!-- wrap End -->
<!--layer popoup-->
<div id="fpop1" class="f_contents1" style="display: none;">
    <div class="popX"><a href="javascript:popupFClose(1)"><img src="/images/x-box.png"></a></div>
    <p><img src="/images/allpopup.jpg"></p>
    <div class="popText center bold">상기 두 가지 방법으로 설정하신 후에도 결제 창이 보이지 않으실 경우에는<br>
        <span class="red">[로그아웃>재로그인]</span>하신 후 다시 이용해 주시기 바랍니다.</div>
</div>
<div id="overlay1" class="overlay" onclick="popupFOverlayClicked()" style="display: none;">
</div>
<%@ include file="../include/footer.jsp" %>
