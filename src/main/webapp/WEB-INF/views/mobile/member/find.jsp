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
<div class="menuTabBox">
	<ul class="menuList">
		<li class="on" ><a href="/mobile/member/find">아이디찾기</a></li>
		<li class="" ><a href="/mobile/member/find2">비밀번호찾기</a></li>
	</ul>
</div>

<div class="contents">
	<ul class="commonTitle">
		<li class="title">아이디 찾기</li>
		<li class="midBar"></li>
	</ul>

	<ul class="loginBox">
		<li><input type="text" placeholder="이름" class="idInput" id="txtIdName" maxlength="30"></li>
		<li><input type="number" placeholder="핸드폰번호" class="pwInput" id="txtIdPhone" maxlength="11"></li>
	</ul>
	<a href="javascript:doFindId()" class="loginBtn">확인</a>
	
</div>	
<%@ include file="../include/footer.jsp" %>

