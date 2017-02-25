import Vue from 'vue'
import store from '../stores/lightbox'

Vue.directive('lightbox', {

  bind(el, binding) {
		let index = store.addMedia(el.getAttribute('href'))
		el.addEventListener('click', function(e) {
			e.preventDefault()
			store.load(index - 1)
		})
	},

	unbind(el, binding) {
		store.remove(el.getAttribute('src'))
	}

})
