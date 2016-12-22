'use strict';

let loader = new Vue({
	el: '#media',
	data: {
		media: []
	},
	created: function() {
		$.getJSON('/media.json',(data) => this.media = data)
	},
	methods: {
		generate_url: function(medium) {
			return 'https://drive.google.com/thumbnail?access_token=' + oauth_token + '&sz=w150&id=' + medium.id_file
		}
	}
})