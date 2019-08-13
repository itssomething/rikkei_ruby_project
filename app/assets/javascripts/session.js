$(document).ready(function() {
  $('body').on('click', '.sign-in-btn', function(e) {
    var form = document.getElementById('login-form');
    if(form != null){
      e.preventDefault();

      if(!form.checkValidity()){
        $.each($('.form-control'), function(index, element) {
          if($(element).val() == ''){
            $(element).removeClass('with-errors');
            $(element).nextAll('div').remove();
            $(element).addClass('with-errors');
            $(element).after('<div class="please-fill">Please fill out this field</div>');
          } else {
            $(element).removeClass('with-errors');
            $(element).nextAll('div').remove();
          }
        });
      } else {
        form.submit();
      }
    }
  })
});
