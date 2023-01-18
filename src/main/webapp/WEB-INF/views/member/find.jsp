<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<script>
  $(document).ready(function() {
    init();
  });

  function init() {
    $("#txtIdName").keypress(function (event) {
      if(event.keyCode == 13) {
        doFindId();
      }
    });
    $("#txtIdPhone").keypress(function (event) {
      if(event.keyCode == 13) {
        doFindId();
      }
    });
    $("#txtPwName").keypress(function (event) {
      if(event.keyCode == 13) {
        doFindPw();
      }
    });
    $("#txtPwId").keypress(function (event) {
      if(event.keyCode == 13) {
        doFindPw();
      }
    });
  }

  function doFindId() {
    let sUrl = "/doFindId";
    let params = {};

    //params["method"] = "doFindId";
    params["coDiv"] = globals.coDiv;

    let name = $("#txtIdName").val();
    let phone = $("#txtIdPhone").val();

    if(name == "") {
      alert("이름을 입력하세요.");
      return;
    }

    if(phone == "") {
      alert("핸드폰번호를 입력하세요.");
      return;
    }

    params["name"] = name;
    params["phone"] = phone;

    mAjax(sUrl, params, "GET", true, function(data) {
      alert(data.resultMessage);
    });
  }

  function doFindPw() {
    let sUrl = "/doFindPw";
    let params = {};

    //params["method"] = "doFindPw";
    params["coDiv"] = globals.coDiv;

    let name = $("#txtPwName").val();
    let id = $("#txtPwId").val();

    if(name == "") {
      alert("이름을 입력하세요.");
      return;
    }

    if(id == "") {
      alert("아이디를 입력하세요.");
      return;
    }

    params["name"] = name;
    params["id"] = id;

    mAjax(sUrl, params, "POST", true, function(data) {
      alert(data.resultMessage);
    });
  }

</script>
<div class="middleBg6 zoomImg">
</div>
<ul class="mainMenuTitle text-focus-in">
    <li class="big">Join Membership</li>
    <li>회원가입</li>
</ul>

<!-- 컨텐츠 시작 -->
<div id="wrap">
    <div class="navbarWrap">
        <ul class="navbarBox">
            <li class="" onclick="location.href='/member/login'">로그인</li>
            <li class="" onclick="location.href='/member/join01'">회원가입</li>
            <li class="on" onclick="location.href='/member/find'">아이디/비번찾기</li>
            <li class="" onclick="location.href='/member/modify'">정보수정</li>
            <li class="" onclick="deleteMember();">가입탈퇴</li>
            <li class="homeBox"><img src="/images/home.jpg" alt="">&nbsp; 회원가입 &nbsp;<img src="/images/mini_arw.jpg" alt="">&nbsp; 아이디/비번찾기</li>
        </ul>
    </div>
    <div class="contents">
        <div class="grayBgBox" style="border:0;">
            <img src="/images/findIcon.png" alt="그림" class="keyImg">

            <div class="findBox">
                <div class="findId">
                    <span class="findTitle">아이디 찾기</span>
                    <div class="findIpBox">
                        <ul class="loginInput">
                            <li>
                                <input type="text" placeholder="이름" id="txtIdName" maxlength="30">
                            </li>
                            <li>
                                <input type="number" placeholder="휴대폰번호" id="txtIdPhone" maxlength="11">
                            </li>
                        </ul>
                        <a href="javascript:doFindId()" class="findBtn">확 인</a>
                    </div>
                </div>

                <div class="findId pw">
                    <span class="findTitle">비밀번호 찾기</span>
                    <div class="findIpBox">
                        <ul class="loginInput">
                            <li>
                                <input type="text" placeholder="이름" id="txtPwName" maxlength="30">
                            </li>
                            <li>
                                <input type="text" placeholder="아이디" id="txtPwId" maxlength="30">
                            </li>
                        </ul>
                        <a href="javascript:doFindPw()" class="findBtn">확 인</a>
                    </div>
                </div>
            </div>
            <div class="findTxt">
                <p class="findGreen">포도컨트리클럽 회원이 아니세요?</p>
                <p>포도컨트리클럽 회원이 되시면 정회원 분들에게만 드리는 <br>이벤트 및 다양한 혜택을 받으실 수 있습니다.</p>

            </div>
            <div class="btnBox">
                <a href="/member/join01" class="cancel">회원가입</a>
            </div>

        </div>
    </div>
</div><!-- contents End-->

</div>	<!-- wrap End -->
<%@ include file="../include/footer.jsp" %>
