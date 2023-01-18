<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<div class="middleBg6 zoomImg">
</div>
<ul class="mainMenuTitle text-focus-in">
<li class="big">Infomation</li>
<li>정보마당</li>
</ul>


<!-- 컨텐츠 시작 -->
<div id="wrap">
    <div class="navbarWrap">
        <ul class="navbarBox">
            <li class="on" onclick="location.href='/board/list'">공지사항</li>
            <li class="" onclick="location.href='/board/event'">이벤트</li>
            <li class="" onclick="location.href='/board/list'">보도자료</li>
            <li class="" onclick="location.href='/board/list'">자료실</li>
            <li class="" onclick="location.href='/board/honor'">홀인원</li>
            <li class="" onclick="location.href='/reservation/joinList'">조인게시판</li>
            <li class="" onclick="location.href='/board/list'">명예의 전당</li>

            <li class="homeBox"><img src="/images/home.jpg" alt="">&nbsp; 정보마당 &nbsp;<img src="/images/mini_arw.jpg" alt="">&nbsp; 공지사항</li>
        </ul>
    </div>
    <div class="contents">
        <div class="borderBox">
            <ul class="textInputBox">
                <li class="infoTitle"><span class="red">*</span> 제목</li>
                <li class="infoInputBox"><input type="text" class="titleInput"></li>
                <li class="infoTitle"><span class="red">* </span> 첨부파일</li>
                <li class="infoInputBox">
                    <input type="text" class="fileName" id="txtFileName2" readonly="readonly">
                    <label for="fileUpload2" class="btn_file file2">첨부파일찾기</label>
                    <input type="file" name="fileUpload2" id="fileUpload2" class="uploadBtn">
                    <span class="liTxt"> * 첨부파일은 최대 2개까지 등록이 가능합니다.</span>
                </li>
                <li class="infoTitle"></li>
                <li class="infoInputBox">
                    <input type="text" class="fileName" id="txtFileName2" readonly="readonly">
                    <label for="fileUpload2" class="btn_file file2">첨부파일찾기</label>
                    <input type="file" name="fileUpload2" id="fileUpload2" class="uploadBtn">
                </li>
            </ul>
            <div class="dotLine"></div>
            <textarea name="" id="" class="textInput"></textarea>
            <div class="btnBox" id="">
                <a href="" class="grayBtn">목록보기</a>
                <a href="" class="motion">등 록</a>
            </div>

        </div>
    </div>
</div><!-- contents End-->

</div>	<!-- wrap End -->
<%@ include file="../include/footer.jsp" %>