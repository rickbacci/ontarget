$(document).ready(function() {

  function updateIssueLabels() {

    $.ajax({
      type: "POST",

      url: '/update_issue_labels',
      data: { number: number },

      success: function(post) {
        // success need to change the label name
      },
      error: function(xhr) {
        console.log(xhr.responseText)
      }
    })
  }

});
