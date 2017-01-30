App.events = function() {
	let check = function(e) {
		e.preventDefault()
		if($('#event_name').val() == "")
			App.flash.warning("", 'SPÉCyphi 1 N0N STeplé')
		else
		$('form').submit()
	}

	App.covers.setBindingName($('#event_name'))
	App.covers.setBindingDate($('#event_date_event'))
	App.covers.setBindingCover($('#event_cover'))
	App.covers.setActionOnSubmit(check)
}

$(function() {
	App.events()
})