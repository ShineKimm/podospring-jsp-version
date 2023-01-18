<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<script type="text/javascript">

  let smYear, smMonth, fmYear, fmMonth;
  let stDate, fnDate;
  let rows;

  $(document).ready(function() {
    init();
  });

  function init() {

    let date = new Date();
    let date2 = new Date();
    date.setMonth(date.getMonth())
    date2.setMonth(date2.getMonth())
    smYear = fmYear = date.yyyy();
    smMonth = date.mm();
    fmMonth = date2.mm();

    $("#show_hideSub1").html(String.format("{0}/{1}/{2}", date.yyyy(), date.mm(), date.dd()));
    $("#show_hideSub2").html(String.format("{0}/{1}/{2}", date2.yyyy(), date2.mm(), date2.dd()));

    initSubCalendar("#subMonthBox1", smYear, smMonth);
    initSubCalendar("#subMonthBox2", fmYear, fmMonth);

    $("#show_calendar1").click(function () {
      $("#subMonthBox1").slideToggle();
      $("#subMonthBox2").slideUp();
    });

    $("#show_calendar2").click(function () {
      $("#subMonthBox2").slideToggle();
      $("#subMonthBox1").slideUp();
    });

    stDate = date.yyyymmdd();
    fnDate = date2.yyyymmdd();

    doSearch();
  }

  function initSubCalendar(selector, year, month) {
    let rows = getCalendar(year, month);

    $(selector + " #calHeader").html(year + " / " + month);

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
      $("#show_hideSub1").html(String.format("{0}/{1}/{2}", date.yyyy(), date.mm(), date.dd()));
      $("#subMonthBox1").slideToggle();
    } else if(div == "finish") {
      fnDate = sDate;
      $("#show_hideSub2").html(String.format("{0}/{1}/{2}", date.yyyy(), date.mm(), date.dd()));
      $("#subMonthBox2").slideToggle();
    }
  }

  function doSearch() {
    let sUrl = "/controller/MemberController";
    let params = {};

    //params["method"] = "getScoreRank";
    params["coDiv"] = globals.coDiv;
    params["stDate"] = stDate;
    params["edDate"] = fnDate;

    mAjax(sUrl, params, "POST", true, function(data) {
      if(data.resultCode = "0000") {
        rows = data.rows;

        let tbody = $("#tbody");
        tbody.empty();

        if (rows.length == 0) {
          let tr = $("<tr></tr>");
          let td = "<td colspan='8'>스코어 조회 정보가 없습니다.</td>";
          tr.append(td);
          tbody.append(tr);
        }

        let j = 1;

        for(i=0; i<rows.length; i++) {
          let bkDay = rows[i].EN_DAY;
          bkDay = bkDay.substring(0, 4) + "." + bkDay.substring(4, 6) + "." + bkDay.substring(6, 8);
          let bkTime = rows[i].EN_TIME;
          bkTime = bkTime.substring(0, 2) + ":" + bkTime.substring(2, 4);
          let bkName = rows[i].EN_NAME;
          bkName = bkName.substring(0, 1) + "*" + bkName.substring(2, 10);
          let totalScore = rows[i].MS_POINT_A_TOTAL + rows[i].MS_POINT_B_TOTAL

          let tr = $("<tr></tr>");
          let td1 = $("<td>" + j + "</td>");
          let td2 = $("<td>" + bkDay + "</td>");
          let td3 = $("<td>" + bkTime + "</td>");
          let td4 = $("<td>" + bkName + "</td>");
          let td5 = $("<td>" + rows[i].EN_SEX + "</td>");
          let td6 = $("<td>" + rows[i].MS_LAST_PHONE1 + "</td>");
          let td7 = $("<td>" + rows[i].MS_POINT_A_TOTAL + "</td>");
          let td8 = $("<td>" + rows[i].MS_POINT_B_TOTAL + "</td>");
          let td9 = $("<td>" + totalScore + "</td>");

          tr.append(td1,td2,td3,td4,td5,td6,td7,td8,td9).appendTo(tbody);

          j = j + 1
        }
      } else {
        alert(data.resultMessage);
      }
    });
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
            <li class="" onclick="location.href='/board/honor'">홀인원</li>
            <li class="" onclick="location.href='/reservation/joinList'">조인게시판</li>
            <li class="on" onclick="location.href='/board/score'">스코어조회</li>
            <li class="" onclick="location.href='/board/list?type=7'">명예의 전당</li>
            <li class="homeBox"><img src="/images/home.jpg" alt="">&nbsp; 정보마당 &nbsp;<img src="/images/mini_arw.jpg" alt="">&nbsp; 스코어조회</li>
        </ul>
    </div>
    <div class="contents">
        <div class="borderBox">
            <div class="guideTxt padding20">
                <span class="bold title2">"The Challenge 80" Score Ranking</span>
            </div>
            <div class="searchBlackBox">
                <span class="white">조회기간</span>
                <div class="reser_search w180" id="calContainer1">
                    <b id="show_hideSub1"></b>
                    <span class="choiceCalendar2"><img src="/images/img_c.png" id="show_calendar1"></span>
                    <div class="openCalendar2" id="subMonthBox1">
                        <div class="smallCalendarTit">
                            <p class="arwl"><a href="javascript:smPrevMonth();"><img src="/images/btn_ml.png" alt="전달"></a></p>
                            <h3 id="calHeader"></h3>
                            <p class="arwr"><a href="javascript:smNextMonth();"><img src="/images/btn_mr.png" alt="다음달"></a></p>
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
                <div class="reser_search w180" id="calContainer2">
                    <b id="show_hideSub2"></b>
                    <span class="choiceCalendar3"><img src="/images/img_c.png" id="show_calendar2"></span>
                    <div class="openCalendar3" id="subMonthBox2">
                        <div class="smallCalendarTit">
                            <p class="arwl"><a href="javascript:fmPrevMonth();"><img src="/images/btn_ml.png" alt="전달"></a></p>
                            <h3 id="calHeader"></h3>
                            <p class="arwr"><a href="javascript:fmNextMonth();"><img src="/images/btn_mr.png" alt="다음달"></a></p>
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
                <a href="javascript:doSearch()" class="btn_Ok1"> 검색</a>
            </div>
            <p class="score-text red">※ 시상품 지급(추후 연락 및 본인 일치 여부 확인)을 위해 사전 사이버회원에 가입부탁드립니다. </p>
            <table class="guideTable">
                <colgroup>
                    <col>
                    <col>
                    <col>
                    <col>
                    <col>
                    <col>
                    <col>
                </colgroup>
                <thead>
                <tr>
                    <th scope="col">순위</th>
                    <th scope="col">내장일자</th>
                    <th scope="col">시간</th>
                    <th scope="col">성명</th>
                    <th scope="col">성별</th>
                    <th scope="col">4자리</th>
                    <th scope="col">전반 Score</th>
                    <th scope="col">후반 Score</th>
                    <th scope="col">합계</th>
                </tr>
                </thead>
                <tbody id="tbody">
                </tbody>
            </table>

            <div class="score-box">
                <div class="gray-bg-box">
                    <h2>골프야 놀자~ The Challenge 80은 이래서 재미있습니다.</h2>
                    <p>예선 순위가 왕중왕전에 출전할 수 있는 최종 144명의 엔트리에 포함되지 않을 경우 결선일 1주일 전까지 언제든 재도전해 랭킹을 끌어올릴 수 있습니다.</p>
                </div>

                <div class="score-text text-type01"><span class="darkblue">1. 'The Challenge 80'은 순수 아마추아만 참가할 수 있습니다.</span>
                    2. 예선전 통과 후 왕중왕전(결선) 진출의 최종 참가 여부는 개인별로 안내 예정입니다.
                    (※본인의 의사가 확인되지 않을 경우 왕중왕전 참가가 제한될 수 있습니다.)
                    3. 개인정보보호를 위해 성명 일부를 "*"(asterisk)로 표기합니다.
                    4. 숫자 4자리는 동명인과 구별하기 위해 휴대폰 번호 뒤 4자리를 명기합니다.
                    (※원활한 연락을 위해 사전 사이버 회원에 가입 부탁드립니다.)
                    5. 예선 순위는 스트로크플레이로 집계하며, 동타시 백카운트 방식으로 산정해 자동 반영됩니다.
                    6. 예선 순위에 기록을 원하지 않는 고객님께서는 경기팀(아래참조)으로 연락 부탁드립니다.
                    7. 기본적으로 예선 순위 집계는 전일까지 참가자 스코어를 반영하며, 다른 미반영 참가자의 스코어를 감안해 익일 오전 10시에 <span class="darkblue">랭킹</span>을 업데이트합니다. (※1일 1회 Update 원칙)
                    <span class="darkblue">8. 부정행위 발견이나 적발시 자동 실격 처리되며, 예선 및 왕중왕전 순위 집계에서 삭제됩니다.
9. 천재지변 등 불가항력적인 사유로 경기가 임의 취소되거나 플레이어 본인 때문에 정상적으로  홀아웃(18홀)이 안된 경우에는 다시 도전할 수 있습니다.
10. 1, 2부 셀프팀, 3부 팀은 'The Challenge 80' 이벤트 대상에서 제외합니다.
	11. KPGA•KLPGA 등의 등록 회원은 참가 대상에서 제외합니다.</span>
                    12. Mobile 및 PC를 통해 포도CC 홈페이지(www.podocc.com)로 접속하면 언제든지 랭킹 조회가 가능합니다.
                    13. 기타 자세한 내용에 대해서는 홈페이지를 공지사항을 참고하시거나 경기팀로 문의 바랍니다.

                    &lt;문의사항&gt;
                    *경기팀: 054-420-0200 (내선 #3)
                </div>
            </div>
        </div>
    </div><!-- contents End-->

</div>	<!-- wrap End -->
<%@ include file="../include/footer.jsp" %>
