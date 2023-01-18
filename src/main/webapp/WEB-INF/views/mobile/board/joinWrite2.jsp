<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>

<div class="menuTabBox">
	<ul class="menuList">
		<li class="" ><a href="/mobile/board/list">공지사항</a></li>
		<li class="" ><a href="/mobile/board/event">이벤트</a></li>
		<li class="" ><a href="/mobile/board/honor">홀인원</a></li>
		<li class="on" ><a href="/mobile/board/joinList">조인게시판</a></li>
	</ul>
</div>

<div class="contents">
    <ul class="commonTitle">
		<li class="title">조인게시판</li>
		<li class="midBar"></li>
	</ul>
	
	<table class="boardTable">
		<colgroup>
			<col width="20%">
			<col width="*">
		</colgroup>

		<tbody>
			<tr>
				<th>제목</th>
				<td class="lineTop">
					<input type="text" class="replyInput">
				</td>
			</tr>
			<tr>
				<th>내용</th>
				<td>
					<textarea></textarea>
				</td>
			</tr>
		</tbody>
	</table>
	
	<div class="cl_b padding5"></div>
    	
	<div class="btnBox">
		<a href="/mobile/board/joinList" class="cancel">취소</a>
		<a href="/mobile/board/joinList" class="motion">등록</a>
	</div>
	
</div>
<%@ include file="../include/footer.jsp" %>

