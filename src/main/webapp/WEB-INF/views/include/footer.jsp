<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!--textmotion-->
<script src="/js/ScrollTrigger.js"></script>
<script>
  window.counter = function($) {
    // this refers to the html element with the data-scroll-showCallback tag
    let span = this.querySelector('span');
    let current = parseInt(span.textContent);
    span.textContent = current + 1;
  };

  document.addEventListener('DOMContentLoaded', function($){
    let trigger = new ScrollTrigger({
      addHeight: true
    });
  });
</script>
<!-- footer 영역 -->
<div id="footerWrap">
    <div class="footerBox">
        <img src="/images/f_logo.png" alt="" class="logo_g">
        <!--<ul class="snsLink">
            <li class=""><a href="javascript:alert('준비중입니다.')"><img src="/images/sns_f.png" alt=""></a></li>
            <li class=""><a href="javascript:alert('준비중입니다.')"><img src="/images/sns_t.png" alt=""></a></li>
            <li class=""><a href="javascript:alert('준비중입니다.')"><img src="/images/sns_i.png" alt=""></a></li>
        </ul>-->
        <ul class="termsBox">
            <li class=""><a href="/member/clause">사이트 이용약관</a></li>
            <li class="bar"></li>
            <li class=""><a href="/member/policy">개인정보처리방침</a></li>
            <li class="bar"></li>
            <li class=""><a href="/member/email">이메일무단수집거부</a></li>
        </ul>
        <p class="addBox">
            경상북도 김천시 구성면 남김천대로 2532    예약문의 : 054-420-0200    대표전화 : 054-420-0200    대표 FAX : 054-420-0239 <br>
            사업자등록번호 : 262-85-01133    통신판매업 제2019-경북김천-0249호    주식회사 다옴 대표이사 : 이세홍  <br>
            <br><br>
            Copyright ⓒ 2019 Podo Country Club All rights reserverd.
        </p>
    </div>
    <p id="topArrow" style=""><a href="#top"></a></p>
</div>

</body>
</html>