/* submenu */
$(function($){
		$('#mainGnb').mouseover(function(){
			$('*').stop();
			$('#scrollmenu').hide().slideDown("slow")
		})
		$('#scrollmenu').mouseleave(function(){
			$('*').stop();
			$('#scrollmenu').slideUp(1000)
		})
	})

$(function($){
		$('.gnbBtn').mouseover(function(){
			$('*').stop();
			$('#scrollmenu2').hide().slideDown("slow")
		})
		$('#scrollmenu2').mouseleave(function(){
			$('*').stop();
			$('#scrollmenu2').slideUp(1000)
		})
	})

$(function($){
		$('.mainList').mouseover(function(){
			$('*').stop();
			$('#scrollmenu2').hide().slideDown("slow")
		})
		$('#scrollmenu2').mouseleave(function(){
			$('*').stop();
			$('#scrollmenu2').slideUp(1000)
		})
})
			
/*layer_popup*/
var openFdx = -1;

    function fpopupOpen(i) {
        initFPopup(i);
    }

    function initFPopup(i) {
        var fW = $(window).width() / 2;
        var fH = $(window).height() / 2;
        var cW = Number($("#fpop" + i).css("width").replace("px", "")) / 2;
        var cH = Number($("#fpop" + i).css("height").replace("px", "")) / 2;
        var mW = fW - cW;
        var mH = fH - cH;

        $("#fpop" + i).css("left", mW);
        $("#fpop" + i).css("top", mH);

        $("#fpop" + i).css("display", "block");
        $("#overlay1").css("display", "block");

		openFdx = i;
    }

    function popupFClose(i) {
        $("#fpop" + i).css("display", "none");
        $("#overlay1").css("display", "none");
    }

    function popupFOverlayClicked() {
		if(openFdx > 0){
			$("#fpop" + openFdx).css("display", "none");
			$("#overlay1").css("display", "none");
		}
    }


/*main_all_menu*/
$(document).ready(function(){
	$('.toggleMenu').click (function(){
		$(this).toggleClass('active');
		$('#menu').toggleClass('open');
	});
});


	/*headerChageFix*/
	$(window).on("scroll", function() {
		if ($(window).scrollTop() >= 100) {
			$(".siteAll .toggleMenu span").addClass("move");
			$(".headerBox").addClass("move");
			$(".header").addClass("move");
			$("#header").addClass("move");
			$(".topJoin").addClass("move");
			$(".mainList").addClass("move");
			$(".nav>ul>li>a").addClass("move");
			$(".silkriver").addClass("move");
			$("#logo").removeClass("logoBox");
			$("#login").removeClass("topLogin");
			$("#logo").addClass("logoBox2");
			$("#login").addClass("topLogin2"); 

		}else{
			$(".siteAll .toggleMenu span").removeClass("move");
			$(".headerBox").removeClass("move");
			$(".header").removeClass("move");
			$("#header").removeClass("move");
			$(".topJoin").removeClass("move");
			$(".mainList").removeClass("move");
			$(".nav>ul>li>a").removeClass("move");
			$(".silkriver").removeClass("move");
			$("#logo").removeClass("logoBox2");
			$("#login").removeClass("topLogin2");
			$("#logo").addClass("logoBox");
			$("#login").addClass("topLogin");
		}
	});

/* scroll top script  */
$(document).ready(function(){

// hide first
$("#topArrow").hide();

// fade in
$(function () {
	$(window).scroll(function () {
		if ($(this).scrollTop() > 100) {
		$('#topArrow').fadeIn();
		} else {
		$('#topArrow').fadeOut();
		}
	});

	// scroll body to 0px on click
	$('topArrow').click(function () {
		$('body,html').animate({
		scrollTop: 0
		}, 800);
		return false;
		});
	});

});

/* navbarWrap categori choice */
$(function(){
	var $layer = $("#categori");
	var $current = $("#categoriSelect");
	var $curli = $("#categoriSelect li");

	$layer.on('click',function(){
		$current.slideToggle("fast");
	});


	 if($current){

		 if(!$curli.hasClass("selected"))
			 $curli.first().addClass("selected");

		 $curli.click(function(e){
			var inx = parseInt($(this).index()) +1 ;

			$('#categori').text($(this).text());

			$(e.currentTarget).addClass("selected").siblings().removeClass("selected");
			$current.hide();
		 });

	 }//end if

});

