<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<script src="https://unpkg.com/axios/dist/axios.min.js" defer></script>
<script type="text/javascript">

  let smYear, smMonth, fmYear, fmMonth;
  let stDate, fnDate;
  let rows;
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
      location.href = "/member/login";
      return;
    }

    doSearch();
  }

  function initSubCalendar(selector, year, month) {
    let rows = getCalendar(year, month);

    $(selector + " #calHeader").html(year + "년  " + month + "월");

    let tBody = $(selector + " #calendar-body");
    tBody.empty();

    let row = $("<tr></tr>");

    let fWeek = rows[0].week - 1;

    for(i=0; i<fWeek; i++) {
      row.append($("<td><div></div></td>"));
    }

    for(i=0; i<rows.length; i++) {
      let td = $("<td><div>" + rows[i].day + "</div></td>");

      if(rows[i].date == new Date().yyyymmdd()) {
        td.addClass('today');
      }

      td.addClass('possible');
      td.data('date', rows[i].date);
      if(selector == "#subMonthBox1"){
        td.data("div", "start");
      } else {
        td.data("div", "finish");
      }
      td.on('click', function() {
        onClickMiniDay($(this).data('div'), $(this).data('date'));
      });

      row.append(td);

      if(rows[i].week == 7) {
        row.appendTo(tBody);
        row = $("<tr></tr>");
      }
    }

    row.appendTo(tBody);
  }

  function doSearch() {
    let sUrl = "/getReservationList";
    let params = {};

    //params["method"] = "getReservationList";
    params["coDiv"] = globals.coDiv;
    params["msNum"] = <%=session.getAttribute("MS_NUM")%>;

    mAjax(sUrl, params, "POST", true, function(data) {
      if(data.resultCode == "0000") {
        let tBody = $("#tbody");
        tBody.empty();

        rows = data.rows;

        if(rows.length == 0) {
          tBody.append("<tr><td colspan='9'>조회되는 예약건이 없습니다. </td></tr>");
        }

        for(i=0; i<rows.length; i++) {
          let row = $("<tr></tr>");

          let bkDate = rows[i].BK_DAY;
          bkDate = bkDate.substring(2, 4) + "." + bkDate.substring(4, 6) + "." + bkDate.substring(6, 8);
          let bkTime = rows[i].BK_TIME;
          bkTime = bkTime.substring(0, 2) + ":" + bkTime.substring(2, 4);
          let cancelDiff = rows[i].CANCEL_DIFF;
          let cancelYn = "Y";

          if(cancelDiff < 5) {
            cancelYn = "N";
          }
          if(cancelDiff == 5 && new Date().getHours() >= 17 ) {
            cancelYn = "N";
          }

          let col1 = $("<td>" + (i + 1) + "</td>");
          let col2 = $("<td>" + bkDate + "</td>");
          let col3 = $("<td>" + bkTime + "</td>");
          let col4 = $("<td>" + rows[i].BK_COS_NM + "코스</td>");
          let col5 = $("<td>" + rows[i].BK_ROUNDF + "</td>");
          let col6 = $("<td>" + rows[i].BK_CADDY + "</td>");
          let col7 = $("<td>" + rows[i].BK_FIRST_PHONE1 + "-" +  rows[i].BK_MID_PHONE1 + "-" +  rows[i].BK_LAST_PHONE1 + "</td>");
          let col8 = "";
          if (rows[i].AFTER_YN == "Y") {
            if (cancelYn == "Y") {
              col8 = $("<td><input type='button' value='예약변경' class='deepBlueBtn' onclick='changeReservation(" + i + ")'> <input type='button' value='취소' class='lightGrayBtn' onclick='doDeleteReservation(" + i + ")'></td>");
            } else {
              col8 = $("<td><input type='button' value='예약변경' class='deepBlueBtn' onclick='cantChange()'> <input type='button' value='취소' class='lightGrayBtn' onclick='cantCancel()'></td>");
            }
          } else {
            col8 = $("<td><input type='button' value='완료' class='lightGrayBtn'></td>");
          }

          row.append(col1,col2,col3,col4,col5,col6,col7,col8).appendTo(tBody);
        }
      } else {
        alert(data.resultMessage);
      }
    });
  }

  function cantCancel() {
    alert("해당 예약은 위약일자에 포함되는 예약으로 취소가 불가능합니다.");
  }

  function cantChange() {
    alert("해당 예약은 위약일자에 포함되는 예약으로 예약변경이 불가능합니다.");
  }
    //TODO 사용안하는 기능 (구현된 기능 없음) 확인필요
  function blDeleteReservation(i) {

    ans = confirm("[위약 확인] 해당건은 위약 일자에 포함되는 건으로 취소시 위약이 발생합니다. 취소를 진행 하시겠습니까?");

    if (ans == true) {

      let sUrl = "/blDeleteReservation";
      let params = {};

      //params["method"] = "blDeleteReservation";
      params["coDiv"] = globals.coDiv;
      params["msNum"] = <%=session.getAttribute("MS_NUM")%>;
      params["day"] = rows[i].BK_DAY;
      params["cos"] = rows[i].BK_COS;
      params["time"] = rows[i].BK_TIME;
      params["remain"] = rows[i].REMAINDAY;

      mAjax(sUrl, params, "POST", true, function(data) {
        if(data.resultCode == "0000") {
          alert("취소 되었습니다.")

          doSearch();
        } else {
          alert(data.resultMessage);
        }
      });

    } else {
      return;
    }
  }

  function doDeleteReservation(i) {

    let bkDate = rows[i].BK_DAY;
    bkDate = bkDate.substring(2, 4) + "." + bkDate.substring(4, 6) + "." + bkDate.substring(6, 8);
    let bkTime = rows[i].BK_TIME;
    bkTime = bkTime.substring(0, 2) + ":" + bkTime.substring(2, 4);

    ans = confirm("[취소 확인] <%=session.getAttribute("MS_NAME")%> 회원님. \r\n" + bkDate + " " + bkTime + " " + rows[i].BK_COS_NM + "코스 취소를 진행 하시겠습니까?");

    if (ans == true) {

      let sUrl = "/cancelReservation";
      let params = {};

      //params["method"] = "cancelReservation";
      params["coDiv"] = globals.coDiv;
      params["msNum"] = <%=session.getAttribute("MS_NUM")%>;
      params["day"] = rows[i].BK_DAY;
      params["cos"] = rows[i].BK_COS;
      params["time"] = rows[i].BK_TIME;
      if (getIP) {
        params["ip"] = getIP;
      }

      mAjax(sUrl, params, "POST", true, function(data) {
        if(data.resultCode == "0000") {
          alert("취소 되었습니다.")

          doSearch();
        } else {
          alert(data.resultMessage);
        }
      });

    } else {
      return;
    }
  }

  function changeReservation(i) {
    $("#BK_DAY").val(rows[i].BK_DAY);
    $("#BK_COS").val(rows[i].BK_COS);
    $("#BK_COS_NM").val(rows[i].BK_COS_NM);
    $("#BK_TIME").val(rows[i].BK_TIME);
    $("#BK_NAME").val(rows[i].BK_NAME);
    $("#BK_ROUNDF").val(rows[i].BK_ROUNDF);
    $("#form_change").submit();

  }

  function smNextMonth() {
    if(smMonth == "12") {
      smYear += 1;
      smMonth = "01";
    } else {
      smMonth = Number(smMonth) + 1;
      smMonth = (smMonth>9 ? '' : '0') + smMonth;
    }

    initSubCalendar("#subMonthBox1", smYear, smMonth);
  }

  function smPrevMonth() {
    if(smMonth == "01") {
      smYear -= 1;
      smMonth = "11";
    } else {
      smMonth = Number(smMonth) - 1;
      smMonth = (smMonth>9 ? '' : '0') + smMonth;
    }

    initSubCalendar("#subMonthBox1", smYear, smMonth);
  }

  function fmNextMonth() {
    if(fmMonth == "12") {
      fmYear += 1;
      fmMonth = "01";
    } else {
      fmMonth = Number(fmMonth) + 1;
      fmMonth = (fmMonth>9 ? '' : '0') + fmMonth;
    }

    initSubCalendar("#subMonthBox2", fmYear, fmMonth);
  }

  function fmPrevMonth() {
    if(fmMonth == "01") {
      fmYear -= 1;
      fmMonth = "11";
    } else {
      fmMonth = Number(fmMonth) - 1;
      fmMonth = (fmMonth>9 ? '' : '0') + fmMonth;
    }

    initSubCalendar("#subMonthBox2", fmYear, fmMonth);
  }

  function onClickMiniDay(div, sDate) {
    let date = getDateFormat(sDate);

    if(div == "start") {
      stDate = sDate;
      $("#txtStDate").html(String.format("{0}/{1}/{2}", date.yyyy(), date.mm(), date.dd()));
      $("#subMonthBox1").slideToggle();
    } else if(div == "finish") {
      fnDate = sDate;
      $("#txtEdDate").html(String.format("{0}/{1}/{2}", date.yyyy(), date.mm(), date.dd()));
      $("#subMonthBox2").slideToggle();
    }
  }

