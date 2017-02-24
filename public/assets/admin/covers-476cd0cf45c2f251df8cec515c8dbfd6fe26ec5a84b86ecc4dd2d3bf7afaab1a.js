App.covers = (function() {
	let name = $('.cover .cover-name')
	let date = $('.cover .cover-date')
	let cover = $('.cover .illustration img')
	let submit = $('input[type=submit]')

	return {
		setBindingName: function(tag) {
			tag.bind('input', function(e) {
				name.html($(this).val())
			})
		},

		setBindingDate: function(tag) {
			tag.bind('change', function() {
				date.html($(this).val())
			})
		},

		setBindingCover: function(tag) {
			App.dynamicImage.setBindingImage(tag, cover)
		},

		setActionOnSubmit: function(f) {
			submit.on('click', f)
		}
	}
})()
;
