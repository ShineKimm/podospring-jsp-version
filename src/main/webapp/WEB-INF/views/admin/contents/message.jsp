<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<script>

  $(document).ready(function() {
    init();
  });

  function init() {
    getMessage();
  }

  function getMessage() {
    let sUrl = "/controller/AdminController";
    let params = {};

    //params["method"] = "getMessage";
    params["coDiv"] = globals.coDiv;

    mAjax(sUrl, params, "POST", true, function(data) {
      if(data.resultCode == "0000") {
        let rows = data.rows;

        for(i=0; i<rows.length; i++) {
          $("#txtMessage" + rows[i].HP_CODE).val(replaceAll(rows[i].HP_CONTENTS, "<br>", "\n"));
        }
      } else {
        alert(data.resultMessage);
      }
    });
  }

  function doSave(code) {
    let sUrl = "/controller/AdminController";
    let params = {};

    //params["method"] = "doSaveMessage";
    params["coDiv"] = globals.coDiv;
    params["code"] = code;
    params["content"] = replaceAll($("#txtMessage" + code).val(), "\n", "<br>");

    mAjax(sUrl, params, "POST", true, function(data) {
      if(data.resultCode == "0000") {
        alert("저장되었습니다.");
        getMessage();
      } else {
        alert(data.message);
      }
    });
  }

</script>

<div id="wrap">
    <ul class="gnb">
        <div class="content">
            <li class=""><a href="/admin/index">HOME</a></li>
            <li class=""><a href="/admin/board/list?type=1">게시판 관리</a></li>
            <li class="on"><a href="/admin/contents/message">문구 관리</a></li>
        </div>
    </ul>

    <div class="content">

        <div class="cate_title">문구 관리</div>

        <div id="contentsWrap">
            <div class="start messageBox">
                <h2>패키지 예약</h2>
                <textarea class="messageTxt" id="txtMessageP01"></textarea>
                <p class="saveBtn" onclick="doSave('P01')">저장</p>
            </div>
        </div>
    </div>
</div>
<%@ include file="../include/footer.jsp" %>
