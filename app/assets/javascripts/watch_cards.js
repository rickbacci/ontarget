$(document).ready(function() {

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

});

