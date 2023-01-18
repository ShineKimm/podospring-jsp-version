<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<div class="menuTabBox">
	<ul class="menuList">
		<li class="on" ><a href="/mobile/member/join01">회원가입</a></li>
		<li class="" ><a href="/mobile/member/login">로그인</a></li>
	</ul>
</div>

<div class="contents">
	<ul class="commonTitle">
		<li class="title">회원가입완료</li>
		<li class="midBar"></li>
	</ul>

	<div class="joinEndTxt">
		<img src="/mobile/images/logo.svg">
		<p class="brown bold big">포도CC 회원가입을 진심으로 축하드립니다</p>		
		<p class="txt">포도CC는 고객님의 즐거운 라운딩을 위해 최선을 다하겠습니다.<br>
		포도CC 회원만의 다양한 혜택이 준비되어 있습니다.<br>
		감사합니다.<p>
	</div>



	<div class="btnBox">
		<a href="/mobile/member/login" class="motion">로그인하기</a>
		<a href="/mobile/index" class="cancel">메인으로</a>
	</div>

</div>	
<%@ include file="../include/footer.jsp" %>
