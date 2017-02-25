var covers = require('./covers')
require('materialize-css')

$(function() {
	covers.setBindingName($('#event_name'))
	covers.setBindingDate($('#event_date'))
	covers.setBindingCover($('#event_cover'))
	//covers.setActionOnSubmit(check)

	$('select').material_select()
	$('.datepicker').pickadate({
		selectYears: 15,
		container: '#root-container',
		selectMonths: true,
		format: 'dd/mm/yyyy',
		formatSubmit: 'dd/mm/yyyy'
	})
})

/*
let check = function(e) {
	e.preventDefault()
	let input = $('#event_name')
	if(input.val() === "") {
		input.focus()
		App.flash.warning("", 'SPÉCyphi 1 N0N STeplé')
	}
	else
		$('form').submit()
}*/
