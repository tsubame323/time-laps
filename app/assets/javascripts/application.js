// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery

//= require jquery_ujs
//= require rails-ujs
//= require jquery.jscroll.min.js
//= require turbolinks


/* global $  Vue */
//= require_tree .


console.log("kitayo");




$(function(){
  var pos = 0;
  $(window).on('scroll', function(){
    if($(this).scrollTop() < pos ){
      //上スクロール時の処理を記述
      console.log("上");
      $(".menu-container").removeClass("fadeOutLeft");
      $(".menu-container").addClass("fadeInLeft");
    }else{
      //下スクロール時の処理を記述
      console.log("下");
      $(".menu-container").removeClass("fadeInLeft");
      $(".menu-container").addClass("fadeOutLeft");
    }
    //スクロールが停止した位置を保持
    pos = $(this).scrollTop();
  });

});
function checkSlick(){
  if (window.innerWidth < 768){
    $('.topImages2').not('.slick-initialized').slick({
        autoplay: true,
        arrows: false,
        slidesToShow: 1,
    });
} else{
  $('.topImages2.slick-initialized').slick("unslick")
}
}


//slidedown

$(function(){


  $('.slideButton').click(function(){
    //トグル
    $('.slideNone').slideToggle();
  });
});

//タブ移動
function checkJscroll(){
  if(window.innerWidth < 768){
        $('.jscroll').jscroll({
      contentSelector: '.folder',
    });
  }else{
    
  }
}



$(window).resize(function() {
  checkSlick()
});

  checkSlick()