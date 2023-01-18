<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<script src="https://unpkg.com/axios/dist/axios.min.js" defer></script>

<script>
	let mType = "6";
	let mIdx;
	let re_rows;
	let getIP;

	//ip 가져오기
	async function getClientIP() {
		try {
			const response = await axios.get('https://api.ipify.org?format=json');
			getIP = response.data.ip;
			//console.log(getIP);
		} catch (error) {
			console.error(error);
		}
	}

	$(document).ready(function() {
		getClientIP();
		init();
	});

	function init() {
		if(<%=session.getAttribute("MS_NUM") == null %>) {
			alert("로그인 후 이용 가능합니다.");
			location.href = "/member/login?page=/mobile/board/joinList";
			return;
		}

		mIdx = <%=request.getParameter("idx")%>;

		doSearchDetail();
		doSearchReply();
	}

	function doSearchDetail() {
		let sUrl = "/getBoardDetail";
		let params = {};

		//params["method"] = "getBoardDetail";
		params["coDiv"] = globals.coDiv;
		params["type"] = mType;
		params["idx"] = mIdx;

		mAjax(sUrl, params, "POST", true, function(data) {
			if(data.resultCode == "0000") {
				let rows = data.rows;

				let title = rows[0].TITLE;
				let writer = rows[0].WRITER_NAME;
				let inputDate = rows[0].INPUT_DATETIME;
				let viewCnt = rows[0].VIEW_CNT;
				let content = rows[0].CONTENT;
				let bkDay = getDateFormat(rows[0].BK_DAY);
				content = replaceAll(content, "\n", "<br>");

				$("#txtTitle").html(title);
				$("#txtWriter").html(writer);
				$("#txtViewCnt").html(viewCnt);
				$("#txtDate").html(inputDate);
				$("#txtContent").html(content);

				let template = "";
				template += "부킹일자 : {0} . {1} . {2} ({3}) <br>";
				template += "부킹시간 : {4} 시대<br>";
				template += "구분 : {5}<br>";
				template += "진행상태 : {6}";

				$("#txtBkInfo").html(String.format(template
					, bkDay.yyyy()
					, bkDay.mm()
					, bkDay.dd()
					, bkDay.week()
					, rows[0].BK_TIME
					, (rows[0].BOARD_DIV == "1" ? "초청" : "신청")
					, (rows[0].JOIN_STATUS == "1" ? "진행중" : "종료")
				));

				if(String(<%=session.getAttribute("MS_NUM")%>) == rows[0].INPUT_STAFF) {
					$("#btnAdminAction1").show();
					$("#btnAdminAction2").show();
				}
			} else {
				alert(data.resultMessage);
			}
		});
	}

	function doSearchReply() {
		let sUrl = "/getReplyList";
		let params = {};

		//params["method"] = "getReplyList";
		params["coDiv"] = globals.coDiv;
		params["type"] = mType;
		params["idx"] = mIdx;

		mAjax(sUrl, params, "POST", true, function(data) {
			if(data.resultCode == "0000") {
				let rows = data.rows;
				re_rows = rows;

				$("#replyContainer").empty();

				if(rows.length == 0) return;

				$("#replyContainer").append("<p class='joinTitle'></p>");

				let template = "";
				template += " <li> ";
				template += " 	<p class='data'>이름 : {0}</p> ";
				template += " 	<p class='data'>등록일자 : {1}</p> ";
				template += " 	<p class='text' id='Memo_57'> ";
				template += " 		{2} ";
				template += " 	</p> ";
				template += " 	<div class='editBtn' id='MemoBtn_57'> ";
				template += " 	</div>	";
				template += " 	<div class='editBtn' id='MemoEditFormBtn_57' {3}> ";
				template += "			<a href='javascript:doDeleteReply({4})' id='EditCanTxt_57'>X</a> ";
				template += "		</div> ";
				template += " </li> ";

				for(i=0; i<rows.length; i++) {
					let datetime = rows[i].INPUT_DATETIME;
					let writer = rows[i].WRITER_NAME;
					let staff = rows[i].INPUT_STAFF;
					let content = rows[i].CONTENT;
					content = replaceAll(content, "\n", "<br>");
					$("#replyContainer").append(String.format(template
						, writer
						, datetime
						, content
						, (<%=session.getAttribute("MS_NUM")%> == staff ? "" : "hidden")
						, i
					));
				}
			} else {
				alert(data.resultMessage);
			}
		});
	}

	function doDeleteReply(i) {
		let sUrl = "/doDeleteReply";
		let params = {};

		//params["method"] = "doDeleteReply";
		params["coDiv"] = globals.coDiv;
		params["type"] = mType;
		params["idx"] = mIdx;
		params["seq"] = re_rows[i].SEQ;

		mAjax(sUrl, params, "POST", true, function(data) {
			if(data.resultCode == "0000") {
				alert("댓글이 삭제되었습니다.");
				doSearchReply();
			} else {
				alert(data.resultMessage);
			}
		});
	}

	function doDelete() {
		let sUrl = "/doDelete";
		let params = {};

		//params["method"] = "doDelete";
		params["coDiv"] = globals.coDiv;
		params["type"] = mType;
		params["idx"] = mIdx;

		mAjax(sUrl, params, "POST", true, function(data) {
			if(data.resultCode == "0000") {
				alert("게시글이 삭제되었습니다.");
				location.href = "/mobile/board/joinList";
			} else {
				alert(data.resultMessage);
			}
		});
	}

	function doUpdate() {
		location.href = "/mobile/board/joinWrite?action=U&idx=" + mIdx;
	}

	function writeReply() {
		let sUrl = "/writeReply";
		let params = {};

		//params["method"] = "writeReply";
		params["coDiv"] = globals.coDiv;
		params["type"] = mType;
		params["idx"] = mIdx;
		params["content"] = $("#txtReContent").val();
		params["ip"] = getIP;

		mAjax(sUrl, params, "POST", true, function(data) {
			if(data.resultCode == "0000") {
				alert("댓글이 등록되었습니다.");
				doSearchReply();
			} else {
				alert(data.resultMessage);
			}
		});
	}

