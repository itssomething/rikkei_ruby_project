$(document).on("turbolinks:load", function() {

  $("form").on("click", ".add_field", function(event) {
    var time = new Date().getTime();
    var regexp = new RegExp($(this).data("id"), "g");
    var field =$(this).data('fields');

    $(this).prev().append($(this).data("fields").replace(regexp, time));
    event.preventDefault()
  });

//   $("form").on("click", ".remove_record", function(event) {
//     $(this).prev("input[type=hidden]").val("1");
//     $(this).closest("div.step").hide();
//     return event.preventDefault() ;

//   });
});
