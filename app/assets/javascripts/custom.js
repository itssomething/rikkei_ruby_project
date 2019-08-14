$(document).ready(function() {

  $("form").on("click", ".add-question", function(event) {
    pointer = $(this);
    append_field(pointer);
    event.preventDefault()
  });

  $("form").on("click", ".add-answer", function(event) {
    pointer = $(this);
    append_field(pointer);
    event.preventDefault()
  });

  function append_field(pointer) {
    var time = new Date().getTime();
    var regexp = new RegExp(pointer.data("id"), "g");
    var field =pointer.data('fields');
    var fid_display = field.substring(1, field.length-1);

    pointer.prev().append(fid_display.replace(regexp, time));
  }

  //  AJAX FOR RADIO BUTTON SELECTION
  $('body').on('click', '.radio', function (e) {
    var answerId = $(this).find('input').val();
    var questionId = $(this).find('input').attr('id').split('_')[1]
    var testId = window.location.href.split('/').slice(-1)[0];
    var url = $('#main-content').attr('data-url');

    $.ajax({
      url: `${url}/test_answers/${testId}`,
      // fix csrf header error blah blah
      beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
      method: 'put',
      data: {
        answers: answerId,
        question_id: questionId,
        test_id: testId
      }
    })
    .done(function () {
      console.log("1");
    })
  })

  // AJAX FOR CHECKBOX SELECTION
  $('body').on('change', '.checkbox input[type="checkbox"]', function(e) {
    if($(this).parent().parent().find('input[type=checkbox]:checked') != null){
      var answerArray = $(this).parent().parent().find('input[type=checkbox]:checked').map(function(){
        return $(this).val();
      }).get();

      var questionId = $(this).attr('id').split('_')[1];
      var testId = window.location.href.split('/').slice(-1)[0];
      var url = $('#main-content').attr('data-url');

      $.ajax({
        url: `${url}/test_answers/${testId}`,
        // fix csrf header error blah blah
        beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
        method: 'put',
        data: {
          answers: answerArray,
          question_id: questionId,
          test_id: testId
        }
      })
      .done(function () {
        console.log("1");
      });

      console.log(answerArray);
    }
  });
});

window.onload = function(){
	var navBarStatus = "open";

	document.getElementById('toggle-nav').addEventListener('click', function (event) {
		var sideBar = $('.sidebar2');
		var topBar = document.getElementById('top-bar');
    var mainContent = document.getElementById('main-content');

		if(navBarStatus=="open"){
      // sideBar.style.width = '0px';
      sideBar.addClass("collapsed");
      $('.sidebar2').addClass('collapsed');
			topBar.style.marginLeft = '60px';
      navBarStatus = 'close';
      mainContent.style.marginLeft = '60px';
		} else {
      // sideBar.style.width = '250px';
      sideBar.removeClass("collapsed");
      $('.sidebar2').removeClass('collapsed');
			topBar.style.marginLeft = '250px';
      navBarStatus = 'open';
      mainContent.style.marginLeft = '250px';
		}
  });

  if(window.location.href.includes('test')){
    var hourEle = document.getElementById('hour');
    var minEle = document.getElementById('min');
    var myInterval;

    setTimeout(function(){
      var myInterval = setInterval(function(){
        var min = minEle.innerHTML;
        var newMin = min - 1;

        if(newMin < 0 ){
          newMin = 59;
          hourEle.innerHTML = hourEle.innerHTML - 1;

          if(hourEle.innerHTML.length == 1){
            hourEle.innerHTML = "0" + hourEle.innerHTML;
          } else {

          }
        }

        if(newMin.toString().length == 1){
          newMin = "0" + newMin.toString()
        }
        minEle.innerHTML = newMin;
      }, 1000);
    }, 1000);

    setInterval(function(){
      var hour = hourEle.innerHTML;
      var min = minEle.innerHTML

      if(hour.toString() == "00" && min.toString() == "00"){
        // clearInterval(myInterval);
        var ele = document.getElementsByClassName('edit_test');
        var testForm = ele[0];
        testForm.submit();
      }
    }, 500);
  }
}
