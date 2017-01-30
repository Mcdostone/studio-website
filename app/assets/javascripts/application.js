//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require cable

App.flash = (function() {
	let closeHTML = `
	<button type="button" class="close" data-dismiss="alert" aria-label="Close">
    	<span aria-hidden="true">&times;</span>
  	</button>`
  	
	let insertMessage = function(container) {
		$('.container-fluid').prepend(container)
	}

	let create = function(level) {
		$('.alert-warning').remove()
		let tmp = $('<div/>')
		let close = $(closeHTML)
		tmp.append(close)
		tmp.addClass('alert alert-dismissible show animated fadeInRight alert-' + level) 
		return tmp
	}
	return {
		warning: function(strong, msg) {
			let c = create('warning')
			c.append('<strong>' + strong  + '</strong> ' + msg)
			insertMessage(c)
		}
	}
})()