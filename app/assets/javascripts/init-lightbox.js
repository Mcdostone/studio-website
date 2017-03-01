import Vue from 'vue'
import VueResource from 'vue-resource'
import lightbox from './lightbox'
import lightboxContainer from './components/lightboxContainer'
require('./init-gridalicious')

Vue.use(VueResource)
Vue.http.headers.common['X-CSRF-TOKEN'] = $('meta[name="token"]').attr('value')
Vue.component('lightbox', lightboxContainer)

var vm = new Vue({
	el: '#root-container',
	methods: {
		loadMore() {
			console.log('patou')
		}
	}
})
