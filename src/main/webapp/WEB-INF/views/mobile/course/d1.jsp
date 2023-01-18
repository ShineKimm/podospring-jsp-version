<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<%--TODO 사용하는페이지인지 확인필요--%>
<div class="contents" style="padding-bottom:0;">
	<ul class="commonTitle">
		<li class="title">코스안내</li>
		<li class="midBar"></li>
	</ul>

	<div class="boardTxt">용의 형상에 시작하여 크고 깊은 잔잔한 호수의 <br>흐름을 표현하여 유려하지만 강인한 느낌</div>

	<ul class="courseTab">
		<li class="" onclick="location.href='intro'">All</li>
		<li class="" onclick="location.href='l1'">레이크코스</li>
		<li class="on" onclick="location.href='d1'">드래곤코스</li>
	</ul>

	<div class="courseInfoBox">
		<ul class="courseInfo">
			<li class="hole orange">1</li>
			<li class="course"><span class="big">hole</span>Dragon Course</li>
		</ul>
		<div class="selectBox">
			<select name="" id=""onchange="window.open(value,'_self');" class="select-arrow select">
				<option value="d1"selected>1홀</option>
				<option value="d2" >2홀</option>
				<option value="d3">3홀</option>
				<option value="d4">4홀</option>
				<option value="d5">5홀</option>
				<option value="d6">6홀</option>
				<option value="d7">7홀</option>
				<option value="d8">8홀</option>
				<option value="d9">9홀</option>
			</select>
		</div>
	</div>
	<div class="courseTxt">그린이 보이지 않는 홀입니다.<br>
	방향은 f/w 중앙에 보이는 소나무 보고 치시는것이 좋습니다.<br>
	카트 도로 좌측은 OB이며 여유가 없습니다.
	</div>
	<img src="/mobile/images/course/d1.jpg" alt="" class="courseImg">
	<div class="commonDot"> 거리&파정보</div>
	<table class="commonTable" summary="거리&amp;파정보&quot;">
				  <caption>거리&amp;파정보</caption>
				  <colgroup>
					<col width="12%">
					<col width="12%">
					<col width="19%">
					<col width="19%">
					<col width="19%">
					<col width="19%">
				  </colgroup>
				  <tbody>
					  <tr>
						<th>홀</th>
						<th>Par</th>
						<th class="blue">BLUE</th>
						<th>WHITE</th>
						<th class="yellow">YELLOW</th>
						<th class="red">RED</th>
					  </tr>
					  <tr>
						<td>1</td>
						<td>4</td>
						<td>365</td>
						<td>346</td>
						<td>329</td>
						<td>260</td>
					  </tr>
				</tbody>
	</table>
</div>	

<%@ include file="../include/footer.jsp" %>