$(function(){
	var $layer = $("#categori2");
	var $current = $("#categoriSelect2");
	var $curli = $("#categoriSelect2 li");

	$layer.on('click',function(){
		$current.slideToggle("fast");
	});


	 if($current){

		 if(!$curli.hasClass("selected"))
			 $curli.first().addClass("selected");

		 $curli.click(function(e){
			var inx = parseInt($(this).index()) +1 ;

			$('#categori2').text($(this).text());

			$(e.currentTarget).addClass("selected").siblings().removeClass("selected");
			$current.hide();
		 });

	 }//end if

});



/*--------- calendar ----------*/
$(document).ready(function() {
     $("#show_hide").click(function () {
     $(".monthBox").slideToggle();
  });
});

$(document).ready(function() {
     $("#show_hideSub1").click(function () {
     $(".SubMonthBox1").slideToggle();
  });
});
$(document).ready(function() {
     $("#show_hideSub2").click(function () {
     $(".SubMonthBox2").slideToggle();
  });
});
$(document).ready(function() {
     $("#show_hideSub3").click(function () {
     $(".SubMonthBox3").slideToggle();
  });
});

$(document).ready(function() {
     $("#show_hideSub4").click(function () {
     $(".SubMonthBox4").slideToggle();
  });
});
$(document).ready(function() {
     $("#show_hideSub5").click(function () {
     $(".SubMonthBox5").slideToggle();
  });
});



/* index Course Choice */
 $(function() {

    var $container	= $('.courseBtnBox'),
        $articles	= $container.children('.courseBtn'),
        timeout;

    $articles.on( 'mouseenter', function( event ) {
        var $article	= $(this);
        clearTimeout( timeout );
        timeout = setTimeout( function() {
            if( $article.hasClass('active') ) return false;
            $articles.not( $article.removeClass('blur').addClass('active') )
                     .removeClass('active')
                     .addClass('blur');
        }, 65 );
    });
    $container.on( 'mouseleave', function( event ) {
        clearTimeout( timeout );
        $articles.removeClass('active blur');
    });
});

/*

 $(document).ready(function(){
 	$('.choiceCalendar2').click(function(){
 		$(this).toggleClass('open');
 		 $(".openCalendar2").slideToggle();
 	});
 });
*/

/* membership */
$(document).ready(function(){
  $(".papersTitle.ppBtn1").click(function(){
    $(".papersCont1").toggle();
  });
  $(".arrowBtn.btn1").click(function(){
    $(".papersCont1").toggle();
  });
});


$(document).ready(function(){
  $(".papersTitle.ppBtn2").click(function(){
    $(".papersCont2").toggle();
  });
  $(".arrowBtn.btn2").click(function(){
    $(".papersCont2").toggle();
  });
});

$(document).ready(function(){
  $(".papersTitle.ppBtn3").click(function(){
    $(".papersCont3").toggle();
  });
  $(".arrowBtn.btn3").click(function(){
    $(".papersCont3").toggle();
  });
});

$(document).ready(function(){
  $(".papersTitle.ppBtn4").click(function(){
    $(".papersCont4").toggle();
  });
  $(".arrowBtn.btn4").click(function(){
    $(".papersCont4").toggle();
  });
});

$(document).ready(function(){
  $(".papersTitle.ppBtn5").click(function(){
    $(".papersCont5").toggle();
  });
  $(".arrowBtn.btn5").click(function(){
    $(".papersCont5").toggle();
  });
});

$(document).ready(function(){
  $(".papersTitle.ppBtn6").click(function(){
    $(".papersCont6").toggle();
  });
  $(".arrowBtn.btn6").click(function(){
    $(".papersCont6").toggle();
  });
});

$(document).ready(function(){
  $(".papersTitle.ppBtn7").click(function(){
    $(".papersCont7").toggle();
  });
  $(".arrowBtn.btn7").click(function(){
    $(".papersCont7").toggle();
  });
});

$(document).ready(function(){
  $(".papersTitle.ppBtn8").click(function(){
    $(".papersCont8").toggle();
  });
  $(".arrowBtn.btn8").click(function(){
    $(".papersCont8").toggle();
  });
});

$(document).ready(function(){
  $(".papersTitle.ppBtn9").click(function(){
    $(".papersCont9").toggle();
  });
  $(".arrowBtn.btn9").click(function(){
    $(".papersCont9").toggle();
  });
});

$(document).ready(function(){
  $(".papersTitle.ppBtn10").click(function(){
    $(".papersCont10").toggle();
  });
  $(".arrowBtn.btn10").click(function(){
    $(".papersCont10").toggle();
  });
});

$(document).ready(function(){
  $(".papersTitle.ppBtn11").click(function(){
    $(".papersCont11").toggle();
  });
  $(".arrowBtn.btn11").click(function(){
    $(".papersCont11").toggle();
  });
});

