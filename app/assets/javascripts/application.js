window.jQuery = window.$ = $ = global.jQuery = jQuery = require('jquery')
require('jquery-ujs')
var Materialize = require('materialize-css')
require("materialize-css/js/toasts.js");
require('./navbar')

$(document).ready(function(){
  $('.parallax').parallax()
  Array.from(document.getElementsByClassName('alert')).forEach( n =>
    Materialize.toast(n.innerHTML, 6000)
  )
})
