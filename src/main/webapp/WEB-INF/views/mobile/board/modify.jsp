<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<div class="menuTabBox">
	<ul class="menuList">
		<li class="on" ><a href="/mobile/board/list">공지사항</a></li>
		<li class="" ><a href="/mobile/board/event">이벤트</a></li>
		<li class="" ><a href="/mobile/board/honor">홀인원</a></li>
		<li class="" ><a href="/mobile/board/joinList">조인게시판</a></li>
	</ul>
</div>

<div class="contents">
	<ul class="commonTitle">
		<li class="title">공지사항</li>
		<li class="midBar"></li>
	</ul>

	<table class="boardTable">
		<colgroup>
			<col width="20%">
			<col width="80%">
		</colgroup>

		<tbody>
			<tr>
				<th>제목</th>
				<td>
					<input type="text" class="txtInput" name="txtTitle" id="txtTitle">
				</td>
			</tr>
			<tr>
				<th rowspan="2">첨부파일1</th>
				<td>
					<input type="file" name="fileUpload2" id="fileUpload2">
				</td>
			</tr>
			<tr>
				<td>
					<input type="file" name="fileUpload3" id="fileUpload3">
				</td>
			</tr>
			<tr>
				<th>내용</th>
				<td>
					<textarea name="txtContent" id="txtContent"></textarea>
				</td>
			</tr>
		</tbody>
	</table>
	<div class="btnBox">
		<a href="" class="motion">수정</a>
		<a href="/mobile/index" class="cancel">삭제</a>
		<a href="/mobile/index" class="cancel">목록</a>
	</div>

				
	
</div>
<%@ include file="../include/footer.jsp" %>
