var isHomePage = /testy\/$/.test(window.location.href)

if (!isHomePage) {
  var buttons = {
    next: $('#dalej img'),
    prev: $('#wstecz img'),
    answer_a: $('#__A img'),
    answer_b: $('#__B img'),
    answer_c: $('#__C img'),
    click: function(name) {
      this[name].click();
    }
  }
  var keys = {
    97: 'a',
    98: 'b',
    99: 'c',
    100: 'd',
    102: 'f',
    106: 'j',
    107: 'k',
    110: 'n',
    112: 'p',
    115: 's',
  }
  var keyToButton = {
    s: 'answer_a',
    d: 'answer_b',
    f: 'answer_c',
    j: 'next',
    k: 'prev',
  }

  $(document).bind('keypress', function(event){
    var charCode = event.charCode, key
    console.log(event.keyCode)

    if (key = keys[charCode]) {
      buttons.click(keyToButton[key])
    }
  });
}
