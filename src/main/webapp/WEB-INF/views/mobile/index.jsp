<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="./include/header.jsp" %>
<link rel="stylesheet" type="text/css" href="/mobile/css/main.css">
<script>
	let selectType = "1";

	 $(document).ready(function() {
		init();
	 });

	 function init() {
		getMainNotice(1);
	  }

	function getMainNotice(paraType) {


		let sUrl = "/getBoardList";
		let params = {};

		params["method"] = "getBoardList";

		params["coDiv"]    = globals.coDiv;
		params["type"]     = paraType;
		params["startCnt"] = 0;
		params["pageCnt"]  = 3;

		$("#type"+selectType).removeClass("on");
		$("#type"+paraType).addClass("on");

		selectType = paraType;

		mAjax(sUrl, params, "POST", false, function(data) {
			if(data.resultCode == "0000") {

				let rows = data.rows;

				if (rows.length == 0) {

					let notice = ""
				    notice += "<dl>	";
				    notice += " <dt>등록된 글이 없습니다.</dt>";
				    notice += " <dd>-</dd>	";
				    notice += " </dl>	";

				    $("#mainNotice").empty().append(notice);
					return;
				}

				$("#mainNotice").empty();

			    for(i=0; i<rows.length; i++) {

					let notice = ""

					let link = "/mobile/board/view?type=" + rows[i].TYPE + "&idx=" + rows[i].IDX;
					let title = rows[i].TITLE;
					let inputDate = rows[i].INPUT_DATETIME;

				    notice += "<dl onclick=\"location.href='" + link + "'\">	";
				    notice += " <dt>" + title + "</dt>";
				    notice += " <dd>" + inputDate + "</dd>	";
				    notice += " </dl>	";
					$("#mainNotice").append(notice);

			    }
			} else {
				alert(data.resultMessage);
			}
		});
	}

</script>

	<div class="mainWrap">
		<div class="topImgWrap">
			<div class="topImgBox"></div>
			<div class="mTopTextBox">
				<h1>PODO<br>COUNTRY CLUB</h1>
				<h3>For a real Country Club and the real golfers.</h3>
			</div>
		</div>
		<div class="mainBtnWrap">
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
	</div>
	<div class="mainBg">
		<div class="mainSlide">
			<div class="bx-wrapper">
				<ul class="slider">
                   <li><a href="http://www.band.us/@podocc"><img src="/mobile/images/main/220805_밴드_mo.jpg" title="밴드오픈"></a></li>
                   <li><a href="/mobile/board/view?type=2&idx=4"><img src="/mobile/images/main/220719_mo.jpg" title="홀인원이벤트"></a></li>
                    <li><a href="/mobile/board/view?type=1&idx=63"><img src="/mobile/images/main/220627_mo.jpg" title="캐디피인상안내"></a></li>
                    <li><a href="/mobile/board/view?type=1&idx=68"><img src="/mobile/images/main/220808_10월그린피_mo.jpg" title="10월그린피"></a></li>
					<li><a href="/mobile/board/view?type=1&idx=69"><img src="/mobile/images/main/220808_10월패키지_mo.jpg" title="10월1박2일"></a></li>
                    <li><a href="/mobile/board/view?type=1&idx=70"><img src="/mobile/images/main/220808_10월골프대회_mo.jpg" title="10월골프대회"></a></li>
                    <li><a href="/mobile/board/view?type=1&idx=73"><img src="/mobile/images/main/221011_10월골프대회_mo.jpg" title="10월골프대회"></a></li>
                   <li><a href="/mobile/board/view?type=1&idx=71"><img src="/mobile/images/main/220913g_mo.jpg" title="11월그린피"></a></li>
					<li><a href="/mobile/board/view?type=1&idx=72"><img src="/mobile/images/main/220913p_mo.jpg" title="11월1박2일"></a></li>
                    <!--<li><a href="/mobile/board/view?type=1&idx=60"><img src="/mobile/images/main/220620_mo.jpg" title="11월골프대회"></a></li>-->
					<li><a href="/mobile/board/view?type=1&idx=23"><img src="/mobile/images/main/210705_mo.jpg" title="대체공휴일"></a></li>
					<li><a href="/mobile/board/view?type=1&idx=8"><img src="/mobile/images/main/210415_mo.jpg" title="시행의건"></a></li>
					<li><a href="/mobile/board/view?type=1&idx=18"><img src="/mobile/images/main/210603_2_mo.png" alt="9홀추가"></a></li>
					<li><a href="/mobile/board/view?type=1&idx=37"><img src="/mobile/images/main/211011_mo.jpg" alt="9홀추가"></a></li>
					<li><a href="/mobile/board/view?type=1&idx=3"><img src="/mobile/images/main/bn_banner01.png" title="카트료"></a></li>

				</ul>
				<script>

					$('.slider').bxSlider({
						mode:'horizontal',
						speed : 200,
						pause : 3000,
						auto: true,
						controls: true,
						pager:false,
						touchEnabled:false,
						autoHover:true
					});
				</script>
			</div>
		</div>
		
		<div class="mainBoard">
			<div class="mainBoardTab">
				<ul>
					<li class="" id="type1" onclick="getMainNotice(1)">공지사항</li>
					<li class="" id="type2" onclick="getMainNotice(2)">이벤트</li>
					<li class="" id="type6" onclick="getMainNotice(6)">조인예약</li>
				</ul>
			</div>
			
			<div class="mainBoardList" id="mainNotice">
			</div>			
		</div>
		
		<div class="mainMap">
			<!-- * 카카오맵 - 지도퍼가기 -->
		<!-- 1. 지도 노드 -->
		<div id="daumRoughmapContainer1616567894248" class="root_daum_roughmap root_daum_roughmap_landing"></div>

		<!--
			2. 설치 스크립트
			* 지도 퍼가기 서비스를 2개 이상 넣을 경우, 설치 스크립트는 하나만 삽입합니다.
		-->
		<script charset="UTF-8" class="daum_roughmap_loader_script" src="https://ssl.daumcdn.net/dmaps/map_js_init/roughmapLoader.js"></script>

		<!-- 3. 실행 스크립트 -->
		<script charset="UTF-8">
			new daum.roughmap.Lander({
				"timestamp" : "1616567894248",
				"key" : "25zgx",
				/*"mapWidth" : "640",*/
				"mapHeight" : "240"
			}).render();
		</script>
		</div>
	</div>

<%@ include file="./include/footer.jsp" %>
	