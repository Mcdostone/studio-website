module ApplicationHelper

	def format_date(date)
		date.strftime('%d/%m/%Y - %H:%M:%S')
	end
end
