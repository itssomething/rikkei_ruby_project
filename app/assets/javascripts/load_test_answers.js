// LOAD SAVED ANSWER FROM DATABASE WHEN OPEN TESTING TEST
$(document).ready(function() {
  if(window.location.href.includes('tests/') && $('#test-status-info').text().trim() == "Not tested") {
    var url = $('#main-content').attr('data-url');
    var testId = $('form').attr('action').split('/')[$('form').attr('action').split('/').length - 1];
    $.ajax({
      url: `${url}/test_answers`,
      method: 'get',
      data: {
        test_id: testId
      },
      dataType:'json'
    })
    .done(function (res) {
      res.forEach(function(obj) {
        var inputArr = $(`.question-area-id-${obj.question_id}`).find('input');
        $.each(inputArr, function(index, ele){
          if(obj.answer.includes($(ele).attr('value'))){
            $(ele).prop('checked', true);
          }
        });
      });
    });

  }

})
