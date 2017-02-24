App.likes = function() {

	let link = $('.like-button')
	let count = $('#like-count')
	let nb = parseInt(count.html())
	let liked = false

	let updateCount = function(nb) {
		count.text(nb)
	}

	let success = function(res) {
		if(res) {
			App.flash.warning('', 'Nice !')
			nb++
		}
		else {
			App.flash.warning('', 'Nooooo !')
			nb--
		}
		updateCount(nb)
	}

	link.on('click', function(e) {
		e.preventDefault()	
		
		let added = link.toggleClass('liked')
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
;
