$(document).ready(function() {

  updateIssueListener();
  setColumnHeight();
  makeCardsSortable();
  makeCardsDraggable();

  $('input#search_repos').on ('keyup', function() {
    var value = $(this).val().toLowerCase();

    $('.repo-btn').each(function(){
      if ($(this).text().toLowerCase().includes(value)) {
        $(this).parent().show();
      } else {
        $(this).parent().hide();
      }
    });

  });
});

