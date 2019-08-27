$(document).ready(function() {
  $('body').on('change', 'input[type="file"]', function() {
    $('#file-name-span').text($(this)[0].files[0].name);
  });

  $('body').on('click', '#upload-exam-csv', function(e) {
    e.preventDefault();
    var element = $('input#file')[0];
    var parentElement = $($('input#file')[0]).parent();
    if($('input#file')[0].files.length == 1) {
      $('form').submit();
    } else {
      $(element).removeClass('with-errors');
      $(element).nextAll('div.please-fill-file').remove();
      $(element).addClass('with-errors');
      $(parentElement).append('<div class="please-fill-file">Please choose a file</div>');
    }
  });

  $('body').on('keyup', '.form-group.with-error input', function() {
    if($(this).val().length > 0){
      $(this).parent().removeClass('with-error');
    }
  })
});
