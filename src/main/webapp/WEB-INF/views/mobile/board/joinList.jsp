<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>

<script>

	let stDate, edDate;
	let startPage = 1;
	let endPage = 1;
	let currentPage = 1;
	let pageCnt = 10;

	$(document).ready(function() {
		init();
		// initListener();
	});

	function init() {
		if(<%=session.getAttribute("MS_NUM") == null %>) {
			alert("로그인 후 이용 가능합니다.");
			location.href = "/mobile/member/login?page=/mobile/board/joinList";
			return;
		}

		let date = new Date();
		let date2 = addMonth(date.yyyymmdd(), 3);
		if("<%=request.getParameter("date")%>".length == 8) {
			date = getDateFormat("<%=request.getParameter("date")%>");
			date2 = getDateFormat("<%=request.getParameter("date")%>");
		}
		sYear = date.yyyy();
		sMonth = date.mm();
		fYear = date2.yyyy();
		fMonth = date2.mm();
		stDate = date.yyyymmdd();
		edDate = date2.yyyymmdd();

		doSearch();
	}

	function doSearch() {
		let sUrl = "/getJoinList";
		let params = {};

		//params["method"] = "getJoinList";

		params["coDiv"] = globals.coDiv;
		params["type"] = "6";
		params["stDate"] = stDate;
		params["edDate"] = edDate;
		params["startCnt"] = (currentPage - 1) * pageCnt;
		params["pageCnt"] = pageCnt;

		let text = $("#txtSearchText").val();
		let opt = $("#selSearchOption").val();

		if(text != "") {
			params["searchText"] = text;
			params["searchOption"] = opt;
		}

		mAjax(sUrl, params, "POST", true, function(data) {
			if(data.resultCode == "0000") {
				rows = data.rows;

				let tbody = $("#tbody");
				tbody.empty();

				if(rows.length == 0) {
					tbody.append("<tr><td colspan='4'>등록된 글이 없습니다.</td></tr>");
				}

				for(i=0; i<rows.length; i++) {
					let tr = $("<tr style='cursor:pointer' onclick='onClickRow(" + i + ")'></tr>");
					let td1 = $("<td class='bold'>" + (rows[i].BOARD_DIV == "1" ? "조인" : rows[i].BOARD_DIV == "2" ? "초대" : "기타") + "</td>");
					let td2 = $("<td class='" + (rows[i].JOIN_STATUS == "1" ? "orange" : "gray") + "'>" + (rows[i].JOIN_STATUS == "1" ? "진행" : "마감") + "</td>");
					let td3 = $("<td class='title'>" + rows[i].TITLE + "</td>");
					let td4 = $("<td>" + rows[i].INPUT_DATETIME + "</td>");

					tr.append(td1, td2, td3, td4).appendTo(tbody);
				}

				initPaging(data.totalCnt);
			} else {
				alert(data.resultMessage);
			}
		});
	}

	function doSearchPaging(page) {
		currentPage = page;
		doSearch();
	}

	function doSearchPaging10(page) {
		currentPage = page;
		startPage = page;
		doSearch();
	}

	function initPaging(totalCnt) {
	  let pageContainer = $("#pageContainer");
	  pageContainer.empty();
	  let page = startPage;
	  let prevBtn = "<a href='javascript:doSearchPaging10(" + (startPage - 10) + ")' class='pagebtn'>◀</a>";
	  let nextBtn = "<a href='javascript:doSearchPaging10(" + (startPage + 10) + ")' class='pagebtn'>▶</a>";

	  endPage = Math.floor(totalCnt / pageCnt);
	  if(totalCnt % pageCnt != 0) {
	    endPage += 1;
	  }

	  if(startPage != 1){
	    pageContainer.append(prevBtn);
	  }

	  let span = $("<span class='pageNumWrap'></span>");

	  for(i=startPage; i<startPage+10; i++) {
	    if(i > endPage) break;
	    let a = $(String.format("<a href='javascript:doSearchPaging({0})'>{1}</a>", i, (i < 10 ? "0" + i : i)));

	    if(currentPage == i) {
	      a.addClass("on")
	    }

	    span.append(a);
	  }

	  pageContainer.append(span);

	  if(endPage - startPage >= 10) {
	    pageContainer.append(nextBtn);
	  }
	}

	function onClickRow(i) {
		let type = rows[i].TYPE;
		let idx = rows[i].IDX;
		let seq = rows[i].SEQ;

		location.href = String.format("/mobile/board/joinView?idx={0}&seq={1}", idx, seq);
	}

</script>
<div class="menuTabBox">
	<ul class="menuList">
		<li class="" ><a href="/mobile/board/list?type=1">공지사항</a></li>
		<li class="" ><a href="/mobile/board/list?type=2">이벤트</a></li>
		<li class="" ><a href="/mobile/board/list?type=3">보도자료</a></li>
		<li class="" ><a href="/mobile/board/honor">홀인원</a></li>
		<li class="on" ><a href="/mobile/board/joinList">조인게시판</a></li>
		<li class="" ><a href="/mobile/board/list?type=7">명예의 전당</a></li>
	</ul>
</div>

<div class="contents">
	<ul class="commonTitle">
		<li class="title">조인게시판</li>
		<li class="midBar"></li>
	</ul>

	<div class="boardTxt">조인/초대와 관련되지 않은 글 <span class="bold">(비방, 협오, 부킹광고, 기타 조인/초대와 관련되지 않은 글)</span>은 작성자의 동의없이 임의 삭제될 수 있습니다.</div>
	<table class="commonTable" summary="게시글목록" id="table_1" style="">
		<colgroup>
			<col width="15%">
			<col width="15%">
			<col width="48%">
			<col width="22%">
		</colgroup>

		<thead>
			<tr>								
				<th scope="col">구분</th>								
				<th scope="col">진행상황</th>
				<th scope="col">제목</th>
				<th scope="col">예약일</th>
			</tr>
		</thead>
		<tbody id="tbody">
		</tbody>
	</table>

	<div class="padding10"></div>
	<div class="pageNum" id="pageContainer">
	</div>

	<div class="btnBox">
		<a href="/mobile/board/joinWrite?action=I" class="motion">글쓰기</a>
	</div>
	
</div>	
<%@ include file="../include/footer.jsp" %>
