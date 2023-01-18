<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<script language="javascript">
  $(document).ready(function() {
    if(<%=session.getAttribute ("MS_NUM") != null %>) {
      alert("이미 로그인이 되어있습니다.");
      location.href="/index";
    }

    let chk = getCookie("chkSaveId");
    let id = getCookie("loginId");

    if(chk != null && chk != "") {
      $("#chkSaveId").attr('checked', true);
    }

    if(id != null && id != "") {
      $("#txtId").val(id);
    }

    $("#txtId").keypress(function (event) {
      if(event.keyCode == 13) {
        doLogin();
      }
    });

    $("#txtPw").keypress(function (event) {
      if(event.keyCode == 13) {
        doLogin();
      }
    });
  });

  function doLogin() {
    let sUrl = "/doLogin";
    let params = {};
    let page = "<%=request.getParameter("page")%>";

    let id = $("#txtId").val();
    let pw = $("#txtPw").val();

    if(page == null || page == "" || page == "null") {
      page = "/index";
    }

    if(id == "") {
      alert("아이디를 입력하세요.");
      return;
    }

    if(pw == "") {
      alert("비밀번호를 입력하세요.");
      return;
    }

    // params["method"] = "doLogin";
    params["coDiv"] = globals.coDiv;
    params["id"] = id;
    params["pw"] = pw;

    mAjax(sUrl, params, "POST", true, function(data) {
      if(data.resultCode == "0000") {
        let chkSaveId = $('input:checkbox[id="chkSaveId"]').is(":checked");

        if(chkSaveId) {
          setCookie("loginId", $("#txtId").val(), 365);
          setCookie("chkSaveId", true, 365);
        } else {
          setCookie("loginId", "", 365);
          setCookie("chkSaveId", "", 365);
        }
        alert(data.resultName + "회원님 환영합니다.")
        location.href = page;
      } else {
        alert(data.resultMessage);
      }
    });
  }
</script>

<div class="middleBg6 zoomImg">
</div>
<ul class="mainMenuTitle text-focus-in">
    <li class="big">Login</li>
    <li>로그인</li>
</ul>

<!-- 컨텐츠 시작 -->
<div id="wrap">
    <div class="navbarWrap">
        <ul class="navbarBox">
            <li class="on" onclick="location.href='/member/login'">로그인</li>
            <li class="" onclick="location.href='/member/join01'">회원가입</li>
            <li class="" onclick="location.href='/member/find'">아이디/비번찾기</li>
            <li class="homeBox"><img src="/images/home.jpg" alt="">&nbsp; 로그인 &nbsp;<img src="/images/mini_arw.jpg" alt="">&nbsp; 로그인</li>
        </ul>
    </div>
    <div class="contents">
        <div class="grayBgBox" style="border:0;">
            <img src="/images/logo.svg" alt="" class="endLogo">
            <div class="loginCont">
                <span class="loginTitle"></span>
                <ul class="loginInput">
                    <li>
                        <input type="text" id="txtId" placeholder="아이디">
                    </li>
                    <li>
                        <input type="password" id="txtPw" placeholder="비밀번호">
                    </li>
                </ul>
                <a href="javascript:doLogin()" class="loginBtn">로그인</a>
                <div class="memBox">
                    <input type="checkbox" name="checkbox" id="chkSaveId">
                    &nbsp;아이디저장
                </div>
                <div class="LogFindBtn">
                    <a href="find" class="id_Btn">아이디찾기</a>
                    <a href="find" class="">비밀번호찾기</a>
                </div>
            </div>
            <div class="loginTxt">
                <p class="q_B">포도컨트리클럽 회원이 아니세요?</p>
                <p>포도컨트리클럽 회원이 되시면 정회원 분들에게만 드리는 <br>이벤트 및 다양한 혜택을 받으실 수 있습니다.</p>
                <a href="join01" class="joinBtn">회원가입</a>
            </div>
        </div>
    </div><!-- contents End-->

</div>	<!-- wrap End -->
<%@ include file="../include/footer.jsp" %>
