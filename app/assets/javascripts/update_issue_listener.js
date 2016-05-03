function updateIssueListener() {

  $('li.card-panel').on('change', function() {

    var issueNumber   = this.dataset.number;
    var issueTitle    = $('.title-' + issueNumber).val();
    var issueBody     = $('.body-' + issueNumber).val();
    var checkedLabels = $('.labels-' + issueNumber + ' input:checked');
    var issueLabels   = $.map(checkedLabels, function(label) { return label.value; });
    var oldTimerTime  = this.dataset.timerSeconds;
    var newTimerTime  = $('.timer-time-' + issueNumber).val()


    issueLabels =  $.map(issueLabels, function(label){
      if (label === oldTimerTime) {
        return newTimerTime;
      } else {
        return label;
      }

    });

    this.dataset.timerSeconds = newTimerTime;

    var issue = {
      number: issueNumber,
      title:  issueTitle,
      body:   issueBody,
      labels: issueLabels
    };

    var checkedLabels = $('.labels-' + issueNumber + ' input:checked');
    var issueLabels   = $.map(checkedLabels, function(label) { return label.value; });
    $('.issue-labels-' + issue.number).text(issue.labels.join(' '))
    hideDataLabels();

    var _this = this;
    updateIssue(issue, _this);

  });

}

