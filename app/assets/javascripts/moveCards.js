$(document).ready(function() {

  updateIssueListener();
  setColumnHeight();
  makeCardsSortable();

  $('.panel').draggable({

    connectToSortable: '.sortable',
    cursor: 'move',
    zIndex: 100,

    stop: function(event, ui) {
      var owner, repo, number, oldColumn, newColumn;

      var fromBacklog    = this.className.includes('backlog');
      var fromReady      = this.className.includes('ready');
      var fromInprogress = this.className.includes('in-progress');
      var fromCompleted  = this.className.includes('completed');

      if (fromBacklog) {
        oldColumn = 'backlog';
      }

      if (fromReady) {
        oldColumn = 'ready';
      }

      if (fromInprogress) {
        oldColumn = 'in-progress';
      }

      if (fromCompleted) {
        oldColumn = 'completed';
      }

      var toBacklog    = this.parentElement.className.includes('backlog');
      var toReady      = this.parentElement.className.includes('ready');
      var toInprogress = this.parentElement.className.includes('in-progress');
      var toCompleted  = this.parentElement.className.includes('completed');

      if (toBacklog && oldColumn !== 'backlog') {
        newColumn = 'backlog';

        $(this).addClass('backlog');
        $(this).removeClass('in-progress ready completed');

        owner  = this.dataset.owner;
        repo   = this.dataset.repo;
        number = this.dataset.number;

        updateColumnIssues(owner, repo, number, oldColumn, newColumn);

      }


      if (toReady && oldColumn !== 'ready') {
        newColumn = 'ready';
        $(this).addClass('ready');
        $(this).removeClass('backlog in-progress completed');


        owner  = this.dataset.owner;
        repo   = this.dataset.repo;
        number = this.dataset.number;

        updateColumnIssues(owner, repo, number, oldColumn, newColumn);

      }

      if (toInprogress && oldColumn !== 'in-progress') {
        newColumn = 'in-progress';
        $(this).addClass('in-progress');
        $(this).removeClass('backlog ready completed');

        owner  = this.dataset.owner;
        repo   = this.dataset.repo;
        number = this.dataset.number;

        updateColumnIssues(owner, repo, number, oldColumn, newColumn);

        var timeString = this.dataset.timerSeconds;
        var timeInt = parseInt(timeString);

        var timer;


        timer = new FlipClock($('.timer-graphic'), timeInt, {
          clockFace: 'MinuteCounter',
          countdown: true,
          autostart: true
        });

        console.log(timeInt);
        console.log(timer);
        console.log('Timer set for ' + timeString);
        var milliSeconds = timeInt * 1000;
        window.setTimeout(giveAlert, milliSeconds + 1000);


      }

      if (toCompleted && oldColumn !== 'completed') {
        newColumn = 'completed';
        $(this).addClass('completed');
        $(this).removeClass('backlog ready in-progress');

        owner  = this.dataset.owner;
        repo   = this.dataset.repo;
        number = this.dataset.number;

        updateColumnIssues(owner, repo, number, oldColumn, newColumn);

      }
    }

  });

});

function giveAlert() {
  alert('Times up!');
}

