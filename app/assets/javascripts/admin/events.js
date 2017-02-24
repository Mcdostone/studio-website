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
			App.covers.setBindingDate($('#event_date'))
			App.covers.setBindingCover($('#event_cover'))
			App.covers.setActionOnSubmit(check)
		}
	}
})()

$(function() {
	App.events.init()
	$('select').material_select()
	Materialize.updateTextFields()
	$('.datepicker').pickadate({
		selectYears: 15,
		container: '#root-container',
		selectMonths: true,
		format: 'dd/mm/yyyy',
		formatSubmit: 'dd/mm/yyyy'
	})
})
