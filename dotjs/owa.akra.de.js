
function isLoginPage() {
  return $('.owaLgnBdy').length > 0
}

function hasPassword() {
  return !!getPassword()
}

function getPassword() {
  return localStorage['owa_password']
}

function savePassword(password) {
  localStorage['owa_password'] = password
}

function clearPassword() {
  delete localStorage['owa_password']
}

function doLogin() {
  console.log(localStorage['owa_password'])
  $password.val(getPassword())
  $submit.click()
}

$form = $('[name="logonForm"]')
$password = $('#password')
$submit = $('[type=submit]')

// if (isLoginPage()) {
//   if (hasPassword()) {
//     doLogin()
//   }
//   else {
//
//     $submit.click(function(event){
//       savePassword($password.val())
//     })
//   }
// }
// else {
//   $logout = $('#lo.btn')
//   $logout.click(function(event){
//     clearPassword()
//   })
// }
