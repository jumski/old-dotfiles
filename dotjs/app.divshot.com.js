
$(document).on('keydown', function(e) {
  console.log(e.which);
  // focus component search with slash
  if (e.which == 191) {
    $('.component-search').focus();
    e.preventDefault();
  }
});
