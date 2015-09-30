$(document).ready(function() {

  var loading = $('.spinner').hide();

  function pageLoadStop() {
    $('.spinner').hide();
    $('.container-fluid').show();
  }

  function pageLoadStart() {

    function pageLoadStop() {
      $('.spinner').hide();
      $('.container-fluid').show();
    }

    $('.container-fluid').hide();
    $('.spinner').show();

    window.setTimeout(pageLoadStop, 2000);
  }
});
