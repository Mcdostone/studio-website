Vue.config.debug = true
Vue.config.devtools = true

var media = new Vue({
	el: '#app',
	data: {
		media: [],
		types: [],
		events: [],
		typeForAll: 0,
		eventForAll: 0
	},
	computed: {
		visible: function() {
			return this.media.length != 0
		},
		selectAll: {
			get: function() {
				return this.media.filter(medium => !medium.selected).length === 0
			},
			set: function(value) {
				this.media.forEach((m) => m.selected = value)
			}
		},
		eventAll: {
			get: function() {
				return this.eventForAll
			},
			set: function(value) {
				this.eventForAll = value
				this.media.forEach((m) => {
					if(m.selected)
						m.event = this.eventForAll
				})
			}
		},
		typeAll: {
			get: function() {
				return this.typeForAll
			},
			set: function(value) {
				this.typeForAll = value
				this.media.forEach((m) => {
					if(m.selected)
						m.type = this.typeForAll
				})
			}
		}

	},
	created: function() {
		$.getJSON('/types.json',(data) => this.types = data)
		$.getJSON('/events.json',(data) => this.events = data)
	},
	methods: {
		fetchMedia: function(data) {
			data.forEach((m) => {
				if(!this.media.some((e) => e.id == m.id)) {
					m.selected = false
					this.guessType(m, (t) =>  {
						if(t.length >= 1)
							m.type = t[0]
						else
							m.type = this.types[0]
					})
					m.event = this.events[0]
					m.link = this.createLink(m)
					this.media.push(m)
				}
			})
			this.visible = true;
		},
		generateURL: function(medium) {
			return 'https://drive.google.com/thumbnail?access_token=' + oauth_token + '&sz=w100&id=' + medium.id
		},

		guessType: function(medium, cb) {
			if(medium && medium.mimeType) {
				cb(this.types.filter(type => {
					if(type.mime_types)
						return type.mime_types.toUpperCase().includes(medium.mimeType.toUpperCase())
					else
						return false
				}))
			}
			else
				return undefined
		},
		createLink: function(medium) {
			return 'https://drive.google.com/file/d/' + medium.id
		},

		sendMedia: function() {
			let success = function(e) {
				console.log(e)
			}

			$.ajax({
  				type: "POST",
  				url: '/admin/media',
  				beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
  				//data: JSON.stringify({media: media.media}),
  				data: JSON.stringify({media: this.media}),
  				success: success,
  				dataType: 'json'
			})
		}
	}
})