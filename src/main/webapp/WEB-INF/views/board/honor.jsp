<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<%--${resultMap.intPageSize}--%>
<%--<%=request.getAttribute("")%>--%>
<%--${resultMap.rows[0].HOLL_MSNAME}--%>

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


<div class="middleBg6 zoomImg">
</div>
<ul class="mainMenuTitle text-focus-in">
<li class="big">Infomation</li>
<li>정보마당</li>
</ul>


<!-- 컨텐츠 시작 -->
<div id="wrap">
    <div class="navbarWrap">
        <ul class="navbarBox">
            <li class="" onclick="location.href='/board/list?type=1'">공지사항</li>
            <li class="" onclick="location.href='/board/list?type=2'">이벤트</li>
            <li class="" onclick="location.href='/board/list?type=3'">보도자료</li>
            <li class="" onclick="location.href='/board/list?type=4'">자료실</li>
            <li class="on" onclick="location.href='/board/honor'">홀인원</li>
            <li class="" onclick="location.href='/reservation/joinList'">조인게시판</li>
            <li class="" onclick="location.href='/board/list?type=7'">명예의 전당</li>

            <li class="homeBox"><img src="/images/home.jpg" alt="">&nbsp; 정보마당 &nbsp;<img src="/images/mini_arw.jpg" alt="">&nbsp; 공지사항</li>
        </ul>
    </div>
    <div class="contents">
        <div class="borderBox">
            <div class="serching">
                <ul>
                    <li>
                        <select name="Column" id="selSearchOption" class="select-arrow">
                            <option value="title" selected="">성명</option>
                            <option value="content">내용</option>
                            <option value="writer">작성자</option>
                        </select>
                    </li>
                    <li>
                        <input type="text" name="SearchString" id="txtSearchText" class="inputSerch" value="" title="검색할 내용">
                    </li>
                    <li><a href="javascript:doSearch()" class="darkGrayBtn serchBtn">검색</a></li>
                </ul>
                <div class="padding10"></div>
                <table class="commonTable">
                    <colgroup>
                        <col width="11%">
                        <col width="10%">
                        <col width="12%">
                        <col width="13%">
                        <col width="54%">
                    </colgroup>
                    <tbody>
                    <tr>
                        <th scope="col">일자</th>
                        <th scope="col">성명</th>
                        <th scope="col">구분</th>
                        <th scope="col">홀</th>
                        <th scope="col">사용클럽/볼</th>
                        <!--<th scope="col">동반자</th>-->
                    </tr>
                    </tbody>
                    <tbody id="tbody1">
                    </tbody>
                </table>
                <div class="padding10"></div>
                <div class="pageNum">
                    <div class="pageNumWrap" id="pagecontainer">
                    </div>
                </div>

            </div>
        </div>
    </div><!-- contents End-->

</div>	<!-- wrap End -->
<%@ include file="../include/footer.jsp" %>