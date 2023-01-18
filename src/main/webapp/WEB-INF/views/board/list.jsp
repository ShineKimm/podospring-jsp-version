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
    "7" : "명예의 전당"
  }

  $(document).ready(function() {
    init();
  });

  function init() {

    mType = <%=request.getParameter("type")%>;
    //mType = "1";

    $("#txtTitle").html(title[mType]);
    $("#type" + mType).addClass("on");

    $("#txtSearchText").keypress(function (event) {
      if(event.keyCode == 13) {
        doSearch();
      }
    });
    if (mType == "2" || mType == "5") {
      $("#eventList").show();
    } else {
      $("#noticeList").show();
    }

    if (mType == "5") {
      $("#galleryList").show();
    } else {
      $("#boardList").show();
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

    let text = $("#txtSearchText").val();
    let opt = $("#selSearchOption").val();

    if(text != "") {
      params["searchText"] = text;
      params["searchOption"] = opt;
    }

    // console.log(params);

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
            template += "<div class='galleryBox wow fadeInUp'>			";
            template += "	<a href='javascript:onClickRow({0})'>																																					";
            template += "		<div class='galImg'><img src='/images/getfile?fullpath={1}/{2}'  onerror='this.onerror=null; this.src=\" /images/getfile?fullpath=/uploads/mainBg01.jpg\"'></div>																															";
            template += "			<div class='gallery'>																																						";
            template += "				<div class='gallTitle'>{3}</div>																															";
            template += "				<p class='gallDate'>{4}</p>																																		";
            template += "				<span class='gallBtn'>자세히보기</span>																													";
            template += "			</div>																																													";
            template += "		</a>																																															";
            template += "	</div>																																															";

            eventList.append(String.format(template, i, rows[i].FILE_PATH1, rows[i].FILE_NAME1, rows[i].TITLE, rows[i].INPUT_DATETIME, rows[0].FILE_PATH3, rows[0].FILE_NAME3));
            // console.log("FILE_PATH:"+i+":::"+rows[i].FILE_PATH1);
            // console.log("FILE_NAME:"+i+":::"+rows[i].FILE_NAME1);
          } else {
            let tr = $("<tr style='cursor:pointer' onclick='onClickRow(" + i + ")'></tr>");
            let td1 = $("<td>" + rows[i].IDX + "</td>");
            let td2 = $("<td class='subject'>" + rows[i].TITLE + "</td>");
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
    let pageContainer = $("#pagecontainer");
    pageContainer.empty();
    let page = startPage;
    let prevBtn = "<a href='javascript:doSearchPaging10(" + (startPage - 10) + ")' class='pagebtn'>◀</a>";
    let nextBtn = "<a href='javascript:doSearchPaging10(" + (startPage + 10) + ")' class='pagebtn'>▶</a>";

    if(startPage != 1){
      pageContainer.append(prevBtn);
    }

    endPage = Math.floor(totalCnt / pageCnt);
    if(totalCnt % pageCnt != 0) {
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

  function onClickRow(i) {
    let type = rows[i].TYPE;
    let idx = rows[i].IDX;

    location.href = String.format("/board/view?type={0}&idx={1}", type, idx);
  }

</script>

<link rel="stylesheet" type="text/css" href="/css/animate.css">
<script src="/js/wow.js"></script>
<script>
  new WOW().init();
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
        <ul class="navbarBox" id="boardList" hidden>
            <li class="" onclick="location.href='/board/list?type=1'" id="type1">공지사항</li>
            <li class="" onclick="location.href='/board/list?type=2'" id="type2">이벤트</li>
            <li class="" onclick="location.href='/board/list?type=3'" id="type3">보도자료</li>
            <li class="" onclick="location.href='/board/list?type=4'" id="type4">자료실</li>
            <li class="" onclick="location.href='/board/honor'" id="honor">홀인원</li>
            <li class="" onclick="location.href='/reservation/joinList'" id="type6">조인게시판</li>
            <li class="" onclick="location.href='/board/list?type=7'" id="type7">명예의 전당</li>

            <li class="homeBox"><img src="/images/home.jpg" alt="">&nbsp; 정보마당 &nbsp;<img src="/images/mini_arw.jpg" alt="">&nbsp; <span id="txtTitle" style="font-size:inherit;color:inherit;font-weight:400;"></span></li>
        </ul>
        <ul class="navbarBox" id="galleryList" hidden>
            <li class="on" onclick="location.href='/course/intro'">코스소개</li>
            <li class="" onclick="location.href='/board/list?type=5'">코스갤러리</li>

            <li class="homeBox"><img src="/images/home.jpg" alt="">&nbsp; 코스소개 &nbsp;<img src="/images/mini_arw.jpg" alt="">&nbsp; 코스소개</li>
        </ul>
    </div>
    <div class="contents">
        <div class="borderBox">
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
                    <li><a href="javascript:doSearch()" class="darkGrayBtn serchBtn">검색</a></li>
                </ul>
                <div class="padding10"></div>

                <table class="commonTable" summary="게시글목록" id="noticeList" hidden>
                    <caption>게시글목록</caption>
                    <colgroup>
                        <col width="10%">
                        <col width="54%">
                        <col width="13%">
                        <col width="13%">
                        <col width="10%">
                    </colgroup>
                    <thead>
                    <tr>
                        <th>번호</th>
                        <th>제목</th>
                        <th>작성자</th>
                        <th>작성일</th>
                        <th>조회수</th>
                    </tr>
                    </thead>
                    <tbody id="tbody">
                    </tbody>
                </table>

                <div class="galleryListBox" id="eventList" hidden>
                </div>

                <div class="padding10"></div>
                <div class="pageNum">
                    <div class="pageNumWrap" id="pagecontainer">
                    </div>
                </div>

                <!--<div class="btnBox">
                    <a href="" class="darkGrayBtn">글쓰기</a>
                </div>-->

            </div>
        </div>
    </div><!-- contents End-->

</div>
<!-- wrap End -->
<%@ include file="../include/footer.jsp" %>