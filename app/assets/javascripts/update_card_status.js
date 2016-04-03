function updateCardStatus(card, _this) {

  if (card.newcolumn === 'In-progress') {
    startTimer(_this);
  }

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
    success: function(a, b, c) {
    },
    error: function(xhr) {
      console.log(xhr.responseText);
    }
  });

}

