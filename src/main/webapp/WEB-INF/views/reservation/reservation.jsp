<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<script src="https://unpkg.com/axios/dist/axios.min.js" defer></script>
<script>

  let mDate;
  let mCos = "All";
  let sYear, fYear, sMonth, fMonth;
  let rowData;
  let weekDayCnt, weekEndCnt;
  let getIP;

  //ip 가져오기
  async function getClientIP() {
    try {
      const response = await axios.get('https://api.ipify.org?format=json');
      getIP = response.data.ip;
      // console.log(getIP);
    } catch (error) {
      console.error(error);
    }
  }


  $(document).ready(function(data) {
    getClientIP();
    init();
  });

  function init() {

    if(<%=session.getAttribute("MS_NUM") == null %>) {
      alert("로그인 후 이용 가능합니다.");
      location.href = "/member/login?page=/reservation/reservation";
      return;
    }

    let date = new Date();
    sYear = date.yyyy();
    sMonth = date.mm();
    let date2 = addMonth(date.yyyymmdd(), 1);
    fYear = date2.yyyy();
    fMonth = date2.mm();

    initCalendar("#calendarBox1", sYear, sMonth);
    initCalendar("#calendarBox2", fYear, fMonth);

    let day = "<%=request.getParameter("BK_DAY")%>";
    if (<%=request.getParameter("OLD_BK_DAY") != null %>) {
      day = "<%=request.getParameter("OLD_BK_DAY")%>"
    }
    if(day != "null") {
      mDate = day;
      let dSel = getDateFormat(mDate);
      $("#txtChooseDate").empty().append(String.format("{0}년 {1}월 {2}일 ({3}요일)", dSel.yyyy(), dSel.mm(), dSel.dd(), dSel.week()));
      onCosChange(mCos);
    }
  }

  function initCalendar(selector, year, month) {
    let sUrl = "/getCalendar";
    let params = {};

    //params["method"] = "getCalendar";
    params["coDiv"] = globals.coDiv;
    params["selYm"] = year + month;

    mAjax(sUrl, params, "POST", true, function(data) {
      if(data.resultCode == "0000") {
        $(selector + " #calHeader").html(month + "<span>月</span>");

        let currentDay = new Date().yyyymmdd();
        let tBody = $(selector + " #calBody");
        tBody.empty();

        let rows = data.rows;

        if(rows.length > 0) {
          let row = $("<tr></tr>");

          let fWeek = rows[0].CL_DAYDIV - 1;

          for(i=0; i<fWeek; i++) {
            row.append($("<td></td>"));
          }
          for(i=0; i<rows.length; i++) {
            let td = $("<td>" + rows[i].DAYNUM + "</td>");
            if (<%=request.getParameter("OLD_BK_DAY") != null%>) {
              td.addClass('no');
            } else if (rows[i].CL_SOLAR == currentDay) {
              td.addClass('choice');
            } else if(rows[i].CL_SOLAR >= currentDay) {
              td.data('date', rows[i].CL_SOLAR);
              if(rows[i].BK_TEAM > 0) {
                // console.log("BK_TEAM::"+rows[i].BK_TEAM);
                td.addClass('possible');
                td.on('click', function() {
                  onClickDay($(this).data('date'));
                });
              } else {
                td.addClass('no');
              }
            } else {
              td.addClass('no');
            }

            row.append(td);

            if(rows[i].CL_DAYDIV == 7) {
              row.appendTo(tBody);
              row = $("<tr></tr>");
            }
          }

          let addTd = 7 - row.children("td").length;

          if(addTd != 7) {
            for(i=0; i<addTd; i++) {
              row.append($("<td></td>"));
            }
          }

          row.appendTo(tBody);
        } else {
          tBody.append($("<tr><td colspan='7'></td></tr>"));
          tBody.append($("<tr><td colspan='7'></td></tr>"));
          tBody.append($("<tr><td colspan='7'></td></tr>"));
          tBody.append($("<tr><td colspan='7'></td></tr>"));
          tBody.append($("<tr><td colspan='7'></td></tr>"));
          tBody.append($("<tr><td colspan='7'></td></tr>"));
        }
      } else {
        alert(data.resultMessage);
      }
    });
  }

  function doNextMonth() {
    if(sMonth == "12") {
      sYear += 1;
      sMonth = "01";
    } else {
      sMonth = Number(sMonth) + 1;
      sMonth = (sMonth>9 ? '' : '0') + sMonth;
    }

    initCalendar("#calendarBox1", sYear, sMonth);

    if(fMonth == "12") {
      fYear += 1;
      fMonth = "01";
    } else {
      fMonth = Number(fMonth) + 1;
      fMonth = (fMonth>9 ? '' : '0') + fMonth;
    }

    initCalendar("#calendarBox2", fYear, fMonth);
  }

  function doPrevMonth() {
    if(sMonth == "01") {
      sYear -= 1;
      sMonth = "12";
    } else {
      sMonth = Number(sMonth) - 1;
      sMonth = (sMonth>9 ? '' : '0') + sMonth;
    }

    initCalendar("#calendarBox1", sYear, sMonth);

    if(fMonth == "01") {
      fYear -= 1;
      fMonth = "12";
    } else {
      fMonth = Number(fMonth) - 1;
      fMonth = (fMonth>9 ? '' : '0') + fMonth;
    }

    initCalendar("#calendarBox2", fYear, fMonth);
  }

  function changeTabCos(cos) {
    mCos = cos;

    $("#cosContainer").children("li").each(function() {
      if(this.id == "cos" + mCos) {
        $("#" + this.id).addClass("on");
      } else {
        $("#" + this.id).removeClass("on");
      }
    });

    doSearch();
  }

  function onClickDay(date) {
    let dSel = getDateFormat(date);

    $("#txtChooseDate").empty().append(String.format("{0}년 {1}월 {2}일 ({3}요일)", dSel.yyyy(), dSel.mm(), dSel.dd(), dSel.week()));

    mDate = date;

    doSearch();
  }

  function doSearch() {
    let sUrl = "/getTeeList";
    let params = {};

    if(mDate == null || mDate == '' || mDate == "null") {
      alert("날짜를 선택하세요.");
      return;
    }

    //params["method"] = "getTeeList";
    params["coDiv"] = globals.coDiv;
    params["date"] = mDate;
    params["cos"] = mCos;
    params["msNum"] = "<%=session.getAttribute("MS_NUM")%>";

    mAjax(sUrl, params, "POST", true, function(data) {
      if(data.resultCode == "0000") {
        let tBody = $("#tbody");
        tBody.empty();

        rowData = data.rows;
        weekDayCnt = data.weekDayCnt;
        weekEndCnt = data.weekEndCnt;

        for(i=0; i<rowData.length; i++) {
          let row = $("<tr></tr>");

          let bkTime = rowData[i].BK_TIME;
          bkTime = bkTime.substring(0, 2) + ":" + bkTime.substring(2, 4);

          let col1 = $("<td>" + bkTime + "</td>");
          let col2 = $("<td>" + rowData[i].BK_COS_NM + "코스</td>");
          let col3 = $("<td>" + rowData[i].BK_B_CHARGE_NM + "</td>");
          let col4 = $("<td class='red'>" + rowData[i].BK_S_CHARGE_NM + "</td>");
          let col5 = $("<td>" + rowData[i].BK_CADDY + "</td>");
          let col6 = "";
          if (<%=request.getParameter("OLD_BK_DAY") != null%>) {
            col6 = $("<td><input type='button' class='darkGrayBtn' value='변경' onclick='reserProc(" + i + ")'></td>");
          } else {
            col6 = $("<td><input type='button' class='darkGrayBtn' value='예약' onclick='reserProc(" + i + ")'></td>");
          }

          row.append(col1,col2,col3,col4,col5,col6).appendTo(tBody);
        }

        if(rowData.length > 0) {
          let offset = $("#scrollerLine").offset();
          $('html, body').animate({scrollTop : offset.top}, 400);
        }
      } else {
        alert(data.resultMessage);
      }
    });
  }

  function onCosChange(cos) {
    mCos = cos;

    $(".courseTabList").children("li").each(function() {
      if(mCos == $(this).data("cos")) {
        $(this).addClass("on");
      } else {
        $(this).removeClass("on");
      }
    });

    doSearch();
  }

  function reserProc(i) {

    if(<%=session.getAttribute("MS_NUM") == null %>) {
      location.href = "/member/login?page=/reservation/reservation";
      return;
    }

    let comment = "";
    if (String(<%=session.getAttribute("MS_DIVISION")%>) == "48"){
        // console.log("MS_DIVISION == 48")
    }
    if (String(<%=session.getAttribute("MS_DIVISION")%>) != "21") {
          if (rowData[i].CL_BUSINESS == "1" && weekDayCnt >= <%=session.getAttribute("MS_WEEKDAY_CNT")%>) {
            comment = "\r\n회원님께서는 해당 주중 예약 횟수를 초과하여 비회원가로 예약됩니다.\r\n\r\n";
          } else if (rowData[i].CL_BUSINESS != "1" && weekEndCnt >= <%=session.getAttribute("MS_WEEKEND_CNT")%>) {
            comment = "\r\n회원님께서는 해당 주말 예약 횟수를 초과하여 비회원가로 예약됩니다.\r\n\r\n";
          }
    }

    let sUrl = "";
    let params = {};

    let msNum = "<%=session.getAttribute("MS_NUM")%>";
    let bkCharge = rowData[i].BK_B_CHARGE;
    if(rowData[i].BK_S_CHARGE != "") {
      bkCharge = rowData[i].BK_S_CHARGE;
    }

    if (<%=request.getParameter("OLD_BK_DAY") != null%>) {
      //params["method"] = "changeReservation";
      sUrl = "/changeReservation";
      params["coDiv"] = globals.coDiv;
      params["aday"] = rowData[i].BK_DAY;
      params["acos"] = rowData[i].BK_COS;
      params["atime"] = rowData[i].BK_TIME;
      params["charge"] = bkCharge;
      params["bDay"] = "<%=request.getParameter("OLD_BK_DAY")%>";
      params["bCos"] = "<%=request.getParameter("OLD_BK_COS")%>";
      params["bTime"] = "<%=request.getParameter("OLD_BK_TIME")%>";
      params["msNum"] = msNum;
      params["media"] = "R";
      params["ip"] = getIP;

      ans = confirm("[변경 확인] " + rowData[i].BK_DAY.substring(0,4)+"-"+rowData[i].BK_DAY.substring(4,6)+"-"+rowData[i].BK_DAY.substring(6,8)+" 날짜의 \n\n"+rowData[i].BK_TIME.substring(0,2)+"시"+rowData[i].BK_TIME.substring(2,4)+"분 "+rowData[i].BK_COS_NM+" 예약으로 변경하시겠습니까?");
    } else {
      sUrl = "/doReservation";
      //params["method"] = "doReservation";
      params["coDiv"] = globals.coDiv;
      params["day"] = rowData[i].BK_DAY;
      params["cos"] = rowData[i].BK_COS;
      params["time"] = rowData[i].BK_TIME;
      params["charge"] = bkCharge;
      params["msNum"] = msNum;
      params["media"] = "R";
      params["ip"] = getIP;

      ans = confirm("[예약 확인] " + comment + rowData[i].BK_DAY.substring(0,4)+"-"+rowData[i].BK_DAY.substring(4,6)+"-"+rowData[i].BK_DAY.substring(6,8)+" 날짜의 \n\n"+rowData[i].BK_TIME.substring(0,2)+"시"+rowData[i].BK_TIME.substring(2,4)+"분 "+rowData[i].BK_COS_NM+" 예약을 확정하시겠습니까?");
    }

    if (ans == true) {

      mAjax(sUrl, params, "POST", true, function(data) {
        if(data.resultCode == "0000") {
          if (<%=request.getParameter("OLD_BK_DAY") != null%>) {
            alert("변경 완료되었습니다.");
          } else {
            alert("예약 완료되었습니다.");
          }
          location.href = "/reservation/reserCheck"
        } else {
          alert(data.resultMessage);
          location.href = "/reservation/reserCheck"
        }
      });

    }
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
            <li class="on" onclick="location.href='/reservation/reservation'">실시간예약</li>
            <li class="" onclick="location.href='/reservation/reserCheck'">예약확인/취소</li>
            <li class="homeBox"><img src="/images/home.jpg" alt="">&nbsp; 인터넷예약 &nbsp;<img src="/images/mini_arw.jpg" alt="">&nbsp; 실시간예약</li>
        </ul>
    </div>
    <div class="contents">
        <div class="monthWrap">
            <div class="monthBox" id="calendarBox1">
                <div class="month" id="calHeader"></div>
                <table class="calendar">
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
                    <!-- no, choice -->
                    <tbody id="calBody">
                    </tbody>
                </table>

            </div>
            <div class="monthBox" id="calendarBox2">
                <div class="month" id="calHeader"></div>
                <table class="calendar">
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
        <div class="padding30"></div>
        <div class="borderBox" id="scrollerLine">
            <ul class="memberInfo">
                <li>• 예약자 : <span class="bold"><%=session.getAttribute("MS_NAME")%></span></li>
                <li>• 예약일자 : <span class="bold" id="txtChooseDate">예약일자를 선택해 주세요.</span></li>
            </ul>

            <ul class="reserCourseTab" id="cosContainer">
                <li onclick="changeTabCos('All');" id="cosAll" class="on">전체코스</li>
                <li onclick="changeTabCos('A');" id="cosA">샤인</li>
                <li onclick="changeTabCos('B');" id="cosB">포도</li>
                <li onclick="changeTabCos('C');" id="cosC">자두</li>
            </ul>

            <table class="reserTable">
                <caption>예약테이블</caption>
                <colgroup>
                    <col width="15%">
                    <col width="15%">
                    <col width="20%">
                    <col width="20%">
                    <col width="10%">
                    <col width="20%">
                </colgroup>
                <thead>
                <tr>
                    <th>예약시간</th>
                    <th>예약코스</th>
                    <th>정상그린피</th>
                    <th>할인그린피</th>
                    <th>캐디여부</th>
                    <th>예약신청</th>
                </tr>
                </thead>
                <tbody id="tbody">
                </tbody>
            </table>
        </div>

        <a href="#" class="calBtn"><img src="/images/calImg01.png" alt=""> 달력보기</a>
    </div><!-- contents End-->

</div>	<!-- wrap End -->
<%@ include file="../include/footer.jsp" %>
