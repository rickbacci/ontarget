function setColumnHeight() {

  var largestHeight = 0;
  var columns =  $('.status-list');

  $('.status-list').height(0);

  $.each( columns, function (i, column, c) {
    if (column.scrollHeight >= largestHeight) {
      largestHeight = column.scrollHeight;
    }
  });

  $('.status-list').height(largestHeight);
}

