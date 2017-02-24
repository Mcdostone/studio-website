App.users = (function() {

	return {
		init: function() {
			$('#user_nickname').bind('input', function() {
				$('p#nickname').text('@' + $(this).val())
			})

			App.dynamicImage.setBindingImage($('#user_avatar'), $('#avatar'))
		}
	}
})()

$(function() {
	App.users.init()
})
;
