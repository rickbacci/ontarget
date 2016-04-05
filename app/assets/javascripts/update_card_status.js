function updateCardStatus(card, _this) {

  _this.dataset.currentcardstatus = newColumn

  $.ajax({
    type: "POST",
    url: '/update_card_status',
    data: {
      owner: card.owner,
      repo: card.repo,
      number: card.number,
      oldcolumn: card.oldcolumn,
      newcolumn: card.newcolumn,
    },
    success: function() {
      startTimerIfInProgress(card, _this)
    },
    error: function(xhr) {
      console.log(xhr.responseText);
    }
  });

}

function startTimerIfInProgress(card, _this) {
  if (card.newcolumn === 'In-progress') {
    startTimer(_this);
  }
}
