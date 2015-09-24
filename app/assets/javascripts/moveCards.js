$(document).ready(function() {

  $( ".sortable" ).sortable({
    revert: true,
  });

  $( ".panel" ).draggable({
    start: function(event, ui) {
      console.log('dragging started');

      // var className = $(ui.draggable).attr('class');
    },
    drag: function() {
      console.log('dragging in progress');
    },
    stop: function(event, ui) {
      console.log('dragging stopped');

      var backlog    = this.parentElement.className.includes('backlog');
      var ready      = this.parentElement.className.includes('ready');
      var inProgress = this.parentElement.className.includes('in-progress');
      var completed  = this.parentElement.className.includes('completed');

      if (backlog) {
        $(this).addClass('backlog');
        $(this).removeClass('in-progress ready completed');
      }


      if (ready) {
        $(this).addClass('ready');
        $(this).removeClass('backlog in-progress completed');
      }

      if (inProgress) {
        $(this).addClass('in-progress');
        $(this).removeClass('backlog ready completed');

        window.setTimeout(giveAlert, 2000);
      }

      if (completed) {
        $(this).addClass('completed');
        $(this).removeClass('backlog ready in-progress');
      }

    },
    connectToSortable: ".sortable",
    revert: "invalid",
    cursor: "move"
  });

});

function giveAlert() {
  alert("Times up!");
}

function createPost() {
  $("#create-post").on("click", function(){
    var postParams = {
      post: {
        description: $("#post-description").val()
      }
    }

    $.ajax({
      type:    "POST",
      url:     "https://turing-birdie.herokuapp.com/api/v1/posts.json",
      data:    postParams,
      success: function(post) {
        renderPost(post)
      }
    })
  })
}
