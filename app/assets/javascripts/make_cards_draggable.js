function makeCardsDraggable() {

  $('.card-panel').draggable({
    connectToSortable: '.sortable',
    cursor: 'move',
    zIndex: 100,
    start: function (event, ui) {
      var newColumn;
      var oldColumn = event.target.dataset.currentcardstatus;
    },
    stop: function(event, ui) {
      newColumn     = event.target.parentElement.dataset.columnstatus;
      oldColumn     = event.target.dataset.currentcardstatus;

      var _this     = this;
      var issueCard = {
        owner:     event.target.dataset.owner,
        repo:      event.target.dataset.repo,
        number:    event.target.dataset.number,
        oldcolumn: oldColumn,
        newcolumn: newColumn
      };

      oldColumn = newColumn;

      updateCardStatus(issueCard, _this);
    }
  });

}
