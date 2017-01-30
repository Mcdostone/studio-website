App.covers = (function() {
	let name = $('.cover .cover-name')
	let date = $('.cover .cover-date')
	let cover = $('.cover .illustration img')
	let submit = $('input[type=submit]')
	
	return {
		setBindingName: function(tag) {
			tag.bind('input', function() {
				name.html($(this).val())
			})
		},

		setBindingDate: function(tag) {
			tag.bind('change', function() {
				date.html($(this).val())
			})
		},

		setBindingCover: function(tag) {
			tag.bind('change', function(e) {
				if(e.target.files[0]) {
					if(e.target.files[0].type.startsWith('image/')) {
						var reader = new FileReader()
						reader.onload = function () {
							cover.fadeOut(200, function() {
 								$(this).attr('src',reader.result).bind('onreadystatechange load', function(){
         							if (this.complete) 
         								$(this).fadeIn(500);
      							})
							})
        				}
						reader.readAsDataURL(e.target.files[0])
					}
					else {
						App.flash.warning("C'est Martinez le hacker ?", 'Seules les images sont autorisées !')
						$('#event_cover').val('');
					}
				}
			})
		},

		setActionOnSubmit: function(f) {
			submit.on('click', f)
		
		}
	}
})()