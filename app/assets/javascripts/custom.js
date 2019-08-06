$(document).ready(function() {

  $("form").on("click", ".add-question", function(event) {
    console.log("c");
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

});

window.onload = function(){
	var navBarStatus = "open";

	document.getElementById('toggle-nav').addEventListener('click', function (event) {
		var sideBar = document.getElementById('mySidebar');
		var topBar = document.getElementById('top-bar');
    var mainContent = document.getElementById('main-content');

		if(navBarStatus=="open"){
      // sideBar.style.width = '0px';
      sideBar.classList.add("collapsed");
			topBar.style.marginLeft = '60px';
      navBarStatus = 'close';
      mainContent.style.marginLeft = '60px';
		} else {
      // sideBar.style.width = '250px';
      sideBar.classList.remove("collapsed");
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

        // if(min == "00" && hourEle.innerHTML == "01"){
        //   clearInterval(myInterval);
        // }
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
      console.log("a");
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
