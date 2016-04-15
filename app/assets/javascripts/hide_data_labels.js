function hideDataLabels() {
  $.each(['5', '300', '600', '1500', '3000'] , function(index, time) {
    $('.' + time).hide()
  });

  $.each(['Backlog', 'Ready', 'Current', 'Completed'] , function(index, status) {
    $('.' + status).hide()
  });

}
