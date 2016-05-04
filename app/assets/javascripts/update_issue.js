function updateIssue(issue, _this) {
  var issue = issue;

  $.ajax({
    type: 'PATCH',
    url: '/update_issues/' + issue.number,
    data: {
      issue_number: issue.number,
      title: issue.title,
      body: issue.body,
      labels: issue.labels
    },
    success: function() {
      $.notify({
        message: 'Issue Updated!'
      });

    },
    error: function(xhr) {
      console.log(xhr.responseText);
    }
  });
}
