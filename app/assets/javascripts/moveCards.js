
$(document).ready(function() {

  // label radio buttons
  $('.label-btn').on('click', function() {
    console.log('asdf');
  });

  $(function(){
    $(".radio :checked").each(function(index, button){
      var timeValue = this.value;
      console.log(timeValue);
    });
  });

  $('.dropdown-menu input, .dropdown-menu label').click(function(e) {
    e.stopPropagation();
  });

  $('.form').on('keydown', function(e) {
    if(!(e.keyCode == 13 && e.metaKey)) return;

    var target = e.target;
    if(target.form) {
      target.form.submit();
    }
  });


  $(function() {
    $('.noscrollbars').submit( function() {
      add_custom_validation_methods();
      force_ckeditor_to_update();
      $(this).validate({
        meta:"validate",
        onkeyup:true,
        validClass:"ok-input",
        errorPlacement: function(error, element) {}
      });
    });
  });


  $('.column').height($('.col').height());

  $( ".sortable" ).sortable({
    tolerance: "pointer",
    dropOnEmpty: true,
    revert: true,
    containment: "parent"
  });

  $( ".panel" ).draggable({

    connectToSortable: ".sortable",
    // revert: "invalid",
    cursor: "move",
    zIndex: 100,
    // containment: "body", this works

    stop: function(event, ui) {
      console.log('dragging stopped');

      var fromBacklog    = this.className.includes('backlog');
      var fromReady      = this.className.includes('ready');
      var fromInprogress = this.className.includes('in-progress');
      var fromCompleted  = this.className.includes('completed');

      if (fromBacklog) {
        var oldColumn = 'backlog';
      }

      if (fromReady) {
        var oldColumn = 'ready';
      }

      if (fromInprogress) {
        var oldColumn = 'in-progress';
      }

      if (fromCompleted) {
        var oldColumn = 'completed';
      }

      var toBacklog    = this.parentElement.className.includes('backlog');
      var toReady      = this.parentElement.className.includes('ready');
      var toInprogress = this.parentElement.className.includes('in-progress');
      var toCompleted  = this.parentElement.className.includes('completed');

      if (toBacklog && oldColumn !== 'backlog') {
        var newColumn = 'backlog'

          $(this).addClass('backlog');
        $(this).removeClass('in-progress ready completed');

        var owner  = this.dataset.owner
          var repo   = this.dataset.repo
          var number = this.dataset.number

          $.ajax({
            type: "POST",
            url: '/update_labels',
            data: { owner: owner,
              repo: repo,
              number: number,
              oldcolumn: oldColumn,
              newcolumn: newColumn,
            },

            success: function(post) {
              // success need to change the label name
            },
            error: function(xhr) {
              console.log(xhr.responseText)
            }
          })

      }


      if (toReady && oldColumn !== 'ready') {
        var newColumn = 'ready'
          $(this).addClass('ready');
        $(this).removeClass('backlog in-progress completed');


        var owner  = this.dataset.owner
          var repo   = this.dataset.repo
          var number = this.dataset.number

          $.ajax({
            type: "POST",
            url: '/update_labels',
            data: { owner: owner,
              repo: repo,
              number: number,
              oldcolumn: oldColumn,
              newcolumn: newColumn,
            },

            success: function(post) {
              // success need to change the label name
            },
            error: function(xhr) {
              console.log(xhr.responseText)
            }
          })

      }

      if (toInprogress && oldColumn !== 'in-progress') {
        var newColumn = 'in-progress'
          $(this).addClass('in-progress');
        $(this).removeClass('backlog ready completed');

        var owner  = this.dataset.owner
          var repo   = this.dataset.repo
          var number = this.dataset.number

          $.ajax({
            type: "POST",
            url: '/update_labels',
            data: { owner: owner,
              repo: repo,
              number: number,
              oldcolumn: oldColumn,
              newcolumn: newColumn,
            },

            success: function(post) {
              console.log('in success');
              // success need to change the label name
            },
            error: function(xhr) {
              console.log(xhr.responseText)
            }
          })

        timeString = this.dataset.timerMilliseconds
          timeInt = parseInt(timeString)

          var timer;
          timer = new FlipClock($('.timer'), {
            clockFace: 'MinuteCounter',
            autoStart: true,
            countdown: true,
          });

          // 1500 is 25 minutes

          console.log(timeInt);
          timer.setTime(1500);
          timer.start()
          console.log("Timer set for " + timeString)
          window.setTimeout(giveAlert, timeInt);

      }

      if (toCompleted && oldColumn !== 'completed') {
        var newColumn = 'completed'
          $(this).addClass('completed');
        $(this).removeClass('backlog ready in-progress');

        var owner  = this.dataset.owner
          var repo   = this.dataset.repo
          var number = this.dataset.number

          $.ajax({
            type: "POST",
            url: '/update_labels',
            data: { owner: owner,
              repo: repo,
              number: number,
              oldcolumn: oldColumn,
              newcolumn: newColumn,
            },

            success: function(post) {
              // success need to change the label name
            },
            error: function(xhr) {
              console.log(xhr.responseText)
            }
          })
      }
    },
  });

});

function giveAlert() {
  alert("Times up!");
}

function autoGrow (oField) {
  if (oField.scrollHeight > oField.clientHeight) {
    oField.style.height = oField.scrollHeight + "px";
  }
}

function pageLoadStop() {
  $('.spinner').hide();
  $('.container-fluid').show();
}

window.onload = function() {
  console.log('page loaded');
  pageLoadStop();
}

function pageLoadStart() {
  $('.container-fluid').hide();
  $('.spinner').show();
}

