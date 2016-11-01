Vue.config.debug = true
Vue.config.devtools = true

var media = new Vue({
	el: '#app',
	data: {
		media: [],
		types: [],
		events: []
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
				return ''
			},
			set: function(value) {
				console.log(value.name + ': ' + value.id)
				//this.media.forEach((m) => m.selected = value)
			}
		},
		typeAll: {
			get: function() {
				return ''
			},
			set: function(value) {
				console.log(value.name + ': ' + value.id)
				this.media.forEach((m) => m.type = value.id)
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
					this.media.push(m)
				}
			})
			this.visible = true;
		},
		generateURL: function(medium) {
			return 'https://drive.google.com/thumbnail?access_token=' + oauth_token + '&sz=w100&id=' + medium.id
		},
	}
})