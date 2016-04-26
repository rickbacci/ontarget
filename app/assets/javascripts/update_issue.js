function updateIssue(issue, _this) {
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
      console.log('in success');
      console.log(_this);
    },
    error: function(xhr) {
      console.log(xhr.responseText);
    }
  });
}
