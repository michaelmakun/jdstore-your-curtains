// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require jquery.raty
//= require bootstrap
//= require_tree .

//轮播图
$(document).ready(function () {
  $('#myCarousel').carousel({
    interval: 2000 //目前是2秒播放一张，可以根据需要调整这个值
  })
})

//带星的评论
$('.star-rating').raty({
  path: '/images',
  readOnly: true,
  score: function() {
        return $(this).attr('data-score');
  }
});
$('#star-rating').raty({
  path: '/images/',
  scoreName: 'review[rating]'
});


//网页下拉时导航栏部分内容固定在顶部
$(window).scroll(function () {

  if ($(this).scrollTop() > 200) {//当我们下拉超过200的时候
    if ($('.headerContent').is(':animated')) {
      return false
    }
    $('.headerContent').addClass('headerContent_fixed') // 让导航栏固定在顶部
    $('.headerContent').stop().animate({top: 0}, 600) // 在600ms内匀速慢慢出来
  } else {
    $('.headerContent').css({top: -80})
    $('.headerContent').removeClass('headerContent_fixed')
  }
})
