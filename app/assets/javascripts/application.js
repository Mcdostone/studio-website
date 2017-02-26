//= require cable

window.jQuery = window.$ = $ = global.jQuery = jQuery =require('jquery')
require('jquery-ujs')
require('materialize-css')
require('./navbar')

$(document).ready(function(){
  if(window.innerHeight > 600 && window.innerWidth > 600)
    $('.parallax').parallax({height: '400px'})
})

//require('./cable')
