var dynamic = require('./dynamic_image_form')

$(function() {
	$('#user_nickname').bind('input',function() {  $('p#nickname').text('@' + $(this).val())  })
	dynamic.setBindingImage($('#user_avatar'), $('#avatar'))
})
