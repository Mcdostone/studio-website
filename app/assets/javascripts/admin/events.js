App.events = (function() {
	let check = function(e) {
		e.preventDefault()
		let input = $('#event_name')
		if(input.val() === "") {
			input.focus()
			App.flash.warning("", 'SPÉCyphi 1 N0N STeplé')
		}
		else
			$('form').submit()
	}

	return {
		init: function() {
			App.covers.setBindingName($('#event_name'))
			App.covers.setBindingDate($('#event_date_event'))
			App.covers.setBindingCover($('#event_cover'))
			App.covers.setActionOnSubmit(check)
		}
	}
})()

$(function() {
	App.events.init()
})