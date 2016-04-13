function repoSearchBox() {
  $('input#search_repos').on ('keyup', function() {
    var value = $(this).val().toLowerCase();

    $('.dropdown-menu').toggle()

    $('.repo-btn').each(function(){
      var repo_text = $(this).text().toLowerCase();

      if (repo_text.includes(value)) {
        $(this).parent().show();
      } else {
        $(this).parent().hide();
      }
    });

  });

}
