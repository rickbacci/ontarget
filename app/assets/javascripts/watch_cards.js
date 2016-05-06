$(document).ready(function() {

  $(document).ajaxStart(function(){
    $(".modal").show();
  });

  $(document).ajaxStop(function(){
    $(".modal").hide();
  });

  updateIssueListener();

  setColumnHeight();
  makeCardsSortable();
  makeCardsDraggable();
  repoSearchBox();
  hideDataLabels();

  $('li.card-panel').each(function() {
    var time = this.dataset.timerSeconds;
    var num  = this.dataset.number;

    $('.timer-time-' + num).val(time);
  });

  $('.cards').each(function(i, card) {
    var issueNumber = card.dataset.number;
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


});

