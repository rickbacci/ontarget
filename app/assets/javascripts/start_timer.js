function startTimer(_this) {

  var timer;
  var timeString   = _this.dataset.timerSeconds;
  var timeInt      = parseInt(timeString);
  var milliSeconds = timeInt * 1000;

  $.notifyDefaults({
    allow_dismiss: false,
    delay: 0,
    time: milliSeconds
  });


  $.notify({
    message: '<div class="timer-graphic"></div>'
  });

  timer = new FlipClock(
    $('.timer-graphic'), timeInt, {
      clockFace: 'MinuteCounter',
      countdown: true,
      timer: milliSeconds,
      autostart: true
    });

    setTimeout(function() {
      $.notifyClose();
    }, milliSeconds + 1000);

    window.setTimeout(giveAlert, milliSeconds + 1000);

}

function giveAlert() {
  alert('Times up!');
}
