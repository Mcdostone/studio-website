import Vue from 'vue'
import VueResource from 'vue-resource'
import LightboxOverlay from './components/lightboxOverlay.vue'
Vue.use(VueResource)

// Get the CRSF Token
Vue.http.headers.common['X-CSRF-TOKEN'] = $('meta[name="token"]').attr('value')


// Init gridalicious
$(function() {
	require('grid-a-licious')
	$("#container-masonry").gridalicious({
		  animate: true,
			width: 225,
			gutter: 0,
			animationOptions: {
				queue: true,
				speed: 100,
				effect: 'fadeInOnAppear',
			}
	})
})


/*Vue.component('lightbox', lightbox)
Vue.component('lightbox-media', media)
Vue.component('lightbox-tags', tags)
Vue.component('lightbox-toolbar', toolbar)
Vue.component('lightbox-tags-input', tagsInput)
*/


var vm = new Vue({
	el: '#root-container'
})
