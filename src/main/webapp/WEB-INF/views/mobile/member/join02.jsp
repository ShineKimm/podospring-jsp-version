<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<script>

	let chkId = false;
	let chkPw = false;
	let chkPwConfirm = false;
	let certifyYn = false;
	let certifyKey = "";

	$(document).ready(function() {
		doSearchArea();

		$("#txtPw").change(function() {
			if ($("#txtPw").val() == null) {
				$("#txtPwInput").show();
			} else {
				$("#txtPwInput").hide();
			}
		});

		$("#txtPw").on("keyup", function() {
			onCheckPw();

			let pw = $("#txtPw").val();
			let pwConfirm = $("#txtPwConfirm").val();

			if(pwConfirm != "") {
				if(pw != pwConfirm) {
					chkPwConfirm = false;
					$("#txtPwConfirmMsg").show();
				} else {
					chkPwConfirm = true;
					$("#txtPwConfirmMsg").hide();
				}
			}
		});

		$("#txtPwConfirm").on("keyup", function() {
			let pw = $("#txtPw").val();
			let pwConfirm = $("#txtPwConfirm").val();

			if(pw != pwConfirm) {
				chkPwConfirm = false;
				$("#txtPwConfirmMsg").show();
			} else {
				chkPwConfirm = true;
				$("#txtPwConfirmMsg").hide();
			}
		});
	
		 $("#txtName").keyup(function(event) {
			if (!(event.keyCode >= 37 && event.keyCode <= 40)) {
			   let inputVal = $(this).val();
			   $(this).val(inputVal.replace(/[^(ㄱ-힣a-zA-Z\u318D\u119E\u11A2\u2022\u2025\u00B7\uFE55\u4E10\u3163\u3161)]/gi, ''));
			}
		 });
	})

	function doSignUp() {
		let sUrl = "/doSignUp";
		let params = {};

		//params["method"] = "doSignUp";

		let name = $("#txtName").val();
		let id = $("#txtId").val();
		let pw = $("#txtPw").val();
		let sex = $(':radio[name="chkSex"]:checked').val();
		let sms = $(':radio[name="chkSms"]:checked').val();
		let chkMail = $(':radio[name="chkMail"]:checked').val();
		let chkBirth = $(':radio[name="chkBirth"]:checked').val();
		let phone1 = $("#txtPhone").val().substring(0,3);
		let phone2 = $("#txtPhone").val().substring(3,7);
		let phone3 = $("#txtPhone").val().substring(7,11);
		let homeAddress1 = $("#txtHomeAddress1").val();
		let birth = $("#txtBirth").val();

		let pattern = /[~!@\#$%<>^&*]/;

		if(pattern.test(name)) {
				alert("이름을 확인하세요.");
				return;
		}
		if(!chkId) {
			alert("아이디를 확인해주세요.");
			return;
		}
		if(!chkPw || !chkPwConfirm) {
		  alert("비밀번호를 확인하세요.");
		  return;
		}
		if(!certifyYn) {
			alert("휴대폰인증 후 시도해주세요.");
			return;
		}
		if(name == "") {
			alert("이름을 입력해주세요.");
			return;
		}
		if(sex == null) {
			alert("성별을 선택해주세요.");
			return;
		}
		if(chkBirth == null) {
			alert("양력,음력을 선택해주세요.");
			return;
		}
		if(birth == null) {
			alert("생년월일을 입력해주세요.");
			return;
		}
		if (isDate(birth) != 0) {
			alert("생년월일을 정확히 입력해주세요.");
			return;
		}
		if(sms == null) {
			alert("SMS 수신여부를 입력해주세요.");
			return;
		}
		if(phone1 == "" || phone2 == "" || phone3 == "") {
			alert("핸드폰 번호를 입력해주세요.");
			return;
		}
		if(homeAddress1 == "") {
			alert("지역을 선택해주세요.");
			return;
		}
		if ($("#txtMail1").val() != "") {
			if ($("#txtMail3").val() == "9") {
				let email = $("#txtMail1").val() + "@" + $("#txtMail2").val();
			} else {
				let email = $("#txtMail1").val() + "@" + $("#txtMail3").val();
			}
		} else {
			let email = "";
		}

		params["coDiv"] = globals.coDiv;
		params["name"] = name.trim();
		params["id"] = id;
		params["pw"] = pw;
		params["sex"] = sex;
		params["sms"] = sms;
		params["phone1"] = phone1;
		params["phone2"] = phone2;
		params["phone3"] = phone3;
		params["mkt1"] = <%=request.getParameter("chkAgree3")%>;
		params["mkt2"] = <%=request.getParameter("chkAgree4")%>;
		params["mkt3"] = <%=request.getParameter("chkAgree5")%>;
		params["birth"] = birth;
		params["chkMail"] = chkMail;
		params["chkBirth"] = chkBirth;
		params["homeAddress1"] = homeAddress1;
		params["email"] = email;

		mAjax(sUrl, params, "POST", true, function(data) {
			if(data.resultCode == "0000") {
				alert("회원가입 되었습니다.");

	      location.href = "/mobile/member/login";
			} else {
				alert(data.resultMessage);
			}
		});
	}

	function chkDuplicateId() {
		let sUrl = "/chkDuplicateId";
		let params = {};

		//params["method"] = "chkDuplicateId";

		let id = $("#txtId").val();

		let pattern1 = /[0-9]/;
		let pattern2 = /[a-zA-Z]/;

		let chkCnt = 0;

		if(pattern1.test(id)) chkCnt += 1;
		if(pattern2.test(id)) chkCnt += 1;

		if(id == "") {
			$("#txtSucId").hide();
			$("#txtFailId").show();
			chkId = false;
			return;
		}

		if(chkCnt < 2) {
			$("#txtSucId").hide();
			$("#txtFailId").show();
			chkId = false;
			return;
		}

		if(id.length < 6 || id.length > 12) {
			$("#txtSucId").hide();
			$("#txtFailId").show();
			chkId = false;
			return;
		}

		params["id"] = id;

		mAjax(sUrl, params, "POST", true, function(data) {
			if(data.resultCode == "0000") {
				$("#txtSucId").show();
				$("#txtFailId").hide();
				chkId = true;
			} else if(data.resultCode = "1000") {
				$("#txtSucId").hide();
				$("#txtFailId").show();
				chkId = false;
			} else {
				alert(data.resultMessage);
			}
		});
	}

	function doCertification() {
		let sUrl = "/controller/MemberController";
		let params = {};

		//params["method"] = "doCertification";

		let phone1 = $("#txtPhone").val().substring(0,3);
		let phone2 = $("#txtPhone").val().substring(3,7);
		let phone3 = $("#txtPhone").val().substring(7,11);

		if(phone1 == "" || phone1.length != 3) {
			alert("휴대폰번호를 정확하게 입력하세요.");
			return;
		}
		if(phone2 == "" || phone2.length != 4) {
			alert("휴대폰번호를 정확하게 입력하세요.");
			return;
		}
		if(phone3 == "" || phone3.length != 4) {
			alert("휴대폰번호를 정확하게 입력하세요.");
			return;
		}

		certifyKey = Math.floor(Math.random() * 900000) + 100000;

		params["coDiv"] = globals.coDiv;
		params["certifyKey"] = certifyKey;
		params["phone"] = phone1 + phone2 + phone3;
		params["phone1"] = phone1;
		params["phone2"] = phone2;
		params["phone3"] = phone3;

		mAjax(sUrl, params, "POST", true, function(data) {
			if(data.resultCode == "0000") {
				alert("인증번호가 발송되었습니다.");
			} else if (data.resultCode == "9999") {
				alert(data.resultMessage);
				location.href = "find";
			} else {
				alert(data.resultMessage);
			}
		});
	}

	function doConfirmCertification() {
		let code = $("#txtCerCode").val();
		
		if (code == "") {
			alert("인증번호를 먼저 입력해주세요.")
		} else if(certifyKey == code) {
			certifyYn = "Y";

			$("#txtPhone").prop("disabled", true);
			$("#txtPhone").css("background", "#EAEAEA");
			$("#txtCerCode").prop("disabled", true);
			$("#txtCerCode").css("background", "#EAEAEA");
			$("#btnSend").click(function (e) {
				e.preventDefault();
			});
			$("#btnConfirm").click(function (e) {
				e.preventDefault();
			});
		} else {
			alert("인증번호가 잘못 되었습니다.")
		}
	}

	function onCheckPw() {
		let pw = $("#txtPw").val();

		let pattern1 = /[0-9]/;
		let pattern2 = /[a-zA-Z]/;
		let pattern3 = /[~!@#$%^*?]/;

		let chkCnt = 0;

		if(pattern1.test(pw)) chkCnt += 1;
		if(pattern2.test(pw)) chkCnt += 1;
		if(pattern3.test(pw)) chkCnt += 1;

		if(chkCnt < 3 || pw.length < 10 || pw.length > 20) {
	    $("#txtPwRuleMsg").show();
			chkPw = false;
			return;
		}

		$("#txtPwRuleMsg").hide();
		chkPw = true;
	}
	
	function onlyAlphabet(ele) {
	  ele.value = ele.value.replace(/[^\\!-z]/gi,"");
	}

	function onlyNumber(ele) {
	  ele.value = ele.value.replace(/[^0-9]/gi,"");
	}

	function selectMail(ele) {
		if (ele.value == "9") {
			$("#txtMail2").prop("disabled", false);
			$("#txtMail2").css("background", "#FFFFFF");
			$("#txtMail2").focus();
		} else {
			$("#txtMail2").prop("disabled", true);
			$("#txtMail2").css("background", "#EAEAEA");
		}
	}

	function doSearchArea() {
		let sUrl = "/getCommonCode";
		let params = {};

		//params["method"] = "getCommonCode";
		params["coDiv"] = globals.coDiv;
		params["division"] = "003";

		mAjax(sUrl, params, "POST", true, function(data) {
			if(data.resultCode == "0000") {
				rows = data.rows;
				let tbody = $("#txtHomeAddress1");
				tbody.empty();
				
				tbody.append("<option value=''>지역선택</option>")

				for(i=0; i<rows.length; i++) {

					let col1 = $("<option value='" + rows[i].CD_CODE + "'>" + rows[i].CD_TITLE1 + "</option>");

					tbody.append(col1)
				}
			} else {
				alert(data.resultMessage);
			}
		});
	}
		
	function isDate(yyyymmdd) { 
		// input 
		// yyyymmdd, yyyy-mm-dd, yyyy/mm/dd 
		// output 
		// 0: 정상, 1: 해당월의 날짜 넘음, 2: 존재하지 않는 달, 3: 포맷 안맞음, 4: -인 날짜 
		let y, m, d;
		if (yyyymmdd.length == 8) { 
			if (!yyyymmdd.match(/[0-9]{8}/g)) 
				return 3; 
			y = yyyymmdd.substring(0, 4); 
			m = yyyymmdd.substring(4, 6); 
			d = yyyymmdd.substring(6, 8); 
		} else if (yyyymmdd.length == 10) { 
			if (!yyyymmdd.match(/[0-9]{4}[-/][0-9]{2}[-/][0-9]{2}/g)) 
				return 3; 
			y = yyyymmdd.split('-')[0]; 
			m = yyyymmdd.split('-')[1]; 
			d = yyyymmdd.split('-')[2]; 
		} else { 
			return 3; 
		} 
		let limit_day;
		switch (eval(m)) { 
			case 1: 
			case 3: 
			case 5: 
			case 7: 
			case 8: 
			case 10: 
			case 12: 
				limit_day = 31; 
				break; 
			case 2: 
				if ((y - 2008) % 4 == 0) 
					limit_day = 29; 
				else 
					limit_day = 28; 
				break; 
			case 4: 
			case 6: 
			case 9: 
			case 11: 
				limit_day = 30; 
				break; 
			default: 
				return 2; 
				break; 
		} 
		if (eval(d) > limit_day) { 
			return 1; 
		} 
		if (eval(d) < 1) { 
			return 4; 
		} 
		return 0; 
	}

</script>
<div class="menuTabBox">
	<ul class="menuList">
		<li class="on" ><a href="/mobile/member/join01">회원가입</a></li>
		<li class="" ><a href="/mobile/member/login">로그인</a></li>
	</ul>
</div>

<div class="contents">
	
	<ul class="commonTitle">
		<li class="title">회원정보입력</li>
		<li class="midBar"></li>
	</ul>
	
	<p class="agreeTitle"><span class="brown">●</span>필수정보 입력</p>
	<table class="joinTable" summary="회원가입 기본정보 입력">
		<caption>회원가입 - 기본정보 입력</caption>
		<colgroup>
			<col width="25%">
			<col width="75%">
		</colgroup>

		<tbody>
			<tr>
				<th>이름</th>
				<td><input type="text" name="txtName" id="txtName" title="이름 입력" maxlength="20"></td>
			</tr>
			<tr>
				<th>성별</th>
				<td><label><input type="radio" name="chkSex" id="" title="남자 선택" value="1" checked> 남</label> &nbsp;&nbsp;<label><input type="radio" name="chkSex" id="" title="여자 선택" value="2"> 여</label></td>
			</tr>
			<tr>
				<th>아이디</th>
				<td><input type="hidden" name="IDChk_OK" value="N"><input type="text" name="txtId" id="txtId" title="아이디 입력" maxlength="12" onkeydown="onlyAlphabet(this)" onchange="chkDuplicateId()"><br/>
				<span id="txtFailId" class="red" style="font-size:13px;" hidden>사용할 수 없는 아이디 입니다.</span>
				<span id="txtSucId" class="blue" style="font-size:13px;" hidden>사용할 수 있는 아이디 입니다.</span></td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td><input type="password" name="txtPw" id="txtPw" title="비밀번호 입력" maxlength="20">
				<p>* 영문, 숫자, 특수문자[ ~!@#$%^*? 만 허용 ]를 사용하여 10~20자 이내로 입력</p>
				</td>
			</tr>
			<tr>
				<th>비밀번호 확인</th>
				<td><input type="password" name="txtPwConfirm" id="txtPwConfirm" title="비밀번호 확인" maxlength="20"><br/>
				<span id="txtPwConfirmMsg" class="red" style="; line-height:30px;" hidden>비밀번호가 일치하지 않습니다.</span></td>
			</tr>
			<tr>
				<th>생년월일</th>
				<td>
					<input type="input" name="txtBirth" id="txtBirth" title="연도 선택" class="phIp" maxlength="8" onkeydown="onlyNumber(this)" placeholder="ex)19810101">
					<label><input type="radio" name="chkBirth" id="" title="양력 선택" value="1"> 양력</label> &nbsp;&nbsp;<label><input type="radio" name="chkBirth" id="" title="음성 선택" value="2"> 음력</label>
				</td>
			</tr>
			<tr>
				<th>지역</th>
				<td>
					<select name="txtHomeAddress1" id="txtHomeAddress1" class="wp50 select-arrow">
					</select>
				</td>
			</tr>
			<tr>
				<th>휴대폰번호</th>
				<td>
					<input name="txtPhone" type="text" id="txtPhone" class="wp50" maxlength="11" title="휴대폰번호" placeholder="- 하이픈 없이 입력">
					<div onclick="doCertification();" id="btnSend" class="motion confirmBtn">인증번호 전송</div><br>
					<input name="txtCerCode" type="text" id="txtCerCode" class="wp50" maxlength="6" title="인증번호" placeholder="인증번호 입력">
					<div onclick="doConfirmCertification();" id="btnConfirm" class="motion confirmBtn"> 확인</div>
				</td>
			</tr>
			<tr>
				<th>문자 메시지 수신여부</th>
				<td>
					<label for="chkSms"><input value="Y" name="chkSms" type="radio">
					동의</label>
					&nbsp;
					<label for="chkSms"><input value="N" name="chkSms" type="radio">
					거부</label>
					<p>* 수신거부할 경우 예약 확인을 제외한 모든 메시지(그린피 할인, 공지사항 등)를 수신할 수 없습니다.</p>
				</td>
			</tr>
		</tbody>
	</table>
	<br><br>
	<p class="agreeTitle"><span class="brown">●</span>선택정보 입력</p>
	
	<table class="joinTable">
		<colgroup>
			<col width="15%">
			<col>
		</colgroup>
		<tbody>
			<tr>
				<th>메일 주소</th>
				<td title="메일주소">
					<input name="txtMail1" type="text" id="txtMail1" class="wp25" maxlength="20">
					@
					<input name="txtMail2" type="text" id="txtMail2" class="wp25" maxlength="25">
					<select name="txtMail3" id="txtMail3" class="wp38 select-arrow" onchange="selectMail(this);">
						<option value="9">직접입력</option>
						<option value="chollian.net">chollian.net</option>
						<option value="daum.net">hanmail.net</option>
						<option value="dreamwiz.com">dreamwiz.com</option>
						<option value="empal.com">empal.com</option>
						<option value="hanafos.com">hanafos.com</option>
						<option value="hanmir.net">hanmir.net</option>
						<option value="hitel.com">hitel.com</option>
						<option value="hotmail.com">hotmail.com</option>
						<option value="korea.com">korea.com</option>
						<option value="lycos.co.kr">lycos.co.kr</option>
						<option value="nate.com">nate.com</option>
						<option value="naver.com">naver.com</option>
						<option value="netian.com">netian.com</option>
						<option value="sayclub.com">sayclub.com</option>
						<option value="unitel.co.kr">unitel.co.kr</option>

					</select>
				</td>
			</tr>
			<tr>
				<th>이메일 수신여부</th>
				<td>
					<label for="EmailAgree1"><input value="Y" name="chkMail" type="radio" id="EmailAgree1">
					동의</label>
					&nbsp;
					<label for="EmailAgree2"><input value="N" name="chkMail" type="radio" id="EmailAgree2">
					거부</label>
				</td>
			</tr>
		</tbody>
</table>
	
	<div class="btnBox">
		<a href="javascript:doSignUp();" class="motion">회원가입</a>
		<a href="/mobile/index" class="cancel">취소</a>
	</div>

</div>	
<%@ include file="../include/footer.jsp" %>
