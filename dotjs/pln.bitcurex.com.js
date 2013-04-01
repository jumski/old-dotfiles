
var updateWindowTitle = function() {
  var lastPrice = $('#ticker .last').text();

  window.document.title = "" + lastPrice + " :: bitcurex";
}

setInterval(updateWindowTitle, 1000);
