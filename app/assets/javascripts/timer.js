$(document).ready(function() {

  delayedAlert();
  clearAlert();
  startTimer();

  var timeoutID;


  function delayedAlert() {
    $("#show-alert").on("click", function() {
      timeoutID = window.setTimeout(slowAlert, 2000);
    })
  }

  function slowAlert() {
    alert("Times up!");
  }

  function clearAlert() {
    $("#cancel-alert").on("click", function() {
      window.clearTimeout(timeoutID);
    })
  }

  function startTimer() {

    $("#storyState").on("change", function() {
      var x = document.getElementById("storyState").value;
      // document.getElementById("demo").innerHTML = "You selected: " + x;
      if (x === 'in progress') {
        timeoutID = window.setTimeout(slowAlert, 2000);
      }
    })
  }
})
