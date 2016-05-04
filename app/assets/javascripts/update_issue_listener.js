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

    var _this = this;
    updateIssue(issue, _this);

    $.ajax({
      type: "GET",
      url: '/issue_labels/' + issueNumber,
      success: function(returnData) {
        var issueNumber = this.dataset.number;
        var labels;

        labels =  $.map(returnData, function(label){
          return "<div class='btn btn-xs card-labels "
          + label.name + "' style='background-color:#"
          + label.color + ";margin-top:10px'" + ">"
          + label.name
          + "</div>";
        });

        $('.issue-labels-' + issueNumber).html(labels)

        hideDataLabels();

      }.bind(this),
      error: function(xhr) {
        console.log(xhr.responseText);
      }
    });

  });

}

