$(document).ready(function() {
  $('body').on('change', 'input#file', function() {
    $('#file-name-span').text($(this)[0].files[0].name);
  })
});
