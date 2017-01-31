App.types = function() {
	
	let check = function(e) {
		e.preventDefault()
		let input = $('#type_name')
		if(input.val() === "") {
			input.focus()
			App.flash.warning("", 'SPÉCyphi 1 N0N STeplé')
		}
		else
		$('form').submit()
	}

	App.covers.setBindingName($('#type_name'))
	App.covers.setBindingCover($('#type_cover'))
	App.covers.setActionOnSubmit(check)
}

$(function() {
	App.types()
})