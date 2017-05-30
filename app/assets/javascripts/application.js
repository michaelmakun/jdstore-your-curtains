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
//= require 'china_city/jquery.china_city'

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

//放大镜
$('#preview').css('visibility', 'hidden')
var evt = new Event(),
    m = new Magnifier(evt);
m.attach({
    thumb: '#thumb',
    large: $('.intro-preview-activeItem img').attr('src'),
    largeWrapper: 'preview',
    zoom: 2
})

// 预览图选择
$(document).on('mouseover', '.productDetail-left-imageList-item', function () {
  var src = $(this).find('img').attr('src')
  $('.productDetail-left-bigImage img').attr('src', src)
    $('#thumb-lens').css('background-image', 'url(' + src + ')')
  $(this).addClass('intro-preview-activeItem').siblings().removeClass('intro-preview-activeItem')
  m.attach({
        thumb: '#thumb',
        large: src,
        largeWrapper: 'preview'
  })
})

$('.intro-preview-activeItem').trigger('mouseover')
$(document).on('mouseover', '.magnifier-thumb-wrapper', function (e) {
    $('#preview').css('visibility', 'visible')
})
$(document).on('mouseout', '.magnifier-thumb-wrapper', function (e) {
    $('#preview').css('visibility', 'hidden')
})
