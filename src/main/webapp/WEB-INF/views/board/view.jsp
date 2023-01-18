<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<script>
  let mType;
  let mIdx;

  let title = {
    "1" : "공지사항",
    "2" : "이벤트",
    "3" : "보도자료",
    "4" : "자료실",
    "5" : "코스갤러리",
    "7" : "명예의 전당"
  }

  $(document).ready(function() {
    init();
  });

  function init() {
    mType = <%=request.getParameter("type")%>;
    mIdx = <%=request.getParameter("idx")%>;

    $("#txtTitle").html(title[mType]);
    $("#type" + mType).addClass("on");

    if (mType == "5") {
      $("#galleryList").show();
    } else {
      $("#boardList").show();
    }

    doSearchDetail();
  }

  function doSearchDetail() {
    let sUrl = "/getBoardDetail";
    let params = {};

    //params["method"] = "getBoardDetail";
    params["coDiv"] = globals.coDiv;
    params["type"] = mType;
    params["idx"] = mIdx;

    mAjax(sUrl, params, "POST", true, function(data) {
      if(data.resultCode == "0000") {
        rows = data.rows;

        let title = rows[0].TITLE;
        let writer = rows[0].WRITER_NAME;
        let inputDate = rows[0].INPUT_DATETIME;
        let viewCnt = rows[0].VIEW_CNT;
        let content = rows[0].CONTENT;
        content = replaceAll(content, "\n", "<br>");

        $("#txtSubject").html(title);
        $("#txtWriter").html(writer);
        $("#txtDate").html(inputDate);
        $("#txtViewCnt").html(viewCnt);

        $("#contentContainer").html(content);

        let imageContainer = $("#imageContainer");

        let fileName1 = rows[0].FILE_NAME1;
        let fileName2 = rows[0].FILE_NAME2;
        let fileName3 = rows[0].FILE_NAME3;
        let originFileName1 = rows[0].ORIGIN_FILE_NAME1;
        let originFileName2 = rows[0].ORIGIN_FILE_NAME2;
        let originFileName3 = rows[0].ORIGIN_FILE_NAME3;
        let filePath1 = rows[0].FILE_PATH1;
        let filePath2 = rows[0].FILE_PATH2;
        let filePath3 = rows[0].FILE_PATH3;

        if(fileName1 != "" && filePath1 != "") {
          if(isImage(fileName1)) {
            let img = String.format("<div class='viewContentBox'><img src='/images/getfile?fullpath={0}/{1}' alt=''></div>", filePath1, fileName1);
            imageContainer.show();
            imageContainer.append(img);
            // console.log(img);
          }
        }

        if(fileName2 != "" && filePath2 != "") {
          if(isImage(fileName2)) {
            let img = String.format("<div class='viewContentBox'><img src='/images/getfile?fullpath={0}/{1}' alt=''></div>", filePath2, fileName2);
            imageContainer.show();
            imageContainer.append(img);
            // console.log(img);
          }
        }

        if(fileName3 != "" && filePath3 != "") {
          if(originFileName3.substr(-3)=="mp4") {
            let img = String.format("<video muted autoplay loop controls width='500'><source src='/images/getfile?fullpath={0}/{1}' type='video/mp4'></video>" ,filePath3, fileName3);
            imageContainer.show();
            imageContainer.append(img);
            // console.log(img);
          }
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
        <ul class="navbarBox" id="boardList" hidden>
            <li class="" onclick="location.href='/board/list?type=1'" id="type1">공지사항</li>
            <li class="" onclick="location.href='/board/list?type=2'" id="type2">이벤트</li>
            <li class="" onclick="location.href='/board/list?type=3'" id="type3">보도자료</li>
            <li class="" onclick="location.href='/board/list?type=4'" id="type4">자료실</li>
            <li class="" onclick="location.href='/board/honor'" id="honor">홀인원</li>
            <li class="" onclick="location.href='/reservation/joinList'" id="type6">조인게시판</li>
            <li class="" onclick="location.href='/board/list?type=7'" id="type7">명예의 전당</li>

            <li class="homeBox"><img src="/images/home.jpg" alt="">&nbsp; 정보마당 &nbsp;<img src="/images/mini_arw.jpg" alt="">&nbsp; <span id="txtTitle" style="font-size:inherit;color:inherit;font-weight:400;"></span></li>
        </ul>
        <ul class="navbarBox" id="galleryList" hidden>
            <li class="on" onclick="location.href='/course/intro'">코스소개</li>
            <li class="" onclick="location.href='/board/list?type=5'">코스갤러리</li>

            <li class="homeBox"><img src="/images/home.jpg" alt="">&nbsp; 코스소개 &nbsp;<img src="/images/mini_arw.jpg" alt="">&nbsp; 코스소개</li>
        </ul>
    </div>
    <div class="contents">
        <div class="borderBox">
            <table class="commonTable" summary="게시판">
                <caption>게시판</caption>
                <tbody>

                <tr>
                    <th colspan="6" id="txtSubject"></th>
                </tr>
                <tr>
                    <th>작성자</th>
                    <td id="txtWriter"></td>
                    <th>작성일</th>
                    <td id="txtDate"></td>
                    <th>조회수</th>
                    <td id="txtViewCnt"></td>
                </tr>

                <tr>
                    <td colspan="6" class="boardCont">
                        <div id="contentContainer"></div>
                        <div id="imageContainer"></div>
                    </td>
                </tr>

                </tbody>
            </table>

            <div class="btnBox">
                <a href="/board/list?type=<%=request.getParameter("type")%>" class="grayBtn">목록보기</a>
            </div>

        </div>
    </div>
</div><!-- contents End-->

</div>	<!-- wrap End -->
<%@ include file="../include/footer.jsp" %>
