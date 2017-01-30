module EventsHelper

	def format_event_date(date)
		date.strftime('%d/%m/%Y')
	end

	def random_media(event)
		return event.media.sample
	end

	def cover(event)
		event.cover.url ? event.cover.url : '/images/spiral-film.jpeg'
	end
end
