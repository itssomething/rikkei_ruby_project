// LOAD SAVED ANSWER FROM DATABASE WHEN OPEN TESTING TEST
$(document).ready(function() {
  if(window.location.href.includes('tests/') && $('#test-status-info').text().trim() == "Not tested") {
    console.log('1');
    var url = $('#main-content').attr('data-url');

    $.ajax({
      url: `${url}/test_answers`,
      method: 'get',
      data: {
        test_id: $('form').attr('action').slice(-1)[0]
      },
      dataType:'json'
    })
    .done(function (res) {
      res.forEach(function(obj) {
        var inputArr = $(`.question-area-id-${obj.question_id}`).find('input');
        console.log($(inputArr));
        $.each(inputArr, function(index, ele){
          if(obj.answer.includes($(ele).attr('value'))){
            $(ele).prop('checked', true);
          }
        });
      });
    });

  }

})
