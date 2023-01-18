<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%=(String)session.getAttribute("USER_STAFF")%>
<!DOCTYPE>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>포도CC 관리자</title>

    <link href="/admin/css/style.css" rel="stylesheet" type="text/css">

    <script src='https://cdnjs.cloudflare.com/ajax/libs/jquery/3.1.1/jquery.min.js'></script>
    <script src="/js/globals.js"></script>
    <script src="/js/tools.js"></script>
    <script src="/js/jquery.preloaders.js"></script>

    <script>
      $(document).ready(function() {
        let staff = "<%=(String)session.getAttribute("USER_STAFF")%>";

        if(staff == "") {
          location.href = "/admin/member/login";
        }
        if (<%=session.getAttribute("USER_STAFF") == null %>) {
          $("#logoutHide").hide(); // display 속성을 none 으로 바꾼다.
        } else {
          $("#logoutHide").show();
        }
      });

      function doLogout() {
        let sUrl = "/adminDoLogout";
        let params = {};

        // params["method"] = "doLogout";

        mAjax(sUrl, params, "POST", true, function(data) {
          if(data.resultCode == "0000") {
            alert("로그아웃 되었습니다.");
            location.href = "/admin/member/login"
          }
        });
      }
    </script>
</head>

<body>
<div id="header">
    <div class="content">
        <div class="logo">포도CC 관리자</div>
        <ul class="member" id="logoutHide">
            <li><a href="/index" target="_blank"><font color="white">홈페이지</font></a></li>
            <li>|</li>
            <li><a href="javascript:doLogout()"><font color="white">로그아웃</font></a></li>
        </ul>
    </div>
</div>
