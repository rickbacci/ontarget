function updateColumnIssues(owner, repo, number, oldColumn, newColumn) {

  $.ajax({
    type: "POST",
    url: '/update_column_issue',
    data: { owner: owner,
      repo: repo,
      number: number,
      oldcolumn: oldColumn,
      newcolumn: newColumn,
    },

    success: function(post) {
    },
    error: function(xhr) {
      console.log(xhr.responseText);
    }
  });

}

