<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String IS_MOBILE = "MOBI";
    String IS_PC = "PC";
    String agent = request.getHeader("User-Agent").toUpperCase();
    if(agent.indexOf(IS_MOBILE) > -1) {
        response.sendRedirect("/mobile/index");
    }
%>
<!DOCTYPE html>
<html lang="ko" />
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="user-scalable=yes, initial-scale=0.3, maximum-scale=1.0, minimum-scale=0.1, width=device-width" />
    <meta name="title" content="">
    <meta name="author" content="포도CC">
    <meta name="Keywords" content="포도CC, 포도 컨트리클럽, ">
    <meta name="description" content="포도CC, 포도 컨트리클럽, ">
    <meta name="copyright" content="All Contents Copyright©pineBeach">
    <meta name="format-detection" content="telephone=no, address=no, email=no"/>
    <meta property="og:type" content="mobile">
    <meta property="og:title" content="포도CC, 포도 컨트리클럽">
    <meta property="og:description" content="포도CC, 포도 컨트리클럽">
    <meta property="og:url" content="">
    <title>포도 컨트리클럽</title>
    <link rel="stylesheet" type="text/css" href="/css/import.css">
    <link rel="stylesheet" type="text/css" href="/css/content.css?v=2">

    <link rel="stylesheet" type="text/css" href="/css/slick.css"/>
    <link rel="stylesheet" type="text/css" href="/css/slick-theme.css"/>

    <script type="text/javascript" src="/js/jquery.js"></script>
    <script type="text/javascript" src="/js/slick.js"></script>


    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
    <script type="text/javascript" src="/js/common.js"></script>
    <script src="/js/jquery.preloaders.js"></script>
    <script src="/js/tools.js"></script>
    <script src="/js/globals.js"></script>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
    <link rel="stylesheet" type="text/css" href="/css/motion.css">
    <link rel="stylesheet" type="text/css" href="/css/animate.css">
    <script src="/js/wow.js"></script>
    <script type="text/javascript">
      /* 컨텐츠 fade in */
      wow = new WOW(
          {
            boxClass: 'fadeBox',
            animateClass: 'animated',
            offset: 100,
            callback: function(box) {
              //console.log("WOW: animating <" + box.tagName.toLowerCase() + ">")
            }
          });
      wow.init();
      /*//컨텐츠 fade in */

      $(document).ready(function() {
        //setProtocol();
        sessionCheck();
        deviceIdentification();
      });

      function doLogout() {
        let sUrl = "/doLogout";
        let params = {};

        //params["method"] = "doLogout";

        mAjax(sUrl, params, "POST", true, function(data) {
          if(data.resultCode == "0000") {
            alert("로그아웃 되었습니다.");

            location.href = "/index";
          }
        });
      }

      function setProtocol() {
        if (document.location.protocol == 'http:') {
          document.location.href = document.location.href.replace('http:', 'https:');
        }
      }

      function sessionCheck() {
        let sUrl = "/sessionConfirm";
        let params = {/*"method" : "sessionConfirm"*/};

        mAjax(sUrl, params, "POST", false, function(data) {
          if(data.resultCode == "2000") {
            alert(data.resultMessage);
            location.reload();
          }
        });
      }

      function deleteMember() {

        if(<%=session.getAttribute("MS_NUM") == null %>) {
          alert("로그인 후 이용 가능합니다.");
          location.href = "/members/login";
          return;
        }

        let sUrl = "/doDeleteMemeber";
        let params = {};

        //params["method"] = "doDeleteMemeber";

        let con = confirm("회원님께서 확인 버튼을 누르면 탈퇴가 완료됩니다.\r\n그동안 포도CC를 이용해 주셔서 감사합니다..");
        if(con == true) {
          mAjax(sUrl, params, "POST", true, function(data) {
            if(data.resultCode == "0000") {
              alert("회원 탈퇴 되었습니다.");

              location.href = "/index";
            }
          });
        }
      }
      function deviceIdentification() {
        let web_cnt = "";
        let mobile_cnt = "";
        let android_cnt = "";
        let ios_cnt = "";

        let userAgent = navigator.userAgent.toLowerCase();

        if (userAgent.indexOf("iphone") > -1) {
          web_cnt = 0
          mobile_cnt = 1
          android_cnt = 0
          ios_cnt = 1
        }else if (userAgent.indexOf("android") > -1) {
          web_cnt = 0
          mobile_cnt = 1
          android_cnt = 1
          ios_cnt = 0
        }else{
          web_cnt = 1
          mobile_cnt = 0
          android_cnt = 0
          ios_cnt = 0
        }
        let sUrl = "/deviceIdentification";
        let params = {};

        params["web_cnt"] = web_cnt;
        params["mobile_cnt"] = mobile_cnt;
        params["android_cnt"] = android_cnt;
        params["ios_cnt"] = ios_cnt;

        mAjax(sUrl, params, "POST", true, function(data) {

        });
      }


    </script>
    <!--textmotion-->
    <script src="/js/ScrollTrigger.js"></script>
    <script>
      window.counter = function($) {
        // this refers to the html element with the data-scroll-showCallback tag
        let span = this.querySelector('span');
        let current = parseInt(span.textContent);

        span.textContent = current + 1;
      };

      document.addEventListener('DOMContentLoaded', function($){
        let trigger = new ScrollTrigger({
          addHeight: true
        });
      });
    </script>
    <!-- subTab Fixed js -->
    <script src="//code.jquery.com/jquery-1.12.4.min.js"></script>

    <script src="/js/jquery.preloaders.js"></script>
    <script src="/js/tools.js"></script>
    <script src="/js/globals.js"></script>
</head>
<body />
<div class="siteAll"><div class="toggleMenu"><span></span></div></div>
<div id="header">
    <div class="subHeader">
        <a href="../index" class="logoBox" id="logo"></a>
        <ul class="mainList">
            <li onclick="location.href='/reservation/reservation'">인터넷예약</li>
            <li onclick="location.href='/guide/reserGuide'">이용안내</li>
            <li onclick="location.href='/club/intro'">클럽소개</li>
            <li onclick="location.href='/course/intro'">코스소개</li>
            <li onclick="location.href='/fac/fac01'">시설안내</li>
            <li onclick="location.href='/board/list?type=1'">정보마당</li>
        </ul>
        <%@ include file="../include/submenu.jsp" %>

        <ul class="rightBtn">
            <li class="topJoin">
<%--                <%If Session("MS_NUM") = "" Then%>--%>
<%--                <a href="https://www.serenitycc.co.kr" class="podo">세레니티</a>--%>
<%--                <a href="/member/login" class="topLogin" id="login"></a>--%>
<%--                <%Else%>--%>
<%--                <a href="https://www.serenitycc.co.kr" class="podo">세레니티</a>--%>
<%--                <a href="/member/modify" class="topLogin" id="login"></a>--%>
<%--                <%End If%>--%>

            </li>
        </ul>
    </div>
    <%@ include file="../include/topmenu.jsp" %>
</div>

</div>