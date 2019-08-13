$(document).ready(function() {
  $('body').on('click', '.close', function(){
    $(this).closest('div[class$="field"').remove();
  });
});
