function repoSearchBox() {

  $("input#search_repos").on('keydown', function(event) {
    if (event.keyCode === 13 || event.keyCode === 32) {
      event.preventDefault();
    }

    $("input#search_repos").on('keyup', function(event) {
      if (event.which === 32) {
        this.value = this.value.replace(/\s/g, '');
        return false;
      }

      var value = $(this).val().toLowerCase();

      if (value.length === 0 && event.keyCode === 8) {
        $('#dropdown-repos-menu').hide();
      }

      if (value.length >= 1 && event.keyCode !== 8) {
        $('#dropdown-repos-menu').show();
      }

      $('.repo-btn').each(function(){
        var repo_text = $(this).text().toLowerCase();

        if (repo_text.includes(value)) {
          $(this).parent().parent().show();
        } else {
          $(this).parent().parent().hide();
        }
      });

    });

  });

}

