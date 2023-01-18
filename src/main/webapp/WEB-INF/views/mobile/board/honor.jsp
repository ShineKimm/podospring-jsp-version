<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<script>

	let startPage = 1;
	let endPage = 1;
	let currentPage = 1;
	let pageCnt = 10;
	let rows;

	$(document).ready(function() {
		init();
	});

	function init() {

		$("#txtSearchText").keypress(function (event) {
			if(event.keyCode == 13) {
				doSearch();
			}
		});

		doSearch();
	}

	function doSearch() {

		let sUrl = "/board/honorList";
		let params = {};

		//params["method"] = "/board/honorList";

		params["coDiv"] = globals.coDiv;
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
				let tbody = $("#tbody1");
				tbody.empty();

				if(rows.length == 0) {
					tbody.append("<tr><td colspan='5'>내역이 존재하지 않습니다.</td></tr>");
				}
				for(i=0; i<rows.length; i++) {
					let tr = $("<tr></tr>");
					let td1 = $("<td>" + rows[i].HOLL_DAY + "</td>");
					let td2 = $("<td>" + rows[i].HOLL_MSNAME + "</td>");
					let td3 = $("<td>" + rows[i].HOLL_DIV + "</td>");
					let td4 = $("<td>" + rows[i].HOLL_NO + "홀</td>");
					let td5 = $("<td>" + rows[i].HOLL_CLUB + "/" + rows[i].HOLL_BALL + "</td>");

					tr.append(td1, td2, td3, td4, td5).appendTo(tbody);
				}
				initPaging(data.intRecordCount);
			} else {
				alert("조회 실패");
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

	function initPaging(intRecordCount) {
		let pageContainer = $("#pagecontainer");
		pageContainer.empty();
		let page = startPage;
		let prevBtn = "<a href='javascript:doSearchPaging10(" + (startPage - 10) + ")' class='pagebtn'>◀</a>";
		let nextBtn = "<a href='javascript:doSearchPaging10(" + (startPage + 10) + ")' class='pagebtn'>▶</a>";

		if(startPage != 1){
			pageContainer.append(prevBtn);
		}

		endPage = Math.floor(intRecordCount / pageCnt);
		if(intRecordCount % pageCnt != 0) {
			endPage += 1;
		}

		for(i=startPage; i<startPage+10; i++) {
			if(i > endPage) break;
			let li = $(String.format("<a href='javascript:doSearchPaging({0})'>{1}</a>", i, (i < 10 ? "0" + i : i)));

			if(currentPage == i) {
				li.addClass("on")
			}

			pageContainer.append(li);
		}

		if(endPage - startPage >= 10) {
			pageContainer.append(nextBtn);
		}
	}

</script>

<div class="menuTabBox">
	<ul class="menuList">
		<li class="" ><a href="/mobile/board/list?type=1">공지사항</a></li>
		<li class="" ><a href="/mobile/board/list?type=2">이벤트</a></li>
		<li class="" ><a href="/mobile/board/list?type=3">보도자료</a></li>
		<li class="on" ><a href="/mobile/board/honor">홀인원</a></li>
		<li class="" ><a href="/mobile/board/joinList">조인게시판</a></li>
		<li class="" ><a href="/mobile/board/list?type=7">명예의 전당</a></li>
	</ul>
</div>
<div class="contents">
	<ul class="commonTitle">
		<li class="title">홀인원</li>
		<li class="midBar"></li>
	</ul>

	<div class="boardTxt">포도C.C 회원님들의 기록을 알려드립니다.</div>

	<table class="commonTable" summary="게시글목록" id="table_1" style="">
		<caption>게시글목록</caption>
		<colgroup>
			<col width="15%">
			<col width="13%">
			<col width="10%">
			<col width="8%">
			<col width="25%">
			<col width="13%">
		</colgroup>
		<tbody>
			<tr>
				<th>날짜</th>
				<th>성명</th>
				<th>구분</th>
				<th>홀</th>
				<th>클럽/볼</th>
				<th>동반자</th>
			</tr>
<%--<%--%>
<%--	If adoRs.BOF And adoRs.EOF Then--%>
<%--%>--%>
<%--				<tr><td colspan="6" class="empty">내역이 존재하지 않습니다.</td></tr>	--%>
<%--<%--%>
<%--	Else--%>
<%--		totalpage = adoRS.pagecount--%>
<%--		adoRS.absolutepage = intPageNum--%>

<%--		i = 1--%>
<%--		Do Until adoRs.EOF or i > adoRS.Pagesize--%>

<%--		For j = 1 To Len(adoRs("HOLL_MSNAME"))-2--%>
<%--		starStr = starStr & "*"--%>
<%--		Next--%>
<%--		starName = Left(adoRs("HOLL_MSNAME"),1)&starStr&Right(adoRs("HOLL_MSNAME"),1)--%>
<%--		starStr = ""--%>
<%--%>--%>
<%--			<tr>--%>
<%--				<td><%=Mid(adoRs("HOLL_DAY"),3,2)%>.<%=Mid(adoRs("HOLL_DAY"),5,2)%>.<%=Mid(adoRs("HOLL_DAY"),7,2)%></td>--%>
<%--				<td><%=starName%></td>--%>
<%--				<td><%If adoRs("HOLL_DIV") = "01" then%>알바트로스<%ElseIf adoRs("HOLL_DIV") = "02" Then%>홀인원<%ElseIf adoRs("HOLL_DIV") = "03" Then%>이글<%End If%></td>--%>
<%--				<td><%=adoRs("HOLL_NO")%></td>--%>
<%--				<td><%=adoRs("HOLL_CLUB")%>/<%=adoRs("HOLL_BALL")%></td>--%>
<%--				<td><%=adoRs("HOLL_DONG")%></td>--%>
<%--			</tr>--%>
<%--<%--%>
<%--			adoRs.MoveNext--%>
<%--			i = i + 1--%>
<%--		Loop--%>
<%--	End If--%>
<%--	adoRs.Close--%>
<%--%>--%>
<%--		</tbody>--%>
<%--	</table>--%>

<%--	<div class="padding10"></div>--%>
<%--	<div class="pageNum">--%>
<%--		<span class="pageNumWrap">--%>
<%--<%--%>
<%--		intTemp = Int(Int((intPageNum - 1) / intBlockPage)  * intBlockPage) + 1--%>

<%--		If Cint(intTemp) = 1 Then--%>
<%--%>--%>
<%--				<a href='#' class='pagebtn'>◀</a>--%>
<%--<%--%>
<%--		Else--%>
<%--%>--%>
<%--				<a href='honor?PageNum=<%=CLng(intTemp) - CInt(intBlockPage)%>'>◀</a>--%>
<%--<%--%>
<%--		End If--%>

<%--		intLoop = 1--%>

<%--		Do Until Cint(intLoop) > Cint(intBlockPage) Or Cint(intTemp) > Cint(intPageCount)--%>
<%--			If Cint(intTemp) = CInt(intPageNum) Then--%>
<%--%>--%>
<%--				<a href='#'><%=intTemp%></a>--%>
<%--<%--%>
<%--			Else--%>
<%--%>--%>
<%--				<a href='honor?PageNum=<%=intTemp%>'><%=intTemp%></a>--%>
<%--<%--%>
<%--			End If--%>
<%--			intTemp = Cint(intTemp) + 1--%>
<%--			intLoop = Cint(intLoop) + 1--%>
<%--		Loop--%>

<%--		If Cint(intTemp) > Cint(intPageCount) Then--%>
<%--%>--%>
<%--				<a href='#' class='pagebtn'>▶</a>--%>
<%--<%--%>
<%--		Else--%>
<%--%>--%>
<%--				<a href='honor?PageNum=<%=intTemp%>' class='pagebtn'>▶</a>--%>
<%--<%--%>
<%--		End If--%>
<%--%>--%>
		</span>
	</div>
	
</div>	
<%@ include file="../include/footer.jsp" %>
