<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
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
    "5" : "코스갤러리",
    "7" : "명예의 전당",
    "8" : "팝업 관리"
  }

  $(document).ready(function() {
    init();
  });

  function init() {
    mType = <%=request.getParameter("type")%>;

    initTabMenu();

    $("#txtSearchText").keypress(function (event) {
      if(event.keyCode == 13) {
        doSearch();
      }
    });

    doSearch();
  }

  function initTabMenu() {
    $("#txtTitle").html(title[mType]);

    $("#tabContainer").children("a").each(function(index, element) {
      if(element.id == "tab" + mType) {
        $("#" + element.id).addClass("on");
      } else {
        $("#" + element.id).removeClass("on");
      }
    });
  }

  function doSearch() {
    let sUrl = "/getBoardList";
    let params = {};

    //params["method"] = "getBoardList";

    params["coDiv"] = globals.coDiv;
    params["type"] = mType;
    params["startCnt"] = (currentPage - 1) * pageCnt;
    params["pageCnt"] = pageCnt;
    params["adminYn"] = "Y"

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
          tbody.append("<tr><td colspan='6'>등록된 글이 없습니다.</td></tr>");
        }

        for(i=0; i<rows.length; i++) {
          let delDiv = rows[i].DEL_DIV;
          let tr = $("<tr style='cursor:pointer' onclick='onClickRow(" + i + ")'></tr>");
          let td1 = $("<td>" + rows[i].IDX + "</td>");
          let td2 = $("<td class='subject' style='text-decoration:" + (delDiv == "1" ? "line-through" : "none") + "'>" + rows[i].TITLE + "</td>");
          let td3 = $("<td>" + rows[i].WRITER_NAME + "</td>");
          let td4 = $("<td>" + rows[i].INPUT_DATETIME + "</td>");
          let td5 = $("<td>" + rows[i].VIEW_CNT + "</td>");

          tr.append(td1, td2, td3, td4, td5).appendTo(tbody);
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
    let pageContainer = $("#pagecontainer");
    pageContainer.empty();
    let page = startPage;
    let prevBtn = "<li onclick='doSearchPaging10(" + (startPage - 10) + ")' style='cursor:pointer'><span>◀</span></li>";
    let nextBtn = "<li onclick='doSearchPaging10(" + (startPage + 10) + ")' style='cursor:pointer'><span>▶</span></li>";

    if(startPage != 1){
      pageContainer.append(prevBtn);
    }

    endPage = Math.floor(totalCnt / pageCnt);
    if(totalCnt % pageCnt != 0) {
      endPage += 1;
    }

    for(i=startPage; i<startPage+10; i++) {
      if(i > endPage) break;
      let li = $(String.format("<li onclick='doSearchPaging({0})' style='cursor:pointer'><span class='bold ul'>{0}</span></li>", i));

      if(currentPage == i) {
        li.addClass("on")
      }

      pageContainer.append(li);
    }

    if(endPage - startPage >= 10) {
      pageContainer.append(nextBtn);
    }
  }

  function onClickRow(i) {
    let type = rows[i].TYPE;
    let idx = rows[i].IDX;

    location.href = String.format("/admin/board/view?type={0}&idx={1}", type, idx);
  }

  function doWrite() {
    location.href = "/admin/board/write?action=I&type=" + mType;
  }

  function onChangeTab(type) {
    mType = type;

    initTabMenu();

    doSearch();
  }

</script>

<div id="wrap">
    <ul class="gnb">
        <div class="content">
            <li class=""><a href="/admin/index">HOME</a></li>
            <li class="on"><a href="/admin/board/list?type=1">게시판 관리</a></li>
        </div>
    </ul>

    <div class="content">

        <div class="adminTab" id="tabContainer">
            <a href="javascript:onChangeTab('1')" id="tab1" class="on">공지사항</a>
            <a href="javascript:onChangeTab('2')" id="tab2" class="">이벤트</a>
            <a href="javascript:onChangeTab('3')" id="tab3" class="">보도자료</a>
            <a href="javascript:onChangeTab('4')" id="tab4" class="">자료실</a>
            <a href="javascript:onChangeTab('5')" id="tab5" class="">코스갤러리</a>
            <a href="javascript:onChangeTab('7')" id="tab7" class="">명예의 전당</a>
            <a href="javascript:onChangeTab('8')" id="tab8" class="">팝업 관리</a>
        </div>

        <div class="cate_title" id="txtTitle"></div>

        <div id="contentsWrap">
            <ul class="search">
                <li>
                    <select name="Column" id="selSearchOption" class="select-arrow">
                        <option value="title" selected="">제목</option>
                        <option value="content">내용</option>
                        <option value="writer">작성자</option>
                    </select>
                </li>
                <li>
                    <input type="text" id="txtSearchText" placeholder="검색하실 단어를 입력해주세요.">
                </li>
                <li><a href="javascript:doSearch()"><span class="btn">검색</span></a></li>
            </ul>

            <!-- 컨텐츠 시작 -->
            <div class="start">
                <table width="100%" border="0" cellspacing="0" cellpadding="0" summary="게시판관리">
                    <caption>게시판관리</caption>
                    <colgroup>
                        <col width="10%">
                        <col width="60%">
                        <col width="10%">
                        <col width="10%">
                        <col width="10%">
                    </colgroup>
                    <thead>
                    <tr>
                        <th>순번</th>
                        <th>제목</th>
                        <th>작성자</th>
                        <th>작성일</th>
                        <th>조회수</th>
                    </tr>
                    </thead>
                    <tbody id="tbody"></tbody>
                </table>

                <ul class="index" id="pagecontainer"></ul>

                <ul class="choice">
                    <li><a href="javascript:doWrite()"><span class="bigbtn">게시물등록</span></a></li>
                </ul>
                <div class="clear"></div>
                <br>
                <br>
            </div>
        </div>
    </div>
</div>
<%@ include file="../include/footer.jsp" %>
