<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<link rel="stylesheet" type="text/css" href="/mobile/css/animate.css">
<script src="/mobile/js/wow.js"></script>
<script type="text/javascript">
	/* 컨텐츠 fade in */
	wow = new WOW(
	{
		boxClass: 'fadeBox',
		animateClass: 'animated',
		offset: 100,
		callback: function(box) {
			//console.log("WOW: animating <" + box.tagName.toLowerCase() + ">")
		}
	});
	wow.init();
	/*//컨텐츠 fade in */
</script>
<script>

	let startPage = 1;
	let endPage = 1;
	let currentPage = 1;
	let pageCnt = 10;
	let rows;
	let mType;

	let title = {
		"1" : "공지사항",
		"2" : "이벤트",
		"3" : "보도자료",
		"4" : "자료실",
		"5" : "코스갤러리"
	}

	$(document).ready(function() {
		init();
	});

	function init() {
		mType = <%=request.getParameter("type")%>;

		$("#txtTitle").html(title[mType]);
		$("#type" + mType).addClass("on");

		if (mType == "2" || mType == "5") {
			$("#eventList").show();
		} else {
			$("#noticeList").show();
		}

		doSearch();
	}

	function doSearch() {
		let sUrl = "/getBoardList";
		let params = {};

		//params["method"] = "getBoardList";

		params["coDiv"] = globals.coDiv;
		params["type"] = mType;
		params["startCnt"] = (currentPage - 1) * pageCnt;
		params["pageCnt"] = pageCnt;

		mAjax(sUrl, params, "POST", true, function(data) {
			if(data.resultCode == "0000") {
				rows = data.rows;

				let tbody = $("#tbody");
				tbody.empty();
				let eventList = $("#eventList");
				eventList.empty();

				if(rows.length == 0) {
					tbody.append("<tr><td colspan='5'>등록된 글이 없습니다.</td></tr>");
					eventList.append("<div style='text-align:center'>등록된 글이 없습니다.</div>");
				}

				for(i=0; i<rows.length; i++) {
					if (mType == "2" || mType == "5") {

						let template = "";
						template += "<div class='galleryBox fadeBox fadeInUp'>			";
						template += "	<div class='gallBoxCont'>																																						";
						template += "	<a href='javascript:onClickRow({0})'>																																						";
						template += "		<div class='galImg'><img src='/images/getfile?fullpath={1}/{2}' onerror='this.src=\"/mobile/images/introImg1.jpg\"'></div>																															";
						template += "			<div class='gallery'>																																						";
						template += "				<div class='gallTitle'>{3}</div>																															";
						template += "				<p class='gallDate'>{4}</p>																																		";
						template += "				<span class='gallBtn'>자세히보기</span>																													";
						template += "			</div>																																													";
						template += "		</a>																																															";
						template += "	</div>																																															";
						template += "</div>																																																";

						eventList.append(String.format(template, i, rows[i].FILE_PATH1, rows[i].FILE_NAME1, rows[i].TITLE, rows[i].INPUT_DATETIME, rows[0].FILE_PATH3, rows[0].FILE_NAME3));
					} else {
						let tr = $("<tr style='cursor:pointer' onclick='onClickRow(" + i + ")'></tr>");
						let td1 = $("<td>" + rows[i].IDX + "</td>");
						let td2 = $("<td class='title'>" + rows[i].TITLE + "</td>");
						let td3 = $("<td>" + rows[i].WRITER_NAME + "</td>");
						let td4 = $("<td>" + rows[i].INPUT_DATETIME + "</td>");
						let td5 = $("<td>" + rows[i].VIEW_CNT + "</td>");

						tr.append(td1, td2, td3, td4, td5).appendTo(tbody);
					}
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

		location.href = String.format("/mobile/board/view?type={0}&idx={1}", type, idx);
	}

</script>
<div class="menuTabBox">
	<ul class="menuList">
		<li class="" id="type1"><a href="/mobile/board/list?type=1">공지사항</a></li>
		<li class="" id="type2"><a href="/mobile/board/list?type=2">이벤트</a></li>
        <li class="" id="type3"><a href="/mobile/board/list?type=3">보도자료</a></li>
		<li class="" ><a href="/mobile/board/honor">홀인원</a></li>
		<li class="" id="type6"><a href="/mobile/board/joinList">조인게시판</a></li>
		<li class="" id="type7"><a href="/mobile/board/list?type=7">명예의 전당</a></li>
	</ul>
</div>

<div class="contents">
	<ul class="commonTitle">
		<li class="title" id="txtTitle"></li>
		<li class="midBar"></li>
	</ul>
	
	<div class="boardTxt">포도C.C의 새로운 소식을 전해드립니다. </div>

	
	<table class="commonTable" summary="게시글목록" id="noticeList" hidden>
		<caption>게시글목록</caption>
		<colgroup>
			<col width="10%">
			<col width="40%">
			<col width="20%">
			<col width="20%">
			<col width="10%">
		</colgroup>
		<thead>
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>등록자</th>
				<th>등록일</th>
				<th>조회수</th>
			</tr>
		</thead>
		<tbody id="tbody">
		</tbody>
	</table>

	<div class="galleryListBox" id="eventList" hidden>
	</div>	

	<div class="padding10"></div>
	<div class="pageNum" id="pagecontainer">
	</div>
	
</div>	
<%@ include file="../include/footer.jsp" %>
