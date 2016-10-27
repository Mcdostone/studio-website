module ApplicationHelper

	def format_date(date)
		date.strftime('%d/%m/%Y - %H:%M:%S')
	end

	def submit_button_value(model)		
		model.new_record? ? 'Créer' : 'Modifier'
	end
end
