
/* main toggle */
$(document).ready(function(){
	$('.toggle-menu').click (function(){
		$(this).toggleClass('active');
		$('#menu').toggleClass('open');
		$('.navBg').toggleClass('on');
	});
});



/*menuOnOff*/
function menuOnOff(f) {
	for(i=1; i<=6; i++) {
		if(i==f) {
			if($("#menu" + i).css("display") == "none") {
				$("#menu" + i).slideToggle(500);
			} else {
				$("#menu" + i).slideUp(500);
			}
		} else {
			$("#menu" + i).slideUp(500);
		}
	}
}

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