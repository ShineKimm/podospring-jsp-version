<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<script src="https://unpkg.com/axios/dist/axios.min.js" defer></script>
<script>

  let mFlag;
  let mType = "6";
  let mYear, mMonth, mDate;
  let getIP = "";

  //ip 가져오기
  async function getClientIP() {
    try {
      const response = await axios.get('https://api.ipify.org?format=json');
      getIP = response.data.ip;
      //console.log(getIP);
      $("#ip").val(getIP);
    } catch (error) {
      console.error(error);
    }
  }

  $(document).ready(function() {
    getClientIP();
    init();

    initListener();
  });

  function init() {
    if(<%=session.getAttribute("MS_NUM") == null %>) {
      alert("로그인 후 이용 가능합니다.");
      location.href = "/member/login?page=/reservation/joinList";
      return;
    }

    mIdx = "<%=request.getParameter("idx")%>";
    mFlag = "<%=request.getParameter("action")%>";

    if(mFlag == "I") {
      $("#btnAction").html("등록");
    } else if(mFlag == "U") {
      $("#btnAction").html("수정");
      doSearchDetail();
    }

    $("#selTime").append("<option value=''>선택</option>");
    for(i=5; i<=19; i++) {
      $("#selTime").append(String.format("<option value='{0}'>{0}</option>", i));
    }

    let date = new Date();
    mYear = date.yyyy();
    mMonth = date.mm();
    mDate = date.yyyymmdd();

    $("#txtDate").html(String.format("{0}-{1}-{2}", date.yyyy(), date.mm(), date.dd()));

    initCalendar("#calContainer", mYear, mMonth);
  }

  function mNextMonth() {
    if(mMonth == "12") {
      mYear += 1;
      mMonth = "01";
    } else {
      mMonth = Number(mMonth) + 1;
      mMonth = (mMonth>9 ? '' : '0') + mMonth;
    }

    initCalendar("#calContainer", mYear, mMonth);
  }

  function mPrevMonth() {
    if(mMonth == "01") {
      mYear -= 1;
      mMonth = "12";
    } else {
      mMonth = Number(mMonth) - 1;
      mMonth = (mMonth>9 ? '' : '0') + mMonth;
    }

    initCalendar("#calContainer", mYear, mMonth);
  }

  function initCalendar(selector, year, month) {
    let rows = getCalendar(year, month);

    $(selector + " #calHeader").html(year + "년 " + month + "월");

    let tBody = $(selector + " #calBody");
    tBody.empty();

    let row = $("<tr></tr>");

    let fWeek = rows[0].week - 1;

    for(i=0; i<fWeek; i++) {
      row.append($("<td></td>"));
    }

    for(i=0; i<rows.length; i++) {
      let td = $("<td>" + rows[i].day + "</td>");

      if(rows[i].date == new Date().yyyymmdd()) {
        td.addClass('today');
      }

      td.addClass('possible');
      td.data('date', rows[i].date);

      td.on('click', function() {
        onClickMiniDay($(this).data('date'));
      });

      row.append(td);

      if(rows[i].week == 7) {
        row.appendTo(tBody);
        row = $("<tr></tr>");
      }
    }

    row.appendTo(tBody);
  }

  function onClickMiniDay(sDate) {
    let date = getDateFormat(sDate);

    mDate = sDate;
    $("#txtDate").html(String.format("{0}-{1}-{2}", date.yyyy(), date.mm(), date.dd()));
    $(".openCalendar").slideToggle();
  }

  function initListener() {
    $(".choiceCalendar").click(function () {
      $(".openCalendar").slideToggle();
    });
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
        rows = data.rows;
        let tbody = $("#tbody");
        tbody.empty();

        let title = rows[0].TITLE;
        let content = rows[0].CONTENT;
        let boardDiv = rows[0].BOARD_DIV;
        let joinStatus = rows[0].JOIN_STATUS;
        let bkDay = rows[0].BK_DAY;
        let bkTime = rows[0].BK_TIME;

        mDate = replaceAll(bkDay, "-", "");

        $("#txtTitle").val(title);
        $("#txtContent").val(content);
        $("#txtDate").html(bkDay);
        $("#selTime").val(bkTime);
        $('input:radio[name=boardDiv]:input[value=' + boardDiv + ']').attr("checked", true);
        $('input:radio[name=joinStatus]:input[value=' + joinStatus + ']').attr("checked", true);
      } else {
        alert(data.resultMessage);
      }
    });
  }

  function writeBoard() {
    let sUrl = "/writeBoard";

    // $("#method").val("writeBoard");
    $("#coDiv").val(globals.coDiv);
    $("#flag").val(mFlag);
    $("#type").val(mType);
    $("#idx").val(mIdx);
    $("#timestamp").val(getTimeStamp());

    let title = $("#txtTitle").val();

    if(title == "") {
      alert("제목을 입력하세요.");
      return;
    }

    if(mDate == null || mDate == "") {
      alert("날짜를 선택하세요.");
      return;
    } else {
      $("#bkDay").val(mDate);
    }

    let time = $("#selTime").val();
    if(time == "") {
      alert("시간을 입력하세요.");
      return;
    } else {
      $("#bkTime").val(time)
    }

    let formData = new FormData($("#fileForm")[0]);

    progressStart();
    mFileAjax(sUrl, formData, function(data) {
      progressStop();

      if(data.resultCode == "0000") {
        alert("작성한 글이 정상적으로 등록되었습니다.");

        location.href = "/reservation/joinList";
      } else {
        alert(data.resultMessage);
      }
    });
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
            <li class="" onclick="location.href='/board/list'">공지사항</li>
            <li class="" onclick="location.href='/board/event'">이벤트</li>
            <li class="" onclick="location.href='/board/list'">보도자료</li>
            <li class="" onclick="location.href='/board/list'">자료실</li>
            <li class="" onclick="location.href='/board/honor'">홀인원</li>
            <li class="on" onclick="location.href='/reservation/joinList'">조인게시판</li>

            <li class="homeBox"><img src="/images/home.jpg" alt="">&nbsp; 정보마당 &nbsp;<img src="/images/mini_arw.jpg" alt="">&nbsp; 조인게시판</li>
        </ul>
    </div>
    <div class="contents">
        <div class="joinChoice">
            <p>포도CC 및 조인/초대와 관련되지 않은 글 <span class="bold">(비방, 협오, 부킹광고, 기타 조인/초대와 관련되지 않은 글)</span>은<br>
                작성자의 동의없이 임의 삭제될 수 있습니다.</p>
        </div>
        <h2 class="commonTitle"> 조인게시판 글쓰기</h2>

        <form id="fileForm" action="fileUpload" method="post" enctype="multipart/form-data">
            <table class="joinViewTable">
                <tbody>
                <tr>
                    <th>제목</th>
                    <td><input type="text" class="wp90" id="txtTitle" name="txtTitle"></td>
                </tr>
                <tr>
                    <th>머리글</th>
                    <td><label><input type="radio" name="boardDiv" value="1" checked=""> 초대</label>&nbsp;&nbsp; <label><input type="radio" name="boardDiv" value="2"> 신청</label></td>
                </tr>
                <tr>
                    <th>진행상황</th>
                    <td><label><input type="radio" name="joinStatus" value="1" checked=""> 접수중</label>&nbsp;&nbsp; <label><input type="radio" name="joinStatus" value="2"> 마감</label></td>
                </tr>
                <tr>
                    <th>부킹일자</th>
                    <td>
                        <div class="birth w180" id="calContainer">
                            <txt id="txtDate"></txt>
                            <span class="choiceCalendar"><img src="/images/cal_icon.png"></span>
                            <div class="openCalendar">
                                <div class="smallCalendarTit">
                                    <p class="arwl"><a href="javascript:mPrevMonth()"><img src="/images/btn_ml.png" alt="전달"></a></p>
                                    <h3 id="calHeader"></h3>
                                    <p class="arwr"><a href="javascript:mNextMonth()"><img src="/images/btn_mr.png" alt="다음달"></a></p>
                                </div>
                                <table class="jCalendar">
                                    <colgroup>
                                        <col width="13%">
                                        <col width="13%">
                                        <col width="13%">
                                        <col width="13%">
                                        <col width="13%">
                                        <col width="13%">
                                        <col width="13%">
                                    </colgroup>
                                    <thead>
                                    <tr>
                                        <th scope="col">SUN</th>
                                        <th scope="col">MON</th>
                                        <th scope="col">TUE</th>
                                        <th scope="col">WEN</th>
                                        <th scope="col">THU</th>
                                        <th scope="col">FRI</th>
                                        <th scope="col">SAT</th>
                                    </tr>
                                    </thead>
                                    <tbody id="calBody">
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th>부킹시간</th>
                    <td>
                        <select id="selTime" class="w150">
                        </select>
                        <span class="gray"> 시대</span>
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

            <input type="hidden" id="method" name="method">
            <input type="hidden" id="coDiv" name="coDiv">
            <input type="hidden" id="type" name="type">
            <input type="hidden" id="idx" name="idx">
            <input type="hidden" id="flag" name="flag">
            <input type="hidden" id="bkTime" name="bkTime">
            <input type="hidden" id="bkDay" name="bkDay">
            <input type="hidden" id="timestamp" name="timestamp">
            <input type="hidden" id="ip" name="ip">
        </form>

        <div class="padding15"></div>

        <div class="btnBox">
            <a href="/reservation/joinList" class="cancel">목록</a>
            <a href="javascript:writeBoard()" id="btnAction" class="motion">입력</a>
        </div>

        <div class="padding15"></div>
    </div><!-- contents End-->

</div>	<!-- wrap End -->
<%@ include file="../include/footer.jsp" %>