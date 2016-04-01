function updateIssueListener() {

  $('.dropdown-menu input, .dropdown-menu label').click(function(e) {
    e.stopPropagation();
  });

  $('.form').on('keydown', function(e) {
    if(!(e.keyCode == 13 && e.metaKey)) return;

    var target = e.target;

    if(target.form) {
      target.form.submit();
    }

  });

}

