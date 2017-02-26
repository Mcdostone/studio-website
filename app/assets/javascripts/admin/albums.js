var covers = require('./covers')
require('materialize-css')

$(function() {
	covers.setBindingName($('#album_name'))
	covers.setBindingDate($('#album_date'))
	covers.setBindingCover($('#album_cover'))

	$('select').material_select()
	$('.datepicker').pickadate({
		selectYears: 15,
		container: '#root-container',
		selectMonths: true,
		format: 'dd/mm/yyyy',
		formatSubmit: 'dd/mm/yyyy'
	})
})
