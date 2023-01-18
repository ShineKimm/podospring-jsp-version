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
                <li class="">STEP2 회원정보입력
                    <div class="tri"></div>
                </li>
                <li class="on">STEP3 회원가입완료
                    <div class="tri on"></div>
                </li>
            </ul>
        </div>

        <div class="joinBox">
            <img src="/images/logo.svg" alt="" class="endLogo">
            <ul class="joinEndTxt">
                <li class="big">‘포도CC 회원가입을 진심으로 축하드립니다.’</li>
                <li class="txt">포도CC는 고객님의 즐거운 라운딩을 위해 최선을 다하겠습니다.
                    포도CC 회원만의 다양한 혜택이 준비되어 있습니다.</li>
            </ul>
            <div class="btnBox">
                <a href="" class="whiteBtn">메인페이지로 이동</a>
            </div>
            <div class="margin30"></div>
        </div>
    </div><!-- contents End-->

</div>	<!-- wrap End -->
<%@ include file="../include/footer.jsp" %>