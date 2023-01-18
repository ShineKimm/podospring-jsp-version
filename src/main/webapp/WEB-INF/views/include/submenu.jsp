<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div id="scrollmenuwrap">
    <div id="scrollmenu2">
        <div class="menuBox">

            <ul class="subMenu ul1">
                <li><a href="/reservation/reservation">실시간예약</a></li>
                <li><a href="/reservation/reserCheck">예약확인/취소</a></li>
            </ul>

            <ul class="subMenu ul2">
                <li><a href="/guide/reserGuide">예약안내</a></li>
                <li><a href="/guide/fee">이용요금</a></li>
                <li><a href="/guide/break">위약안내</a></li>
                <li><a href="/guide/etiquette">에티켓</a></li>
                <li><a href="/guide/inquiry">예약/기타문의</a></li>
            </ul>

            <ul class="subMenu ul3">
                <li><a href="/club/intro">클럽소개</a></li>
                <li><a href="/club/greeting">인사말</a></li>
                <li><a href="/club/location">오시는길</a></li>
            </ul>

            <ul class="subMenu ul4">
                <li><a href="/course/intro">코스소개</a></li>
                <!--<li><a href="/course/o1">아웃코스</a></li>
                <li><a href="/course/i1">인코스</a></li>-->
                <li><a href="/board/list?type=5">코스갤러리</a></li>
            </ul>

            <ul class="subMenu ul5">
                <li><a href="/fac/fac01">클럽하우스</a></li>
                <li><a href="/fac/fac02">레스토랑</a></li>
                <li><a href="/fac/fac03">프로샵</a></li>
                <li><a href="/fac/fac04">락카</a></li>
            </ul>

            <ul class="subMenu ul6">
                <li><a href="/board/list?type=1">공지사항</a></li>
                <li><a href="/board/list?type=2">이벤트</a></li>
                <li><a href="/board/list?type=3">보도자료</a></li>
                <li><a href="/board/list?type=4">자료실</a></li>
                <li><a href="/board/honor">홀인원</a></li>
                <li><a href="/reservation/joinList">조인게시판</a></li>
                <li><a href="/board/list?type=7">명예의 전당</a></li>
            </ul>
        </div>

        <div class="menuLine"></div>
        <% if (session.getAttribute("MS_NUM") == null) { %>
        <div class="subMenuLink">
            <ul class="menuLinkBox" onclick="location.href='/member/login'">
                <li class="icon"><img src="/images/menuIcon01.png" alt=""></li>
                <li class="title">로그인</li>
                <li class="txt">새로워진 포도CC를 <br>
                    만나보세요</li>
            </ul>
            <div class="line"></div>
            <ul class="menuLinkBox" onclick="location.href='/member/join01'">
                <li class="icon"><img src="/images/menuIcon02.png" alt=""></li>
                <li class="title">회원가입</li>
                <li class="txt">회원가입 하면 더 <br>
                    많은 혜택을</li>
            </ul>
        </div>
        <% } else { %>
        <div class="subMenuLink">
            <ul class="menuLinkBox" onclick="doLogout()">
                <li class="icon"><img src="/images/menuIcon01.png" alt=""></li>
                <li class="title">로그아웃</li>
                <li class="txt">새로워진 포도CC를 <br>
                    만나보세요</li>
            </ul>
            <div class="line"></div>
            <ul class="menuLinkBox" onclick="location.href='/member/modify'">
                <li class="icon"><img src="/images/menuIcon03.png" alt=""></li>
                <li class="title">정보수정</li>
                <li class="txt">더 좋은 서비스로 <br>
                    보답 하겠습니다</li>
            </ul>
        </div>
        <% } %>
    </div>
</div>
