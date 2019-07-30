$(document).on("turbolinks:load", function() {

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

//   $("form").on("click", ".remove_record", function(event) {
//     $(this).prev("input[type=hidden]").val("1");
//     $(this).closest("div.step").hide();
//     return event.preventDefault() ;

//   });
});
