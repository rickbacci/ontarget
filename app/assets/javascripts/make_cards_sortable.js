function makeCardsSortable() {

  $( ".sortable" ).sortable({
    tolerance: "pointer",
    dropOnEmpty: true,
    revert: true,
    containment: "parent"
  });

}
