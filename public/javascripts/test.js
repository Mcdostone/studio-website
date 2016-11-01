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
					m.type = this.types[0]
					//this.guessType(m)
					m.event = this.events[0]
					this.media.push(m)
				}
			})
			this.visible = true;
		},
		generateURL: function(medium) {
			return 'https://drive.google.com/thumbnail?access_token=' + oauth_token + '&sz=w100&id=' + medium.id
		},

		guessType: function(medium) {
			switch(medium.mimeType.split('/')[0].toUpperCase()) {
				case 'IMAGE':
					return 's'
					break;
				case 'VIDEO':
					console.log(medium.mimeType)
			}
		}
	}
})