$(document).ready(function(){
  $(".papersTitle.ppBtn12").click(function(){
    $(".papersCont12").toggle();
  });
  $(".arrowBtn.btn12").click(function(){
    $(".papersCont12").toggle();
  });
});



/* history */
function historyTab(number) {
		if (number == "1") {
			$(".historyTab1").attr("style",'display:block');
			$(".historyTab2").attr("style",'display:none');
			$(".historyTab3").attr("style",'display:none');
			$(".historyTab4").attr("style",'display:none');
			$(".historyTab5").attr("style",'display:none');
			$(".historyTab6").attr("style",'display:none');
			$(".historyTab7").attr("style",'display:none');
			$(".historyTab8").attr("style",'display:none');
		} else if (number == "2") {
			$(".historyTab1").attr("style",'display:none');
			$(".historyTab2").attr("style",'display:block');
			$(".historyTab3").attr("style",'display:none');
			$(".historyTab4").attr("style",'display:none');
			$(".historyTab5").attr("style",'display:none');
			$(".historyTab6").attr("style",'display:none');
			$(".historyTab7").attr("style",'display:none');
			$(".historyTab8").attr("style",'display:none');
		} else if (number == "3") {
			$(".historyTab1").attr("style",'display:none');
			$(".historyTab2").attr("style",'display:none');
			$(".historyTab3").attr("style",'display:block');
			$(".historyTab4").attr("style",'display:none');
			$(".historyTab5").attr("style",'display:none');
			$(".historyTab6").attr("style",'display:none');
			$(".historyTab7").attr("style",'display:none');
			$(".historyTab8").attr("style",'display:none');
		} else if (number == "4") {
			$(".historyTab1").attr("style",'display:none');
			$(".historyTab2").attr("style",'display:none');
			$(".historyTab3").attr("style",'display:none');
			$(".historyTab4").attr("style",'display:block');
			$(".historyTab5").attr("style",'display:none');
			$(".historyTab6").attr("style",'display:none');
			$(".historyTab7").attr("style",'display:none');
			$(".historyTab8").attr("style",'display:none');
		} else if (number == "5") {
			$(".historyTab1").attr("style",'display:none');
			$(".historyTab2").attr("style",'display:none');
			$(".historyTab3").attr("style",'display:none');
			$(".historyTab4").attr("style",'display:none');
			$(".historyTab5").attr("style",'display:block');
			$(".historyTab6").attr("style",'display:none');
			$(".historyTab7").attr("style",'display:none');
			$(".historyTab8").attr("style",'display:none');
		} else if (number == "6") {
			$(".historyTab1").attr("style",'display:none');
			$(".historyTab2").attr("style",'display:none');
			$(".historyTab3").attr("style",'display:none');
			$(".historyTab4").attr("style",'display:none');
			$(".historyTab5").attr("style",'display:none');
			$(".historyTab6").attr("style",'display:block');
			$(".historyTab7").attr("style",'display:none');
			$(".historyTab8").attr("style",'display:none');
		} else if (number == "7") {
			$(".historyTab1").attr("style",'display:none');
			$(".historyTab2").attr("style",'display:none');
			$(".historyTab3").attr("style",'display:none');
			$(".historyTab4").attr("style",'display:none');
			$(".historyTab5").attr("style",'display:none');
			$(".historyTab6").attr("style",'display:none');
			$(".historyTab7").attr("style",'display:block');
			$(".historyTab8").attr("style",'display:none');
		} else if (number == "8") {
			$(".historyTab1").attr("style",'display:none');
			$(".historyTab2").attr("style",'display:none');
			$(".historyTab3").attr("style",'display:none');
			$(".historyTab4").attr("style",'display:none');
			$(".historyTab5").attr("style",'display:none');
			$(".historyTab6").attr("style",'display:none');
			$(".historyTab7").attr("style",'display:none');
			$(".historyTab8").attr("style",'display:block');
		}
	}

	/* fee */
function feeTab(number) {
		if (number == "1") {
			$(".feeTab1").attr("style",'display:block');
			$(".feeTab2").attr("style",'display:none');
			$(".feeTab3").attr("style",'display:none');
		} else if (number == "2") {
			$(".feeTab1").attr("style",'display:none');
			$(".feeTab2").attr("style",'display:block');
			$(".feeTab3").attr("style",'display:none');
		}
		else if (number == "3") {
			$(".feeTab1").attr("style",'display:none');
			$(".feeTab2").attr("style",'display:none');
			$(".feeTab3").attr("style",'display:block');
		}
	}
