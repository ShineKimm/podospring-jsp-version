<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<script>

  let stYear, stMonth;
  let edYear, edMonth;

  $(document).ready(function(data) {
    init();
  });

  function init() {
    if(<%=session.getAttribute("MS_NUM") == null %>) {
      alert("로그인 후 이용 가능합니다.");
      location.href = "/member/login?page=/reservation/joinCal";
      return;
    }

    let date = new Date();
    stYear = date.yyyy();
    stMonth = date.mm();
    let date2 = addMonth(date.yyyymmdd(), 1);
    edYear = date2.yyyy();
    edMonth = date2.mm();

    initCalendar("#calContainer1", stYear, stMonth);
    initCalendar("#calContainer2", edYear, edMonth);
  }

  function initCalendar(selector, year, month) {
    let sUrl = "/getJoinCalendar";
    let params = {};

    //params["method"] = "getJoinCalendar";
    params["coDiv"] = globals.coDiv;
    params["selYm"] = year + month;

    mAjax(sUrl, params, "POST", true, function(data) {
      if(data.resultCode == "0000") {
        $(selector + " #calHeader").html(Number(month));

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

            if(rows[i].CL_SOLAR == currentDay) {
              td.addClass('today');
            } else if(rows[i].CL_SOLAR > currentDay) {
              let team1 = rows[i].TEAM_CNT_1;
              let team2 = rows[i].TEAM_CNT_2;

              if(team1 > 0 || team2 > 0) {
                td.data("date", rows[i].CL_SOLAR);
                td.append(String.format("<div class='join'>조인 <span class='red underline bold'>{0}</span><br>초대  <span class='blue underline bold'>{1}</span></div>", team1, team2));
                td.on("click", function(){
                  location.href = "/reservation/joinList?date=" + $(this).data("date")
                });
              }
            } else {
              td.addClass("no");
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
            <ul>
                <li>
                    <a href="/reservation/joinCal" class="cal on"></a>
                    <a href="/reservation/joinList" class="list"></a>
                </li>
            </ul>
            <p>포도CC 및 조인/초대와 관련되지 않은 글 <span class="bold">(비방, 협오, 부킹광고, 기타 조인/초대와 관련되지 않은 글)</span>은<br>
                작성자의 동의없이 임의 삭제될 수 있습니다.</p>
        </div>

        <div class="monthWrap">
            <div class="monthBox" id="calContainer1">
                <h2><text id="calHeader"></text><span>月</span></h2>
                <table class="joinCalendar">
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
            <div class="monthBox" id="calContainer2">
                <h2><text id="calHeader"></text><span>月</span></h2>
                <table class="joinCalendar">
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
    </div><!-- contents End-->

</div>	<!-- wrap End -->
<%@ include file="../include/footer.jsp" %>
