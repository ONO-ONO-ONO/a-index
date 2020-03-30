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
//= require popper
//= require bootstrap
//= require rails-ujs
//= require activestorage
//= require_tree .

// 画面上部メニューの内容
$(function(){
  $('.top_menu-1').hover(function(){
  $('.top_menu-1').css('font-weight','bold');
  },function(){
  $('.top_menu-1').css('font-weight','normal');
  });
  $('.top_menu-2').hover(function(){
  $('.top_menu-2').css('font-weight','bold');
  },function(){
  $('.top_menu-2').css('font-weight','normal');
  });
  $('.top_menu-3').hover(function(){
  $('.top_menu-3').css('font-weight','bold');
  },function(){
  $('.top_menu-3').css('font-weight','normal');
  });
  $('.top_menu-4').hover(function(){
  $('.top_menu-4').css('font-weight','bold');
  },function(){
  $('.top_menu-4').css('font-weight','normal');
  });
});