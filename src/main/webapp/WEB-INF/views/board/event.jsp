<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<link rel="stylesheet" type="text/css" href="/css/animate.css">
<script src="/js/wow.js"></script>
<script>
  new WOW().init();
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
        <ul class="navbarBox">
            <li class="" onclick="location.href='/board/list'">공지사항</li>
            <li class="on" onclick="location.href='/board/event'">이벤트</li>
            <li class="" onclick="location.href='/board/list'">보도자료</li>
            <li class="" onclick="location.href='/board/list'">자료실</li>
            <li class="" onclick="location.href='/board/honor'">홀인원</li>
            <li class="" onclick="location.href='/reservation/joinList'">조인게시판</li>
            <li class="" onclick="location.href='/board/list'">명예의 전당</li>

            <li class="homeBox"><img src="/images/home.jpg" alt="">&nbsp; 정보마당 &nbsp;<img src="/images/mini_arw.jpg" alt="">&nbsp; 이벤트</li>
        </ul>
    </div>
    <div class="contents">
        <div class="borderBox">
            <div class="serching">
                <ul>
                    <li>
                        <select name="Column" id="selSearchOption" class="select-arrow">
                            <option value="title" selected="">제목</option>
                            <option value="content">내용</option>
                            <option value="writer">작성자</option>
                        </select>
                    </li>
                    <li>
                        <input type="text" name="SearchString" id="txtSearchText" class="inputSerch" value="" title="검색할 내용">
                    </li>
                    <li><a href="javascript:doSearch()" class="darkGrayBtn serchBtn">검색</a></li>
                </ul>
                <div class="padding10"></div>
                <div class="galleryListBox">
                    <div class="galleryBox wow fadeInUp">
                        <a href="">
                            <div class="galImg"><img src="/images/main/mainBg01.jpg" alt=""></div>
                            <div class="gallery">																																					<div class="gallTitle">2021년도 라싸골프단(연단체)모집 안내</div>
                                <p class="gallDate">2020.09.22</p>
                                <span class="gallBtn">자세히보기</span>
                            </div>
                        </a>
                    </div>
                    <div class="galleryBox wow fadeInUp">
                        <a href="">
                            <div class="galImg"><img src="/images/main/mainBg01.jpg" alt=""></div>
                            <div class="gallery">																																					<div class="gallTitle">2021년도 라싸골프단(연단체)모집 안내</div>
                                <p class="gallDate">2020.09.22</p>
                                <span class="gallBtn">자세히보기</span>
                            </div>
                        </a>
                    </div>
                    <div class="galleryBox wow fadeInUp">
                        <a href="">
                            <div class="galImg"><img src="/images/main/mainBg01.jpg" alt=""></div>
                            <div class="gallery">																																					<div class="gallTitle">2021년도 라싸골프단(연단체)모집 안내</div>
                                <p class="gallDate">2020.09.22</p>
                                <span class="gallBtn">자세히보기</span>
                            </div>
                        </a>
                    </div>
                    <div class="galleryBox wow fadeInUp">
                        <a href="">
                            <div class="galImg"><img src="/images/main/mainBg01.jpg" alt=""></div>
                            <div class="gallery">																																					<div class="gallTitle">2021년도 라싸골프단(연단체)모집 안내</div>
                                <p class="gallDate">2020.09.22</p>
                                <span class="gallBtn">자세히보기</span>
                            </div>
                        </a>
                    </div>
                    <div class="galleryBox wow fadeInUp">
                        <a href="">
                            <div class="galImg"><img src="/images/main/mainBg01.jpg" alt=""></div>
                            <div class="gallery">																																					<div class="gallTitle">2021년도 라싸골프단(연단체)모집 안내</div>
                                <p class="gallDate">2020.09.22</p>
                                <span class="gallBtn">자세히보기</span>
                            </div>
                        </a>
                    </div>
                    <div class="galleryBox wow fadeInUp">
                        <a href="">
                            <div class="galImg"><img src="/images/main/mainBg01.jpg" alt=""></div>
                            <div class="gallery">																																					<div class="gallTitle">2021년도 라싸골프단(연단체)모집 안내</div>
                                <p class="gallDate">2020.09.22</p>
                                <span class="gallBtn">자세히보기</span>
                            </div>
                        </a>
                    </div>
                    <div class="galleryBox wow fadeInUp">
                        <a href="">
                            <div class="galImg"><img src="/images/main/mainBg01.jpg" alt=""></div>
                            <div class="gallery">																																					<div class="gallTitle">2021년도 라싸골프단(연단체)모집 안내</div>
                                <p class="gallDate">2020.09.22</p>
                                <span class="gallBtn">자세히보기</span>
                            </div>
                        </a>
                    </div>
                    <div class="galleryBox wow fadeInUp">
                        <a href="">
                            <div class="galImg"><img src="/images/main/mainBg01.jpg" alt=""></div>
                            <div class="gallery">																																					<div class="gallTitle">2021년도 라싸골프단(연단체)모집 안내</div>
                                <p class="gallDate">2020.09.22</p>
                                <span class="gallBtn">자세히보기</span>
                            </div>
                        </a>
                    </div>
                </div>


                <div class="padding10"></div>
                <div class="pageNum">
                    <div class="pageNumWrap">
                        <a href="" class="pagebtn">◀</a>
                        <a href="" class="on">1</a>
                        <a href="" class="">2</a>
                        <a href="" class="">3</a>
                        <a href="" class="">4</a>
                        <a href="" class="">5</a>
                        <a href="" class="pagebtn">▶</a>
                    </div>
                </div>

                <div class="btnBox">
                    <a href="" class="darkGrayBtn">글쓰기</a>
                </div>

            </div>
        </div>
    </div><!-- contents End-->

</div>	<!-- wrap End -->
<%@ include file="../include/footer.jsp" %>
