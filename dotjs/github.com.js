
if ($('.page-pullrequest').length) {
  $('.diff-view .file').each(function(){
    path = $(this).find('.meta').data('path');

    should_move = path.match(/^(app|lib|spec)\//);

    if (should_move)
      $(this).prependTo($(this).parent());
  });

  $('#toc tr').each(function(){
    path = $(this).find('.path a').text();

    should_move = path.match(/^(app|lib|spec)\//);

    if (should_move)
      $(this).prependTo($(this).parent());
  });
}
