<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="user-scalable=yes, initial-scale=0.3, maximum-scale=1.0, minimum-scale=0.1, width=device-width" />
    <meta name="title" content="포도CC">
    <meta name="author" content="포도CC">
    <meta name="Keywords" content="포도CC, 포도 컨트리클럽, ">
    <meta name="description" content="포도CC, 포도 컨트리클럽, ">
    <meta name="copyright" content="All Contents Copyright©Podo Country Club">
    <meta name="format-detection" content="telephone=no, address=no, email=no"/>
    <meta property="og:type" content="mobile">
    <meta property="og:title" content="포도CC, 포도 컨트리클럽">
    <meta property="og:description" content="포도CC, 포도 컨트리클럽">
    <meta property="og:url" content="">
    <title>포도 컨트리클럽</title>

    <script  src="http://code.jquery.com/jquery-latest.min.js"></script>
    <script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>
    <script type="text/javascript" src="/js/common.js"></script>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />

    <link rel="stylesheet" type="text/css" href="/css/import.css">
    <link rel="stylesheet" type="text/css" href="/css/main.css">
    <link rel="stylesheet" type="text/css" href="/css/motion.css">
    <link rel="stylesheet" type="text/css" href="/css/animate.css">

    <!-- 메인 배경 줌아웃 zoomOut -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.6.0/slick.min.css" rel="stylesheet"/>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.6.0/slick.min.js"></script>

    <script src="/js/jquery.preloaders.js"></script>
    <script src="/js/tools.js"></script>
    <script src="/js/globals.js"></script>
    <script src="/js/wow.js"></script>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/flickity/2.0.5/flickity.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/flickity/2.0.5/flickity.pkgd.min.js"></script>

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
    </script>
    <script>
      let mDate;
      let mYear, mMonth;
      let rowData;

      $(document).ready(function() {
        init();
        //setProtocol();
        sessionCheck();
        deviceIdentification();
      });

      function init() {
        $('.hero-slider').slick({
          dots: true,
          infinite: true,
          speed: 2000,
          dots: false,
          arrows: false,
          autoplay: true,
          autoplaySpeed: 6000,
          fade: true,
          pauseOnHover: false,
          pauseOnFocus: false
        });
        $('.slider2').bxSlider({
          speed : 300,
          pause : 3000,
          auto: true,
          controls: true,
          pager: false,
          touchEnabled:false
        });
        $("#mainCourseMore").mouseenter(
            function () {
              $('#courseInfoTxt').show();
              $('#courseIntroBox').hide();
            }
        );
        $("#courseInfoTxt").mouseleave(
            function () {
              $('#courseInfoTxt').hide();
              $('#courseIntroBox').show();
            }
        );
        $("#mainCourseMore2").mouseenter(
            function () {
              $('#courseInfoTxt2').show();
              $('#courseIntroBox2').hide();
            }
        );
        $("#courseInfoTxt2").mouseleave(
            function () {
              $('#courseInfoTxt2').hide();
              $('#courseIntroBox2').show();
            }
        );

        if(getCookie("notToday")=="Y"){
          $("#mainPop").hide();
        }

        let date = new Date();
        mYear = date.yyyy();
        mMonth = date.mm();

        initCalendar("#calendarBox1", mYear, mMonth);
        getMainNotice(1);
        getMainNotice(8);
      }

      function setProtocol() {
        if (document.location.protocol == 'http:') {
          document.location.href = document.location.href.replace('http:', 'https:');
        }
      }
      function sessionCheck() {
        let sUrl = "/sessionConfirm";
        //let params = {"method" : "sessionConfirm"};
        let params = {};

        mAjax(sUrl, params, "POST", false, function(data) {
          if(data.resultCode == "2000") {
            alert(data.resultMessage);
            location.reload();
          }
        });
      }

      function initCalendar(selector, year, month) {
        let sUrl = "/getCalendar";
        let params = {};

        //params["method"] = "getCalendar";
        params["coDiv"] = globals.coDiv;
        params["selYm"] = year + month;

        mAjax(sUrl, params, "POST", true, function(data) {
          if(data.resultCode == "0000") {
            $(selector + " #calHeader").empty().append(month + "월");

            let currentDay = new Date().yyyymmdd();
            let tBody = $(selector + " #calendar-body");
            tBody.empty();

            let rows = data.rows;

            if(rows.length > 0) {
              let row = $("<tr></tr>");

              let fWeek = rows[0].CL_DAYDIV - 1;

              for(i=0; i<fWeek; i++) {
                row.append($("<td></td>"));
              }
              for(i=0; i<rows.length; i++) {
                let td = "";
                if(rows[i].CL_SOLAR >= currentDay) {
                  if (rows[i].CL_SOLAR == currentDay) {
                    td = $("<td>"+ rows[i].DAYNUM + "</td>");
                    td.addClass('today');
                  } else if(rows[i].BK_TEAM > 0) {
                    td = $("<td>" + rows[i].DAYNUM + "</td>");
                    if (rows[i].CL_BUSINESS == "2") {
                      td.addClass('sat');
                    } else if (rows[i].CL_BUSINESS == "3" || rows[i].CL_BUSINESS == "4") {
                      td.addClass('sun');
                    }
                    td.data('date', rows[i].CL_SOLAR);
                    td.addClass('possible');
                    td.on('click', function() {
                      onClickDay($(this).data('date'));
                    });
                  } else {
                    td = $("<td>" + rows[i].DAYNUM + "</td>");
                    if (rows[i].CL_BUSINESS == "2") {
                      td.addClass('sat');
                    } else if (rows[i].CL_BUSINESS == "3" || rows[i].CL_BUSINESS == "4") {
                      td.addClass('sun');
                    }
                    td.addClass('impossible');
                  }
                } else {
                  td = $("<td>" + rows[i].DAYNUM + "</td>");
                  if (rows[i].CL_BUSINESS == "2") {
                    td.addClass('sat');
                  } else if (rows[i].CL_BUSINESS == "3" || rows[i].CL_BUSINESS == "4") {
                    td.addClass('sun');
                  }
                  td.addClass('impossible');
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

      function sNextMonth() {
        if(mMonth == "12") {
          mYear += 1;
          mMonth = "01";
        } else {
          mMonth = Number(mMonth) + 1;
          mMonth = (mMonth>9 ? '' : '0') + mMonth;
        }

        initCalendar("#calendarBox1", mYear, mMonth);
      }

      function sPrevMonth() {
        if(mMonth == "01") {
          mYear -= 1;
          mMonth = "12";
        } else {
          mMonth = Number(mMonth) - 1;
          mMonth = (mMonth>9 ? '' : '0') + mMonth;
        }

        initCalendar("#calendarBox1", mYear, mMonth);
      }

      function onClickDay(date) {
        mDate = date;
        bkSumit();
      }

      function bkSumit() {
        if(mDate == "" || mDate == null) {
          alert("날짜를 선택해주세요.");
          return;
        }
        $("#BK_DAY").val(mDate);
        $('#resv_info').submit();
      }

      function getMainNotice(paraType) {

        /*if (paraType == 1) {
            $(".btn1").addClass("on");
            $(".btn2").removeClass("on");
            let bbsTitle = "공지사항";
        } else {
            $(".btn2").addClass("on")
            $(".btn1").removeClass("on")
            let bbsTitle = "이벤트";
        }*/

        let sUrl = "/getBoardList";
        let params = {};

        //params["method"] = "getBoardList";

        params["coDiv"]    = globals.coDiv;
        params["type"]     = paraType;
        params["startCnt"] = 0;
        params["pageCnt"]  = 5;

        mAjax(sUrl, params, "POST", false, function(data) {
          if(data.resultCode == "0000") {

            let rows = data.rows;

            if (rows.length == 0) {

              let notice = ""
              notice += "<li>	";
              notice += " <img src='/images/main/bg_blank.png'>";
              notice += " <div class='slideText'>	";
              notice += " <h1> 등록된 공지사항이 없습니다. </h1>	";
              notice += " <h4> - </h4>	"
              notice += " <a href='#' class='slideBtn'>자세히 보기 <i class='fas fa-chevron-circle-right'></i></a>	";
              notice += " </div>	";
              notice += " </li>	";

              $("#mainNotice").empty().append(notice);
              setTimeout(function() {
                $('.slider1').bxSlider({
                  mode:'horizontal',
                  speed : 300,
                  pause : 3000,
                  auto: true,
                  controls: true,
                  pager:true,
                  touchEnabled:false
                });
              }, 300);
              return;
            }

            $("#mainNotice").empty();

            for(i=0; i<rows.length; i++) {

              let notice = ""

              let link = "/board/view?type=1&idx=" + rows[i].IDX;
              let title = rows[i].TITLE;
              let inputDate = rows[i].INPUT_DATETIME;

              notice += "<li>	";
              notice += " <img src='/images/main/bg_blank.png'>";
              notice += " <div class='slideText'>	";
              notice += " <h1> " + title + " </h1>	";
              notice += " <h4> " + inputDate + " </h4>	"
              notice += " <a href='" + link + "' class='slideBtn'>자세히 보기 <i class='fas fa-chevron-circle-right'></i></a>	";
              notice += " </div>	";
              notice += " </li>	";
              $("#mainNotice").append(notice);
            }
            setTimeout(function() {
              $('.slider1').bxSlider({
                mode:'horizontal',
                speed : 300,
                pause : 3000,
                auto: true,
                controls: true,
                pager:true,
                touchEnabled:false
              });
            }, 300);

            //popup modal 팝업모달
            if (params.type == 8) {
              for(i=0; i<rows.length; i++) {
                if(getCookie("main_popup"+rows[i].IDX) == "Y"){
                  continue;
                }
                let popup_html = ""
                popup_html += '<div id="main_popup'+rows[i].IDX+'" style="position: fixed; z-index: 10000000; top: '+rows[i].POSITION_Y+'px; left: '+rows[i].POSITION_X+'px;">';
                popup_html += '<a href="'+rows[i].LINK+'">';
                popup_html += '<img src="/images/getfile?fullpath='+rows[i].FILE_PATH1+'/'+rows[i].FILE_NAME1+'" height="400" width="400">';
                popup_html += '</a>';
                popup_html += '<div class="popup_bottom">';
                popup_html += '<a href=javascript:closeMainPopupToday("main_popup'+rows[i].IDX+'") style="display: inline">오늘하루 그만보기</a>';
                popup_html += '<a class="pull-right" href=javascript:closeMainPopup("main_popup'+rows[i].IDX+'");>닫기</a>';
                popup_html += '</div>';
                popup_html += '</div>';
                $("#popup_modal").append(popup_html);
              }
            }



          } else {
            alert(data.resultMessage);
          }
        });
      }

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

      function closePopupNotToday(){
        setCookie('notToday','Y', 1);
        $("#mainPop").hide('fade');
      }

      function closeMainPopupToday(id){
        setCookie(id, 'Y', 1);
        $("#" + id).hide('fade');
      }

      function closeMainPopup(id){
        $("#" + id).hide('fade');
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

    <form id="resv_info" method="POST" action="/reservation/reservation">
        <input type="hidden" name="BK_DAY" id="BK_DAY">
    </form>

<body>

<%-- 팝업링크 --%>
<div id="popup_modal"></div>

<div class="siteAll"><div class="toggleMenu"><span class=""></span></div></div>

<div id="wrap">
    <div class="mainWrap">
        <div class="headerBox">
            <!--메뉴-->
            <div class="header">

                <a href="index" class="logoBox" id="logo"></a>

                <ul class="mainList">
                    <li onclick="location.href='/reservation/reservation'">인터넷예약</li>
                    <li onclick="location.href='/guide/reserGuide'">이용안내</li>
                    <li onclick="location.href='/club/intro'">클럽소개</li>
                    <li onclick="location.href='/course/intro'">코스소개</li>
                    <li onclick="location.href='/fac/fac01'">시설안내</li>
                    <li onclick="location.href='/board/list?type=1'">정보마당</li>
                </ul>
                <%@ include file="./include/submenu.jsp" %>

                <ul class="rightBtn">
                    <li class="topJoin">
                        <% if (session.getAttribute("MS_NUM") == null) { %>
                            <a href="https://www.serenitycc.co.kr" class="podo">세레니티</a>
                            <a href="/member/login" class="topLogin" id="login"></a>
                        <% } else { %>
                            <a href="https://www.serenitycc.co.kr" class="podo">세레니티</a>
                            <a href="/member/modify" class="topLogin" id="login"></a>
                        <% } %>
                    </li>
                </ul>
            </div>
            <%@ include file="./include/topmenu.jsp" %>

        </div>

        <!--메인팝업 start-->
        <div class="popupWrap text-focus-in" id="mainPop">
            <h1>green fee &amp; event</h1>
            <h4>포도CC 그린피 안내 및 이벤트</h4>
            <div class="slider2" height="400px">
                <div>
                    <p><a href="http://www.band.us/@podocc"><img src="/images/220805_밴드_bn.jpg" title="밴드오픈"></a></p>
                    <p><a href="/board/view?type=2&idx=4"><img src="/images/220719_bn.jpg" title="홀인원이벤트"></a></p>
                    <p><a href="/board/view?type=1&idx=63"><img src="/images/220627_bn.jpg" title="캐디피인상안내"></a></p>
                </div>
                <div>
                    <p><a href="/board/view?type=1&idx=68"><img src="/images/220808_10월그린피_bn.jpg" title="10월 그린피"></a></p>
                    <p><a href="/board/view?type=1&idx=69"><img src="/images/220808_10월패키지_bn.jpg" title="10월 1박2일"></a></p>
                    <p><a href="/board/view?type=1&idx=70"><img src="/images/220808_10월골프대회_bn.jpg" title="10월골프대회"></a></p>
                </div>
                <div>
                    <p><a href="/board/view?type=1&idx=73"><img src="/images/221011_10월골프대회_bn.jpg" title="10월 골프대회"></a></p>
                    <p><a href="/board/view?type=1&idx=71"><img src="/images/220913g_bn.jpg" title="11월 그린피"></a></p>
                    <p><a href="/board/view?type=1&idx=72"><img src="/images/220913p_bn.jpg" title="11월 1박2일"></a></p>
                </div>
                <div>
                    <p><a href="/board/view?type=1&idx=8"><img src="/images/210423_2.jpg" title="김천 포도CC 시행의건"></a></p>
                    <p><a href="/board/view?type=1&idx=23"><img src="/images/210705_bn.jpg" alt="대체공휴일"></a></p>
                    <p><a href="/board/view?type=1&idx=37"><img src="/images/211011_bn.jpg" alt="9홀추가"></a></p>
                </div>
                <div>
                    <p><a href="/board/view?type=1&idx=18"><img src="/images/210603_2_bn.jpg" alt="9홀코스오픈"></a></p>
                    <p><a href="#"><img src="/images/no-img.jpg" title="이미지 없을때"></a>
                    <p><a href="#"><img src="/images/no-img.jpg" title="이미지 없을때"></a>
                </div>
            </div>
            <div class="popX"><a href="javascript:closePopupNotToday();">오늘하루안보기</a><span onclick="$('#mainPop').hide()"><img src="/images/x-box.png"></span></div>
        </div>
        <!--메인팝업 end-->

        <div class="hero-slider">
            <div class="columns">
                <div class="hero-image" >
                    <img src="/images/main/mainBg01.jpg" alt="">
                </div>
            </div>
            <div class="columns">
                <div class="hero-image" >
                    <img src="/images/main/mainBg01.jpg" alt="">
                </div>
            </div>
        </div><!-- hero-slider End -->
        <div class="mainCont">
            <div class="leftTxtBox">
                <img src="/images/main/mainTxt.png" alt="" class="leftTxt text-focus-in" >
            </div>
            <div class="rightCalBox">
                <div class="rightCal"></div>
                <div class="calBox" id="calendarBox1">
                    <div class="monthChoice">
                        <li class="title tt2">실시간예약</li>
                        <li class="monthBtnBox">
                            <a href="javascript:sPrevMonth()" class="monthBtn">◀</a>
                            <span class="month" id="calHeader"></span>
                            <a href="javascript:sNextMonth()" class="monthBtn">▶</a>
                        </li>
                    </div>
                    <table class="mainCalendar" summary="실시간 예약" cellspacing="5">
                        <caption>실시간 예약</caption>
                        <colgroup>
                            <col width="*">
                            <col width="*">
                            <col width="*">
                            <col width="*">
                            <col width="*">
                            <col width="*">
                            <col width="*">
                        </colgroup>
                        <thead>
                        <tr>
                            <th scope="col" class="sun">SUN</th>
                            <th scope="col">MON</th>
                            <th scope="col">TUE</th>
                            <th scope="col">WED</th>
                            <th scope="col">THU</th>
                            <th scope="col">FRI</th>
                            <th scope="col" class="sat">SAT</th>
                        </tr>
                        </thead>
                        <tbody id="calendar-body">
                        </tbody>

                    </table>
                </div>

            </div><!-- rightCalBox End -->
        </div><!-- mainCont End -->
    </div><!-- mainWrap End -->

    <div class="secondContBox">
        <div class="secondLeft">
            <div class="textBox fromLeftIn" data-scroll="toggle(.fromLeftIn, .fromLeftOut)">
                <h3>대한민국을 대표하는 한국적 골프클럽</h3>
                <h2>PODO C.C</h2>
                <p>누구나 말하는 명문클럽보다는 품격 있는 나만의 <br>
                    컨트리클럽을 원하는 고객들에게 특별한 경험과<br>
                    분위기로 더욱 만족을 드릴 것입니다.<br>
                    그 누구도 상상하지 못했던 아주 특별한 컨셉의 <br>
                    컨트리클럽이 지금 귀하의 도전과 사랑을 기다 <br>리고
                    있습니다.
                </p>
            </div>
        </div>
        <div class="secondRight">
            <div class="hero-slider2" data-carousel>
                <div class="carousel-cell" style="background-image:url(/images/main/img01.jpg);">
                    <div class="overlay"></div>
                    <div class="inner">
                        “지친 삶 속에서 자연과 함께하는 즐거운 시간”
                    </div>
                </div>
                <div class="carousel-cell" style="background-image:url(/images/main/img02.jpg);">
                    <div class="overlay"></div>
                    <div class="inner">
                        “고객에게 감사의 마음으로 최고의 서비스를 약속합니다.”
                    </div>
                </div>
                <!--<div class="carousel-cell" style="background-image:url(/images/main/Img01.jpg);">
                    <div class="overlay"></div>
                      <div class="inner">
                      “지친 삶 속에서 자연과 함께하는 즐거운 시간”
                    </div>
                  </div>-->
            </div>
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/flickity/2.0.5/flickity.min.css">
            <script src="https://cdnjs.cloudflare.com/ajax/libs/flickity/2.0.5/flickity.pkgd.min.js"></script>
            <script id="rendered-js" >
              let options = {
                accessibility: true,
                prevNextButtons: true,
                pageDots: false,
                setGallerySize: false,
                arrowShape: {
                  x0: 10,
                  x1: 60,
                  y1: 50,
                  x2: 60,
                  y2: 45,
                  x3: 15 } };

              let carousel = document.querySelector('[data-carousel]');
              let slides = document.getElementsByClassName('carousel-cell');
              let flkty = new Flickity(carousel, options);

              flkty.on('scroll', function () {
                flkty.slides.forEach(function (slide, i) {
                  let image = slides[i];
                  let x = (slide.target + flkty.x) * -1 / 3;
                  image.style.backgroundPosition = x + 'px';
                });
              });
              //# sourceURL=pen.js
            </script>

            <div class="secondBottom">
                <a href="/club/intro" class="clubIntroBtn fromTopIn" data-scroll="toggle(.fromTopIn, .fromTopOut)">
                    <button id="js-trigger-overlay" type="button">클럽소개 자세히보기 <span class="arrow_btn arrow-left"></span></button>
                </a>
            </div>

        </div>
    </div><!-- secondContBox End -->

    <ul class="thirdContBox">
        <li class="mainCourseBox">
            <div class="courseIntroBox" id="courseIntroBox">
                <div class="courseIntro fromTopIn" data-scroll="toggle(.fromTopIn, .fromTopOut)" id="mainCourseMore">
                    <span class="miniTitle">자연친화적 클래식 골프코스 </span>
                    <span class="title">OUT COURSE</span>
                    <!--<a href="/course/intro">코스안내 자세히 보기 < </a>-->
                </div>
            </div>

            <div class="courseInfoTxt" id="courseInfoTxt" style="display:none;">
                <span class="minititle">자연친화적 클래식 골프코스 </span>
                <span class="title">IN COURSE</span>
                <p class="infoTxt">
                    누구나 말하는 명문클럽보다 품격 있는 나만의<br>
                    컨트리클럽을 원하는 고객들에게 특별한 경험과<br>
                    분위기로 더욱 만족을 드릴 것입니다.
                </p>
                <a href="/course/intro">코스안내 자세히 보기 </a>
            </div>
        </li>

        <li class="mainCourseBox">
            <div class="courseIntroBox box2" id="courseIntroBox2">
                <div class="courseIntro fromTopIn" data-scroll="toggle(.fromTopIn, .fromTopOut)" id="mainCourseMore2">
                    <span class="miniTitle">전통적인 스타일 골프클럽</span>
                    <span class="title">IN COURSE</span>
                    <!--<a href="/course/intro">코스안내 자세히 보기 < </a>-->
                </div>
            </div>

            <div class="courseInfoTxt txt2" style="display:none;" id="courseInfoTxt2">
                <span class="miniTitle">전통적인 스타일 골프클럽</span>
                <span class="title">IN COURSE</span>
                <p class="infoTxt">
                    그 누구도 상상하지 못했던 아주 특별한 컨셉의<br>
                    특별한 컨트리클럽이 지금 귀하의 도전과 사랑을<br>
                    기다리고 있습니다.
                </p>
                <a href="/course/intro">코스안내 자세히 보기 </a>
            </div>
        </li>-

        <li class="mainCourseBox">
            <div class="courseIntroBox box3">
            </div>
        </li>


    </ul><!-- thirdContBox End -->

    <div class="forthContBox">
        <div class="mapNoticeWrap">
            <div class="noticeBox">
                <div class="bx-wrapper">
                    <ul class="slider1" id="mainNotice">
                    </ul>
                </div>
                <!--<p class="line">|</p>	-->
            </div>
            <div class="mainMapWrap">
                <!-- * 카카오맵 - 지도퍼가기 -->
                <!-- 1. 지도 노드 -->
                <div id="daumRoughmapContainer1617170513288" class="root_daum_roughmap root_daum_roughmap_landing"></div>

                <!--
                    2. 설치 스크립트
                    * 지도 퍼가기 서비스를 2개 이상 넣을 경우, 설치 스크립트는 하나만 삽입합니다.
                -->
                <script charset="UTF-8" class="daum_roughmap_loader_script" src="https://ssl.daumcdn.net/dmaps/map_js_init/roughmapLoader.js"></script>

                <!-- 3. 실행 스크립트 -->
                <script charset="UTF-8">
                  new daum.roughmap.Lander({
                    "timestamp" : "1617170513288",
                    "key" : "2558d",
                    "mapHeight" : "600"
                  }).render();
                </script>
                <div class="mainMapInfo fromRightIn" data-scroll="toggle(.fromRightIn, .fromRightOut)">
                    <h1><span><i class="fas fa-map-marker-alt" style="font-size:30px;"></i> PODO CC</span> map.</h1>
                    <h3>Golf Healing Life</h3>
                    <p>경상북도 김천시 구성면 남김천대로 2532</p>
                    <h4>예약관련 문의</h4>
                    <h2>054.420.0200</h2>
                    <h5>24시간 운영중인 홈페이지 예약과 모바일 예약을 이용하시면 더욱 편리합니다. </h5>
                </div>
            </div>
        </div>
    </div>



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

<%@ include file="./include/footer.jsp" %>
