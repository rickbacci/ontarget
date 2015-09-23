$(document).ready(function() {

  $( ".sortable" ).sortable({
    revert: true,
  });

  $( ".panel" ).draggable({
    connectToSortable: ".sortable",
    revert: "invalid",
  });

});
