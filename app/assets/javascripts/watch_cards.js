$(document).ready(function() {

  // updateIssueListener();

  setColumnHeight();
  makeCardsSortable();
  makeCardsDraggable();
  repoSearchBox();
  hideDataLabels();

  $('li.card-panel').on('focusout', function() {
    var issueNumber = this.dataset.number;
    var body = event.target.value;
    var title = event.target.previousElementSibling.value;
    var labels = event.target.nextElementSibling.value;
    $.ajax({
      type: 'PATCH',
      url: '/update_issues/' + issueNumber,
      data: {
        issue_number: issueNumber,
        title: title,
        body: body,
        labels: labels
      },
      success: function() {
        console.log('in success');
      },
      error: function(xhr) {
        console.log(xhr.responseText);
      }
    });
  });

});

