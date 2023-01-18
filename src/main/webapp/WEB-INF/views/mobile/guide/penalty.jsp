<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<div class="menuTabBox">
	<ul class="menuList">
		<li class="" ><a href="/mobile/guide/guide">에약안내</a></li>
		<li class="" ><a href="/mobile/guide/fee">이용요금</a></li>
		<li class="on" ><a href="/mobile/guide/penalty">위약안내</a></li>
		<li class="" ><a href="/mobile/guide/etiquette">에티켓</a></li>
		<li class="" ><a href="/mobile/guide/etc">예약/기타문의</a></li>
	</ul>
</div>

<div class="contents">
	<ul class="commonTitle">
		<li class="title">위약안내</li>
		<li class="midBar"></li>
	</ul>

	<div class="commonDot"> 임박취소</div>
		<p class="calTxt">
		예약자가 라운드일로부터 5일전 17:00까지 예약을 취소한 경우에는 페널티 없이 정상취소가 가능합니다.<br>
		라운드일 5일 전 17:00 이후에 예약을 취소하거나, 예약 당일 통지없이 골프장을 이용하지 않을 경우에는<br>
		당 클럽이 정한 아래의 위약 처리 규정에 따라 처리됩니다. <br>
		위약 처리 규정은 예약정지를 원칙으로 하되 위약자가 위약해지를 원할 경우 구제금을 납부하고 위약을 해지할 수 있습니다.
		</p>
		<table class="commonTable" summary="위약안내" width="100%">
			  <caption>임박취소</caption>
			  <colgroup>
				<col width="*">
				<col width="*">
				<col width="*">
			  </colgroup>
			  <tbody>
			  <tr>
				<th scope="col">구분</th>
				<th scope="col">패널티기간</th>
				<th scope="col">구제금<br>(위약해제금액)</th>
			  </tr>
			  <tr>
				<td>라운드 5일 전 17:00 이후부터<br>3일전 17:00 이전 예약취소</td>
				<td>1개월 예약정지</td>
				<td>팀당 10만원</td>
			  </tr>
			   <tr>
				<td>라운드 3일 전 17:00 이후부터<br>2일 전 17:00 이전 예약취소</td>
				<td>2개월 예약정지</td>
				<td>팀당 15만원</td>
			  </tr>
			   <tr rowspan="2">
				<td>라운드 2일 전 17:00 이후부터<br>1일 전 17:00 이전 예약취소</td>
				<td>3개월 예약정지</td>
				<td>팀당 20만원(평일)<br>팀당 30만원(주말 및 공휴일)</td>
			  </tr>
			  <tr rowspan="2">
				<td>라운드 1일 전 17:00 이후 취소,<br>당일 미내장(No-show)</td>
				<td>위약금 납부시까지<br>영구 예약 및 내장 정지</td>
				<td>팀당 30만원(평일)<br>팀당 50만원(주말 및 공휴일</td>
			  </tr>
			</tbody>
		</table>
		<br>
		<p class="calTxt">
			※ 예외규정<br>
			(예약자가 다음 사항에 해당 시 증빙을 당클럽에 제출한 후 위약을 해지할 수 있습니다.)<br>
			1) 직계존비속의 상을 당했을 경우 - 부고장, 사망진단서 등<br>
			2) 본인 및 직계존비속의 사고 또는 갑작스러운 병변의 악화 시<br>
			- 진단서, 입원확인서, 보험회사 사고증명서 원본 제출<br><br>
			※ 위 증빙서류로 페널티 해지 가능 횟수는 연 1회에 한함
		</p>


</div>	
<%@ include file="../include/footer.jsp" %>
