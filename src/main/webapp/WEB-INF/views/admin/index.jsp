<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="./include/header.jsp" %>
<script>
  $(document).ready(function() {
    init();
  });

  function init() {
    let sUrl = "/getMainData";
    let params = {};

    mAjax(sUrl, params, "GET", true, function(data) {
      if(data.resultCode == "0000") {
        let connect = data.connect;
        let member = data.member;

        let tr = $("<tr></tr>");
        let td1 = $("<td>WEB : " + connect[0].S_WEB_CNT + "</td>");
        let td2 = $("<td>WEB : " + connect[1].S_WEB_CNT + "</td>");
        let td3 = $("<td>WEB : " + connect[2].S_WEB_CNT + "</td>");
        $("#tbody_connect").append(tr.append(td1, td2, td3));

        tr = $("<tr></tr>");
        td1 = $("<td>MOBILE : " + connect[0].S_MOBILE_CNT + "</td>");
        td2 = $("<td>MOBILE : " + connect[1].S_MOBILE_CNT + "</td>");
        td3 = $("<td>MOBILE : " + connect[2].S_MOBILE_CNT + "</td>");
        $("#tbody_connect").append(tr.append(td1, td2, td3));

        tr = $("<tr></tr>");
        td1 = $("<td>ANDROID : " + connect[0].S_ANDROID_CNT + "</td>");
        td2 = $("<td>ANDROID : " + connect[1].S_ANDROID_CNT + "</td>");
        td3 = $("<td>ANDROID : " + connect[2].S_ANDROID_CNT + "</td>");
        $("#tbody_connect").append(tr.append(td1, td2, td3));

        tr = $("<tr></tr>");
        td1 = $("<td>IOS : " + connect[0].S_IOS_CNT + "</td>");
        td2 = $("<td>IOS : " + connect[1].S_IOS_CNT + "</td>");
        td3 = $("<td>IOS : " + connect[2].S_IOS_CNT + "</td>");
        $("#tbody_connect").append(tr.append(td1, td2, td3));

        tr = $("<tr></tr>");
        td1 = $("<td>" + member[0].CNT + "</td>");
        td2 = $("<td>" + member[1].CNT + "</td>");
        td3 = $("<td>" + member[2].CNT + "</td>");
        $("#tbody_member").append(tr.append(td1, td2, td3));

      } else {
        alert(data.resultMessage);
      }
    });
  }
</script>

<div id="wrap">
    <ul class="gnb">
        <div class="content">
            <li class="on"><a href="/admin/index">HOME</a></li>
            <li class=""><a href="/admin/board/list?type=1">게시판 관리</a></li>
        </div>
    </ul>

    <div class="content">
        <div class="cate_title">관리자 메인</div>
        <!-- 컨텐츠 시작 -->
        <div class="start"> <br>
            <div class="pop">
                <h2> 접속현황 (<a href="selDay">기간별 방문자 조회하기</a>)</h2>
                <table id="" width="100%" border="0" cellspacing="0" cellpadding="0" summary="기본관리">
                    <caption>
                        기본관리
                    </caption>
                    <colgroup>
                        <col width="33%">
                        <col width="33%">
                        <col width="34%">
                    </colgroup>
                    <thead>
                    <tr>
                        <th>오늘 방문자 수</th>
                        <th>어제 방문자 수</th>
                        <th>전체 방문자 수</th>
                    </tr>
                    </thead>
                    <tbody id="tbody_connect"></tbody>
                </table>
            </div>
            <div style="height:20px;"></div>
            <div class="pop">
                <h2>회원가입 현황</h2>
                <table width="100%" border="0" cellspacing="0" cellpadding="0" summary="기본관리">
                    <caption>
                        기본관리
                    </caption>
                    <colgroup>
                        <col width="33%">
                        <col width="33%">
                        <col width="34%">
                    </colgroup>
                    <thead>
                    <tr>
                        <th>오늘 회원가입 수</th>
                        <th>어제 회원가입 수</th>
                        <th>전체 회원가입 수</th>
                    </tr>
                    </thead>
                    <tbody id="tbody_member"></tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<%@ include file="./include/footer.jsp" %>