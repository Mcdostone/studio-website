//= require cable

window.jQuery = window.$ = $ = global.jQuery = jQuery =require('jquery')
require('jquery-ujs')
require('materialize-css')
require('./navbar')

$(document).ready(function(){
  $('.parallax-container .cover').parallax()
})

//require('./cable')