</script>
<div class="menuTabBox">
	<ul class="menuList">
		<li class="" ><a href="/mobile/board/list?type=1">공지사항</a></li>
		<li class="" ><a href="/mobile/board/list?type=2">이벤트</a></li>
		<li class="" ><a href="/mobile/board/honor">홀인원</a></li>
		<li class="on" ><a href="/mobile/board/joinList">조인게시판</a></li>
	</ul>
</div>

<div class="contents">
	<ul class="commonTitle">
		<li class="title">조인게시판</li>
		<li class="midBar"></li>
	</ul>

	<div class="boardTxt">조인/초대와 관련되지 않은 글 <span class="bold">(비방, 협오, 부킹광고, 기타 조인/초대와 관련되지 않은 글)</span>은 작성자의 동의없이 임의 삭제될 수 있습니다.</div>
	<table class="boardTable" summary="게시글목록" id="table_1" style="">
		<colgroup>
			<col width="10%">								
			<col width="*">
			<col width="10%">								
			<col width="*">
			<col width="10%">							
			<col width="*">							
		</colgroup>

		<tbody>
			<tr>
				<th>제목</th>
				<td colspan="5" class="lineTop viewTitle" id="txtTitle"></td>
			</tr>
			<tr>
				<th>작성자</th>
				<td id="txtWriter"></td>
				<th>작성일</th>
				<td colspan="3" id="txtDate"></td>
			</tr>
			<tr>
				<td colspan="6" class="joinCon" id="txtBkInfo">
				</td>
			</tr>
			<tr>
				<td colspan="6" class="joinCon" id="txtContent">
				</td>
			</tr>
			
		</tbody>
	</table>

		<div class="btnBox">
			<a href="/mobile/board/joinList" class="cancel">목록</a>
			<a href="javascript:doUpdate()" id="btnAdminAction1" class="cancel" hidden>수정</a>
			<a href="javascript:doDelete()" id="btnAdminAction2" class="cancel" hidden>삭제</a>
		</div>

		<div class="padding15"></div>

		<div class="comment">
			<div class="commentInner">
				<textarea name="body_memo" id="txtReContent" cols="30" rows="10" placeholder="댓글을 입력해 주세요." style="width:90%; height:100px; resize:none;"></textarea>
				<a href="javascript:writeReply()" class="miniBtn">등록</a>
			</div>		
		</div>

		<ul class="listComment" id="replyContainer">
		</ul>
	
</div>
<%@ include file="../include/footer.jsp" %>