</script>

<form id="form_change" action="/reservation/reservation" method="post">
    <input type="hidden" name="OLD_BK_DAY" 				id="BK_DAY" >
    <input type="hidden" name="OLD_BK_COS" 				id="BK_COS" >
    <input type="hidden" name="OLD_BK_COS_NM" 			id="BK_COS_NM" >
    <input type="hidden" name="OLD_BK_TIME" 			id="BK_TIME" >
    <input type="hidden" name="OLD_BK_NAME" 			id="BK_NAME" >
    <input type="hidden" name="OLD_BK_ROUNDF" 			id="BK_ROUNDF" >
</form>

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
            <li class="" onclick="location.href='/reservation/reservation'">실시간예약</li>
            <li class="on" onclick="location.href='/reservation/reserCheck'">예약확인/취소</li>
            <li class="homeBox"><img src="/images/home.jpg" alt="">&nbsp; 인터넷예약 &nbsp;<img src="/images/mini_arw.jpg" alt="">&nbsp; 예약확인/취소</li>
        </ul>
    </div>
    <div class="contents">
        <!--<div class="borderBox">
            <div class="calendarSerchBox">
                <span class="white">조회기간</span>
                <div class="reser_search w180" id="show_hideSub1">
                    <txt id="txtStDate" style="margin-top:4px;display:inline-block;"></txt>
                    <span class="choiceCalendar"><img src="/images/cal_icon.png"></span>
                    <div class="openCalendar" id="subMonthBox1">
                        <div class="smallCalendarTit">
                            <p class="arwl"><a href="javascript:smPrevMonth()"><img src="/images/btn_ml.png" alt="전달"></a></p>
                            <h3 id="calHeader"></h3>
                            <p class="arwr"><a href="javascript:smNextMonth()"><img src="/images/btn_mr.png" alt="다음달"></a></p>
                        </div>
                        <table class="sCalendar">
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
                            <tbody id="calendar-body">
                            </tbody>
                        </table>
                    </div>
                </div>
                <span class="white">~</span>
                <div class="reser_search w180" id="show_hideSub2">
                    <txt id="txtEdDate" style="margin-top:4px;display:inline-block;"></txt>
                    <span class="choiceCalendar2"><img src="/images/cal_icon.png"></span>
                    <div class="openCalendar2" id="subMonthBox2">
                        <div class="smallCalendarTit">
                            <p class="arwl"><a href="javascript:fmPrevMonth()"><img src="/images/btn_ml.png" alt="전달"></a></p>
                            <h3 id="calHeader"></h3>
                            <p class="arwr"><a href="javascript:fmNextMonth()"><img src="/images/btn_mr.png" alt="다음달"></a></p>
                        </div>
                        <table class="sCalendar">
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
                            <tbody id="calendar-body">
                            </tbody>
                        </table>
                    </div>
                </div>
                <a href="javascript:doSearch()" class="deepBlueBtn commonBtn"><img src="/images/search.png" alt=""></a>
            </div>-->

        <div class="commonTitle">실시간예약현황</div>
        <table class="reserTable" summary="예약확인" width="100%">
            <caption>예약확인</caption>
            <colgroup>
                <col width="10%">
                <col width="12%">
                <col width="12%">
                <col width="10%">
                <col width="10%">
                <col width="11%">
                <col width="15%">
                <col width="20%">
            </colgroup>
            <thead>
            <tr>
                <th class="col">No</th>
                <th class="col">예약일</th>
                <th class="col">시간</th>
                <th class="col">코스</th>
                <th class="col">홀</th>
                <th class="col">캐디여부</th>
                <th class="col">핸드폰</th>
                <th class="col">취소/변경</th>
            </tr>
            </thead>
            <tbody id="tbody">
            </tbody>
        </table>

        <div class="padding30"></div>

        <!--<div class="commonTitle">추첨예약접수 현황</div>
        <table class="reserTable" summary="추첨예약접수 현황" width="100%">
            <caption>추첨예약접수 현황</caption>
            <colgroup>
                <col width="15%">
                <col width="15%">
                <col width="12%">
                <col width="13%">
                <col width="15%">
                <col width="15%">
                <col width="15%">
            </colgroup>
            <thead>
                  <tr>
                    <th class="col">No</th>
                    <th class="col">희망일자</th>
                    <th class="col">희망시간1</th>
                    <th class="col">희망시간2</th>
                    <th class="col">핸드폰</th>
                    <th class="col">상태</th>
                    <th class="col">취소</th>
                  </tr>
            </thead>
            <tbody id="tbody-reservation">
                <tr>
                    <td>01</td>
                    <td>21.02.04</td>
                    <td>09:00</td>
                    <td>09:10</td>
                    <td>01099990000</td>
                    <td>진행중</td>
                    <td><input type="button" value="취소" class="lightGrayBtn"></td>
                </tr>
                <tr>
                    <td colspan="7">조회되는 예약건이 없습니다. </td>
                </tr>
            </tbody>
        </table>-->
    </div>
</div><!-- contents End-->

</div>	<!-- wrap End -->
<%@ include file="../include/footer.jsp" %>
