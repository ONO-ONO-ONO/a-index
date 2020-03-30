$(function(){
  $(".test-1").text("じゃばばばば");
});

$(function(){
  $(".test-2").hover(function(){
    $('.test-2').css('color','red');
  },function(){
    $('.test-2').css('color','black');
  });
});