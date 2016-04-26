function updateIssueListener() {

  $('li.card-panel').on('focusout', function() {

    var issueNumber   = this.dataset.number;
    var issueTitle    = $('.title-' + issueNumber).val();
    var issueBody     = $('.body-' + issueNumber).val();
    var checkedLabels = $('.labels-' + issueNumber + ' input:checked');
    var issueLabels   = $.map(checkedLabels, function(label) { return label.value; }).join(' ');

    var issue         = {
      number: issueNumber,
      title:  issueTitle,
      body:   issueBody,
      labels: issueLabels
    };

    updateIssue(issue, this);

  });

}

