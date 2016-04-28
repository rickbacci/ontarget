function updateIssueListener() {

  $('li.card-panel').on('change', function() {

    var issueNumber   = this.dataset.number;
    var issueTitle    = $('.title-' + issueNumber).val();
    var issueBody     = $('.body-' + issueNumber).val();
    var checkedLabels = $('.labels-' + issueNumber + ' input:checked');
    var issueLabels   = $.map(checkedLabels, function(label) { return label.value; });
    var oldTimerTime  = this.dataset.timerSeconds;
    var newTimerTime  = $('.timer-time-' + issueNumber).val()

    // remove the old timer value label and add the new

     issueLabels =  $.map(issueLabels, function(label){
        if (label === oldTimerTime) {
          return newTimerTime;
        } else {
          return label;
        }

      });

    this.dataset.timerSeconds = newTimerTime;
    issueLabels = issueLabels.join(' ');

    var issue         = {
      number: issueNumber,
      title:  issueTitle,
      body:   issueBody,
      labels: issueLabels
    };

    var checkedLabels = $('.labels-' + issueNumber + ' input:checked');
    var issueLabels   = $.map(checkedLabels, function(label) { return label.value; });
    $('.issue-labels-' + issue.number).text(issue.labels)
    hideDataLabels();

    updateIssue(issue, this);

  });

}

