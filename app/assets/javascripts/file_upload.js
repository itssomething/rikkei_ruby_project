$(document).ready(function() {
  $('body').on('change', 'input[type="file"]', function() {
    $('#file-name-span').text($(this)[0].files[0].name);
  });

  $('body').on('click', '#upload-exam-csv', function(e) {
    e.preventDefault();
    if($('input#file')[0].files.length == 1) {
      $('form').submit();
    } else {
      alert("Please choose a file to upload");
    }
  });

  $('body').on('keyup', '.form-group.with-error input', function() {
    if($(this).val().length > 0){
      $(this).parent().removeClass('with-error');
    }
  })
});
