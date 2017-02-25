let sticky_class = 'sticky'
let oldValue = 0
let trigger_value = 400
$(window).scroll(e => {
  let navbar = $('#nav')
  if( window.pageYOffset > (trigger_value - navbar.height()) )
    navbar.addClass(sticky_class)
  else
    navbar.removeClass(sticky_class)
  oldValue = window.pageYOffset
})

$(function() {
 $('#hamburger').sideNav({
    closeOnClick: true
 })

$(window).resize(() =>
  $('#hamburger').sideNav('hide'))
})
