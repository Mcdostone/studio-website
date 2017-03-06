import Vue from 'vue'
import VueResource from 'vue-resource'
import lightbox from './lightbox'
import mediaContainer from './components/mediaContainer'
import infiniteScroll from 'vue-infinite-scroll'

Vue.use(infiniteScroll)
Vue.use(VueResource)
Vue.component('media-container', mediaContainer)
Vue.http.headers.common['X-CSRF-TOKEN'] = $('meta[name="csrf-token"]').attr('content')

var vm = new Vue({
	el: '#root-container'
})
