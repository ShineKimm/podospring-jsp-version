<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>

<script>
  let mType;
  let mIdx;

  let title = {
    "1" : "공지사항",
    "2" : "이벤트",
    "3" : "분실물정보",
    "4" : "자료실",
    "5" : "코스갤러리",
    "7" : "명예의 전당",
    "8" : "팝업 관리"
  }

  $(document).ready(function() {
    init();
  });

  function init() {
    mType = <%=request.getParameter("type")%>;
    mIdx = <%=request.getParameter("idx")%>;

    $("#txtTitle").html(title[mType]);

    initTabMenu();

    doSearchDetail();
  }

  function initTabMenu() {
    $("#tabContainer").children("a").each(function(index, element) {
      if(element.id == "tab" + mType) {
        $("#" + element.id).addClass("on");
      } else {
        $("#" + element.id).removeClass("on");
      }
    });
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
        let link = rows[0].LINK;
        content = replaceAll(content, "\n", "<br>");

        $("#txtSubject").html(title);
        $("#txtWriter").html(writer);
        $("#txtDate").html(inputDate);
        $("#txtViewCnt").html(viewCnt);

        if(content != "") {
          $("#contentContainer").show();
          $("#contentContainer").html(content);
        }

        if(mType == "6") {
          $("#linkContainer").show();
          $("#txtLink").html(link);
        }

        let imageContainer = $("#imageContainer");
        let fileContainer = $("#fileContainer");

        let fileName1 = rows[0].FILE_NAME1;
        let fileName2 = rows[0].FILE_NAME2;
        let fileName3 = rows[0].FILE_NAME3;
        let originFileName1 = rows[0].ORIGIN_FILE_NAME1;
        let originFileName2 = rows[0].ORIGIN_FILE_NAME2;
        let originFileName3 = rows[0].ORIGIN_FILE_NAME3;
        let filePath1 = rows[0].FILE_PATH1;
        let filePath2 = rows[0].FILE_PATH2;
        let filePath3 = rows[0].FILE_PATH3;

        //TODO 배포 후 이미지 경로 수정
        // /images/getfile?fullpath={0}/{1}
        if(fileName1 != "" && filePath1 != "" && mType != "5") {
          if(isImage(fileName1)) {
            let img = String.format("<img src='/images/getfile?fullpath={0}/{1}' class='viewMainImage'>", filePath1, fileName1);
            imageContainer.show();
            imageContainer.append(img);
            // console.log(img);
          } else {
            //TODO 파일 다운로드 확인필요
            let a = String.format("&nbsp;&nbsp;<a href='/images/getfile?fullpath={0}/{1}' download='{2}'>{2}</a>", filePath1, fileName1, originFileName1);
            fileContainer.show();
            $("#txtFiles").append(a);
            // console.log(a);
          }
        }

        if(fileName2 != "" && filePath2 != "") {
          if(isImage(fileName2)) {
            let img = String.format("<img src='/images/getfile?fullpath={0}/{1}' class='viewMainImage'>", filePath2, fileName2);
            imageContainer.show();
            imageContainer.append(img);
            // console.log(img);
          } else {
            let a = String.format("&nbsp;&nbsp;<a href='/images/getfile?fullpath={0}/{1}' download='{2}'>{2}</a>", filePath2, fileName2, originFileName2);
            fileContainer.show();
            $("#txtFiles").append(a);
            // console.log(a);
          }
        }

        if(fileName3 != "" && filePath3 != "") {
          if(isImage(fileName3)) {
            let img = String.format("<img src='/images/getfile?fullpath={0}/{1}' class='viewMainImage'>", filePath3, fileName3);
            imageContainer.show();
            imageContainer.append(img);
          } else {
            let a = String.format("&nbsp;&nbsp;<a href='/images/getfile?fullpath={0}/{1}' download='{2}'>{2}</a>", filePath3, fileName3, originFileName3);
            fileContainer.show();
            $("#txtFiles").append(a);
          }
        }
      } else {
        alert(data.resultMessage);
      }
    });
  }

  function doDelete(div) {
    let sUrl = "/doDelete";
    let params = {};

    //params["method"] = "doDelete";
    params["coDiv"] = globals.coDiv;
    params["type"] = mType;
    params["idx"] = mIdx;
    params["div"] = div;

    mAjax(sUrl, params, "POST", true, function(data) {
      if(data.resultCode == "0000") {
        alert("게시글이 수정 되었습니다.");
        location.href = "/admin/board/list?type=" + mType;
      } else {
        alert(data.resultMessage);
      }
    });
  }

  function doUpdate() {
    location.href = "/admin/board/write?action=U&type=" + mType + "&idx=" + mIdx;
  }

  function imgError(image) {
    image.onerror = "";
    image.src = '{0}/{1}';
    return true;
  }

