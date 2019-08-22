$(document).ready(function() {
  $('body').on('click', 'input[type="submit"]', function(e){
    var form = document.getElementsByTagName('form')[0];
    if(form != null){
      e.preventDefault();

      if(!form.checkValidity()){
        $.each($('.form-control[required="required"]'), function(index, element) {
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
  });

  function passwordMatchValidation(){
    var passwordField = $('input[type="password"][id="user_password"]');
    var passwordFieldConfirm = $('input[type="password"][id="user_password_confirmation"]');

    if($(passwordField).val() != $(passwordFieldConfirm).val()){
      clearError(passwordField);
      clearError(passwordFieldConfirm);
      $('input[type="password"]').addClass('with-errors');
      $(passwordField).after('<div class="please-fill">Password and password confirmation mismatch</div>');
      $(passwordFieldConfirm).after('<div class="please-fill">Password and password confirmation mismatch</div>');
    } else {
      $(passwordField).removeClass('with-errors');
      $(passwordField).nextAll('div').remove();
      $(passwordFieldConfirm).removeClass('with-errors');
      $(passwordFieldConfirm).nextAll('div').remove();
    }
  }

  function clearError(element) {
    $(element).removeClass('with-errors');
    $(element).nextAll('div').remove();
  }

  $('body').on('keyup', '[id="user_password"]', function(e){
    var passwordFieldConfirm = $('input[type="password"][id="user_password_confirmation"]');

    if($(passwordFieldConfirm).val().length > 0){
      passwordMatchValidation();
    }
  })

  $('body').on('keyup', '[id="user_password_confirmation"]', function(e){
    passwordMatchValidation();
  });

  $('body').on('click', 'button#edit_user_submit', function(e) {
    e.preventDefault();
    form = document.getElementsByTagName('form')[0]

    if(form.checkValidity() && $('input[type="password"][id="user_password"]').val() == $('input[type="password"][id="user_password_confirmation"]').val()){
      form.submit()
    } else {
      return false;
    }
  })
})
