<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko" />
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<meta http-equiv="Content-Type" content="application/xhtml+xml; charset=utf-8" />
<meta name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, minimum-scale=1.0">
<meta name="apple-mobile-web-app-capable" content="no" />
<meta name="apple-mobile-web-app-status-bar-style" content="black" />
<meta name="format-detection" content="telephone=no,email=no,address=no">
<meta name="title" content="포도CC, 포도 컨트리클럽, ">
<meta name="author" content="포도CC">
<meta name="Keywords" content="포도CC, 포도 컨트리클럽, ">
<meta name="description" content="포도CC">
<meta name="copyright" content="All Contents Copyright©Podo Country Club">
<meta property="og:type" content="website">
<meta property="og:title" content="포도CC, 포도 컨트리클럽, ">
<meta property="og:description" content="포도CC, 포도 컨트리클럽, ">
<meta property="og:url" content="">
<link rel="canonical" href="">
<script src='//cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
<link rel="stylesheet" type="text/css" href="/mobile/css/import.css?v=1">
<link rel="stylesheet" type="text/css" href="/mobile/css/animate.css">
<link rel="stylesheet" type="text/css" href="/mobile/css/contents.css?v=2">
<script src="/mobile/js/common.js"></script>
<title>포도CC</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>
<script src="/js/jquery.preloaders.js"></script>
<script src="/js/tools.js"></script>
<script src="/js/globals.js"></script>

<script>		
	$(document).ready(function() { 		
		if(window.location.pathname == "/mobile/index") {
			/*main_top menu*/
			$(window).on("scroll", function() {
				console.log($(window).scrollTop())
				if ($(window).scrollTop() >= 200) {
					$(".topmenuWrap").addClass("white");
				}else {
						$(".topmenuWrap").removeClass("white");	
				}
			});
		} else {
			$("#topmenuWrap").addClass("white2");
			$("#topmenuWrap").removeClass("white");
		}
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

				location.href = "/mobile/index";
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
			// console.log("카운트 추가됨");
		});
	}
</script>
	
</head>
	
<body />
<div id="wrap" />
	<div class="topmenuWrap" id="topmenuWrap" />
		<a href="/mobile/reservation/reservation" class="topReser"></a>
		<a href="/mobile/index" class="logo"></a>
		<a href="https://www.silkrivercc.co.kr/mobile/index.asp" class="country">실크리버</a>
		<input type='checkbox' id='toggle' style='display:none;' />
		<label class='toggle-btn toggle-btn__cross' for='toggle'>
			<div class="bar"></div>
			<div class="bar"></div>
			<div class="bar"></div>
		</label>
		<div class="navBg"></div>
		<nav>
			<div class="topNav">
				<p><a href="/mobile/index"><img src="/mobile/images/logo.svg" class="navlogo"></a></p>
<%--				<%If Session("ms_num") = "" Then%>--%>
<%--				<a href="/mobile/member/login"> 로그인 <span class="arrow arrow-right margin-4"></span></a>--%>
<%--				<%Else%>--%>
<%--				<a href="javascript:doLogout();"> 로그아웃 <span class="arrow arrow-right margin-4"></span></a>--%>
<%--				<%End If%>--%>
			</div>
			<div class="allMenu">
				<h2>전체메뉴</h2>
				<ul>
					<li class="on" onclick="location.href='/mobile/reservation/reservation'"><p><img src="/mobile/images/calendar_w.svg"></p>인터넷예약</li>
					<li onclick="location.href='/mobile/club/intro'"><p><img src="/mobile/images/m_icon1.svg"></p>클럽소개</li>
					<li onclick="location.href='/mobile/guide/guide'"><p><img src="/mobile/images/m_icon2.svg"></p>이용안내</li>
				</ul>
				<ul>
					<li onclick="location.href='/mobile/course/intro'"><p><img src="/mobile/images/m_icon3.svg"></p>코스소개</li>
					<li onclick="location.href='/mobile/facil/clubhouse'"><p><img src="/mobile/images/m_icon4.svg"></p>시설안내</li>
					<li onclick="location.href='/mobile/board/list?type=1'"><p><img src="/mobile/images/m_icon5.svg"></p>정보마당</li>
				</ul>
			</div>
			<div class="allMenuText">
				<h2>‘안녕하세요 회원님 즐거운 라운딩 되시길 바랍니다’</h2>
				<h3>포도CC는 고객님의 즐거운 라운딩을 위해 최선을 다하겠습니다.<br>
				포도CC 회원만의 다양한 혜택이 준비되어 있습니다.</h3>
			</div>
			<div class="allMenuBtn">
<%--				<%If Session("ms_num") = "" Then%>--%>
<%--				<a href="/mobile/member/join01">회원가입</a>--%>
<%--				<%Else%>--%>
<%--				<a href="/mobile/member/modify">회원정보</a>--%>
<%--				<%End If%>--%>
				<a href="http://www.weather.go.kr/weather/forecast/timeseries.jsp?searchType=INTEREST&wideCode=4100000000&cityCode=4165000000&dongCode=4165052000">날씨안내</a>
			</div>			
		</nav>
		<div class="mborder"></div>
	</div>