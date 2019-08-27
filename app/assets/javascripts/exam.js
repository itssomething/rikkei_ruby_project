$(document).ready(function() {
  $('body').on('click', '.close', function(){
    $(this).closest('div[class$="field"').remove();
  });

  $('body').on('click', '.exam-delete-btn', function(){
    swal({
      title: "Are you sure?",
      text: "Once deleted, you will not be able to recover this imaginary file!",
      icon: "warning",
      buttons: true,
      dangerMode: true,
    })
    .then((willDelete) => {
      if (willDelete) {
        var examId = $(this).attr('data-id');
        var categoryId = $(this).attr('data-category-id');
        $.ajax({
          beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
          url: `/categories/${categoryId}/exams/${examId}`,
          method: 'delete',
          data: {
            id: examId
          }
        })
        .done(function(){
          swal("Poof! Your imaginary file has been deleted!", {
            icon: "success",
          });
        })
      } else {
        swal("Your imaginary file is safe!");
      }
    });
  });
});



