$(document).ready(function() {

  function updateIssueLabels() {

    debugger;
    $.ajax({
      type: "POST",

      url: '/update_issue_labels',
      data: { owner: owner,
        repo: repo,
        number: number,
        oldcolumn: oldColumn,
        newcolumn: newColumn,
      },

      success: function(post) {
        // success need to change the label name
      },
      error: function(xhr) {
        console.log(xhr.responseText)
      }
    })
  }

});
