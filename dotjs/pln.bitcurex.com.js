
// price in window title
var updateWindowTitle = function() {
  var lastPrice = $('#ticker .last').text();

  window.document.title = "" + lastPrice + " :: bitcurex";
}
setInterval(updateWindowTitle, 1000);

// all-pln button is back!
var $bidButton = $('.form_bid .field.submit');
$bidButton.css({display: 'inline-block', "margin-right": '5px'})
var $a = $('<a href="#" class="all_pln">[ kup ile wlezie ]</a>')
$a.css({display: 'inline-block', "font-size": '11px'});
$bidButton.after($a);

$a.click(function(e) {
  var lastPrice = parseFloat($('#ticker .last').text());
  var btcs = parseFloat($('#calc_bid .max').text());

  $('#bid_currency').val(lastPrice);
  $('#bid_currency').trigger('keyup');
  setTimeout(function(){ $('#bid_bitcoin').val(btcs); }, 0);
  e.preventDefault();
  e.stopPropagation();
});