</script>

<div id="wrap">
    <ul class="gnb">
        <div class="content">
            <li class=""><a href="/admin/index">HOME</a></li>
            <li class="on"><a href="/admin/board/list?type=1">게시판 관리</a></li>
            <li class=""><a href="/admin/contents/message">문구 관리</a></li>
        </div>
    </ul>

    <div class="content">
        <div class="adminTab" id="tabContainer">
            <a href="javascript:location.href='/admin/board/list?type=1'" id="tab1" class="on">공지사항</a>
            <a href="javascript:location.href='/admin/board/list?type=2'" id="tab2" class="">이벤트</a>
            <a href="javascript:location.href='/admin/board/list?type=3'" id="tab3" class="">보도자료</a>
            <a href="javascript:location.href='/admin/board/list?type=4'" id="tab4" class="">자료실</a>
            <a href="javascript:location.href='/admin/board/list?type=5'" id="tab5" class="">코스갤러리</a>
            <a href="javascript:location.href='/admin/board/list?type=7'" id="tab7" class="">명예의 전당</a>
            <a href="javascript:location.href='/admin/board/list?type=8'" id="tab8" class="">팝업 관리</a>
        </div>

        <div class="cate_title" id="txtTitle"></div>

        <div id="contentsWrap">
            <!-- 컨텐츠 시작 -->
            <div class="start"> <br>
                <form name="frm" method="post">
                    <input type="hidden" name="title" value="<%--<%=request.getParameter("strTitle")%>--%>">
                    <input type="hidden" name="bbstype" value="<%--<%=bbstype%>--%>">
                    <input type="hidden" name="intIdx" value="<%--<%=intIdx%>--%>">
                    <input type="hidden" name="txtMode" value="">

                    <div class="pop">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0" summary="게시글">
                            <caption>
                                게시글
                            </caption>
                            <colgroup>
                                <col width="20%">
                                <col width="80%">
                            </colgroup>
                            <tr>
                                <th>제목</th>
                                <td id="txtSubject"></td>
                            </tr>
                            <tr>
                                <th>작성자</th>
                                <td id="txtWriter"></td>
                            </tr>
                            <tr>
                                <th>작성일</th>
                                <td id="txtDate"></td>
                            </tr>
                            <tr id="linkContainer" hidden>
                                <th>링크</th>
                                <td id="txtLink"></td>
                            </tr>
                            <tr>
                                <td colspan="2" class="poppadding" id="contentContainer" hidden>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" class="poppadding" id="imageContainer" hidden>
<%--                                    <img src='/uploads/20221209033711.jpg' class='viewMainImage'>--%>
                                </td>
                            </tr>
                            <tr id="fileContainer" hidden>
                                <th>첨부파일</th>
                                <td id="txtFiles"></td>
                            </tr>
                        </table>
                    </div>
                    <ul class="choice">
                        <li><a href="/admin/board/list?type=<%=request.getParameter("type")%>"><span class="bigbtn">목록으로</span></a></li>
                        <li><a href="javascript:doUpdate()"><span class="bigbtn">수정하기</span></a></li>
                        <li><a href="javascript:doDelete('1')"><span class="bigbtn">삭제하기</span></a></li>
                        <li><a href="javascript:doDelete('0')"><span class="bigbtn">삭제취소</span></a></li>
                    </ul>
                </form>
                <div class="clear"></div>
                <br>
                <br>
            </div>
        </div>
    </div>
</div>
<%@ include file="../include/footer.jsp" %>