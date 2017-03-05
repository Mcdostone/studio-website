import Vue from 'vue'
import VueResource from 'vue-resource'
import infiniteScroll from 'vue-infinite-scroll'
import tableMedia from './components/tableMedia'

Vue.use(infiniteScroll)
Vue.use(VueResource)
Vue.component('table-media', tableMedia)
Vue.http.headers.common['X-CSRF-TOKEN'] = $('meta[name="csrf-token"]').attr('content')

var vm = new Vue({
	el: '#root-container'
})
