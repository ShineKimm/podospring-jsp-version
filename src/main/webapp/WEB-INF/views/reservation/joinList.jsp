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
      location.href = "/member/login?page=/reservation/joinList";
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

    // params["method"] = "getJoinList";

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
          tbody.append("<tr><td colspan='7'>등록된 글이 없습니다.</td></tr>");
        }

        for(i=0; i<rows.length; i++) {
          let tr = $("<tr style='cursor:pointer' onclick='onClickRow(" + i + ")'></tr>");
          let td1 = $("<td>" + rows[i].IDX + "</td>");
          let td2 = $("<td class='bold red'>" + (rows[i].BOARD_DIV == "1" ? "조인" : rows[i].BOARD_DIV == "2" ? "초대" : "기타") + "</td>");
          let td3 = $("<td>" + (rows[i].JOIN_STATUS == "1" ? "진행" : "마감") + "</td>");
          let td4 = $("<td class='title'>" + rows[i].TITLE + "</td>");
          let td5 = $("<td>" + rows[i].WRITER_NAME + "</td>");
          let td6 = $("<td>" + rows[i].INPUT_DATETIME + "</td>");
          let td7 = $("<td>" + rows[i].VIEW_CNT + "</td>");

          tr.append(td1, td2, td3, td4, td5, td6, td7).appendTo(tbody);
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

    let div = $("<div class='pageNumWrap'></div>");

    for(i=startPage; i<startPage+10; i++) {
      if(i > endPage) break;
      let a = $(String.format("<a href='javascript:doSearchPaging({0})'>{1}</a>", i, (i < 10 ? "0" + i : i)));

      if(currentPage == i) {
        a.addClass("on")
      }

      div.append(a);
    }

    pageContainer.append(div);

    if(endPage - startPage >= 10) {
      pageContainer.append(nextBtn);
    }
  }

  function onClickRow(i) {
    let type = rows[i].TYPE;
    let idx = rows[i].IDX;
    let seq = rows[i].SEQ;

    location.href = String.format("/reservation/joinView?idx={0}&seq={1}", idx, seq);
  }

</script>
<div class="middleBg zoomImg">
</div>
<ul class="mainMenuTitle text-focus-in">
    <li class="big">Reservation</li>
    <li>인터넷예약</li>
</ul>

<!-- 컨텐츠 시작 -->
<div id="wrap">
    <div class="navbarWrap">
        <ul class="navbarBox">
            <li class="" onclick="location.href='/board/list?type=1'">공지사항</li>
            <li class="" onclick="location.href='/board/list?type=2'">이벤트</li>
            <li class="" onclick="location.href='/board/list?type=3'">보도자료</li>
            <li class="" onclick="location.href='/board/list?type=4'">자료실</li>
            <li class="" onclick="location.href='/board/honor'">홀인원</li>
            <li class="on" onclick="location.href='/reservation/joinList'">조인게시판</li>
            <li class="" onclick="location.href='/board/list?type=7'">명예의 전당</li>

            <li class="homeBox"><img src="/images/home.jpg" alt="">&nbsp; 정보마당 &nbsp;<img src="/images/mini_arw.jpg" alt="">&nbsp; 조인게시판</li>
        </ul>
    </div>
    <div class="contents">

        <div class="joinChoice">
            <ul>
                <li>
                    <a href="/reservation/joinCal" class="cal "></a>
                    <a href="/reservation/joinList" class="list on"></a>
                </li>
            </ul>
            <p>포도CC 및 조인/초대와 관련되지 않은 글 <span class="bold">(비방, 협오, 부킹광고, 기타 조인/초대와 관련되지 않은 글)</span>은<br>
                작성자의 동의없이 임의 삭제될 수 있습니다.</p>
        </div>

        <div class="serching">
            <ul>
                <li>
                    <select name="Column" id="selSearchOption" class="select-arrow">
                        <option value="title" selected="">제목</option>
                        <option value="content">내용</option>
                        <option value="writer">작성자</option>
                    </select>
                </li>
                <li>
                    <input type="text" name="SearchString" id="txtSearchText" class="inputSerch" value="" title="검색할 내용">
                </li>
                <li><a href="javascript:doSearch()" class="motion serchBtn">검색</a></li>
            </ul>
            <div class="padding10"></div>
            <table class="joinTable">
                <colgroup>
                    <col width="10%">
                    <col width="10%">
                    <col width="10%">
                    <col width="40%">
                    <col width="10%">
                    <col width="10%">
                    <col width="10%">
                </colgroup>

                <thead>
                <tr>
                    <th scope="col">번호</th>
                    <th scope="col">구분</th>
                    <th scope="col">진행상황</th>
                    <th scope="col">제목</th>
                    <th scope="col">작성자</th>
                    <th scope="col">작성일</th>
                    <th scope="col">조회수</th>
                </tr>
                </thead>
                <tbody id="tbody">
                </tbody>
            </table>

            <div class="padding10"></div>
            <div class="pageNum" id="pageContainer">
            </div>

            <div class="btnBox">
                <a href="/reservation/joinWrite?action=I" class="darkGrayBtn">글쓰기</a>
            </div>

        </div>
    </div><!-- contents End-->

</div>	<!-- wrap End -->
<%@ include file="../include/footer.jsp" %>
