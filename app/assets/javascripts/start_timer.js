function startTimer(_this) {

  var timer;
  var timeString   = _this.dataset.timerSeconds;
  var timeInt      = parseInt(timeString);
  var milliSeconds = timeInt * 1000;

  timer            = new FlipClock(
    $('.timer-graphic'), timeInt, {
      clockFace: 'MinuteCounter',
      countdown: true,
      autostart: true
    });

  window.setTimeout(giveAlert, milliSeconds + 1000);

}

function giveAlert() {
  alert('Times up!');
}
