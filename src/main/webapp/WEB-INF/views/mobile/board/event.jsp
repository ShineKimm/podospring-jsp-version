<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<div class="menuTabBox">
	<ul class="menuList">
		<li class="" ><a href="/mobile/board/list">공지사항</a></li>
		<li class="on" ><a href="/mobile/board/event">이벤트</a></li>
		<li class="" ><a href="/mobile/board/honor">홀인원</a></li>
		<li class="" ><a href="/mobile/board/joinList">조인게시판</a></li>
	</ul>
</div>

<link rel="stylesheet" type="text/css" href="/mobile/css/animate.css">
<script src="/mobile/js/wow.js"></script>
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
<div class="contents">
	<ul class="commonTitle">
		<li class="title">이벤트</li>
		<li class="midBar"></li>
	</ul>

	<div class="galleryListBox">
        <div class="galleryBox fadeBox fadeInUp">	 
            <div class="gallBoxCont">
                <a href="#">
                <div class="galImg">
                    <img src="/mobile/images/introImg1.jpg" alt="">
                </div>			
                <div class="gallery">				
                    <div class="gallTitle">2021 포도C.C 리뉴얼</div>				
                    <p class="gallDate">2021.03.01</p>				
                    <span class="gallBtn">자세히보기</span>			
                </div>		
                </a>	
            </div>
        </div>
        
        <div class="galleryBox fadeBox fadeInUp">	 
            <div class="gallBoxCont">
                <a href="#">
                <div class="galImg">
                    <img src="/mobile/images/introImg1.jpg" alt="">
                </div>			
                <div class="gallery">				
                    <div class="gallTitle">2021 포도C.C 리뉴얼</div>				
                    <p class="gallDate">2021.03.01</p>			
                    <span class="gallBtn">자세히보기</span>			
                </div>		
                </a>	
            </div>
        </div>
        
        <div class="galleryBox fadeBox fadeInUp">	 
            <div class="gallBoxCont">
                <a href="#">
                <div class="galImg">
                    <img src="/mobile/images/introImg1.jpg" alt="">
                </div>			
                <div class="gallery">				
                   <div class="gallTitle">2021 포도C.C 리뉴얼</div>				
                    <p class="gallDate">2021.03.01</p>				
                    <span class="gallBtn">자세히보기</span>			
                </div>		
                </a>	
            </div>
        </div>
		<div class="padding10"></div>
		<div class="pageNum">
			<a class="pagebtn">◀</a>
				<span class="pageNumWrap">
					<a href="" class="on">1</a>
					<a href="">2</a>
					<a href="">3</a>
					<a href="">4</a>
				</span>
			<a class="pagebtn">▶</a>
		</div>

	
</div>	
<%@ include file="../include/footer.jsp" %>
