module EventsHelper

	def format_event_date(date)
		date.strftime('%d/%m/%Y')
	end
end
