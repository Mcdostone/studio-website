App.users = (function() {

	return {
		init: function() {
			$('#user_nickname').bind('input', function() {
				$('p#nickname').text($(this).val())
			})
		}
	}
})()

$(function() {
	App.users.init()
})
;
