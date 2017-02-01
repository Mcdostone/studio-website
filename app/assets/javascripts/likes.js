App.likes = function() {

	let link = $('.like-button')
	let count = ('.count-likes')


	let success = function(res) {
		console.log(res)
		if(res)
			App.flash.warning('', 'Nice !')
		else
			App.flash.warning('', 'Nooooo !')
	}

	link.on('click', function(e) {
		e.preventDefault()	
		
		let added = link.toggleClass('liked')
		console.log(added)
		$.ajax({
  			type: 'POST',
  			url: link.attr('href'),
		 	beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
  			dataType: 'json',
  			success: success,
		})
	})
}


$(function() {
	App.likes()
})