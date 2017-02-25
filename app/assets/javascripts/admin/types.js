var covers = require('./covers')

$(function() {
	/*let check = function(e) {
		console.log('test')
		e.preventDefault()
		let input = $('#type_name')
		if(input.val() === "") {
			input.focus()
  		Materialize.toast('SPÉCyphi 1 N0N STeplé', 4000)
		}
		else
			$('form').submit()
	}
	*/
	covers.setBindingName($('#type_name'))
	covers.setBindingCover($('#type_cover'))
//	covers.setActionOnSubmit(check)
//	Materialize.updateTextFields()
})
