$(document).ready(function() {
  $('body').on('click', '#popup-btn', function () {
    var popup = $('#popup');
    popup.addClass('pop-up-animation');
    setTimeout(function(){
      popup.removeClass('pop-up-animation');
    }, 3000);
  });
})
