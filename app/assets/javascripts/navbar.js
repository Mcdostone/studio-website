let sticky_class = 'sticky'
let oldValue = 0
let trigger_value = 400
$(window).scroll(e => {
  let navbar = $('#nav')
  if( window.pageYOffset > (trigger_value - navbar.height()) )
    navbar.addClass(sticky_class)
  else
    navbar.removeClass(sticky_class)

  /*if(oldValue < window.pageYOffset && window.pageYOffset > trigger_value + navbar.height())
    navbar.addClass('is-hidden')
  else
    navbar.removeClass('is-hidden')
*/
  oldValue = window.pageYOffset
})

let close = function() {
  $('#nav-menu-overlay').removeClass('menu-visible')
  $('body').removeClass('menu-visible')
}

$(function() {
  $('#hamburger').bind( 'tap', function( e ) {
    e.preventDefault()
    $('#nav-menu-overlay').toggleClass('menu-visible')
    $('body').toggleClass('menu-visible')
  })

  $('#nav-menu-overlay a').on('click', e => close())
  $('nav #close').on('click', e => close() )

})
