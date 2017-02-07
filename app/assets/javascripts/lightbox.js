Vue.http.headers.common['X-CSRF-TOKEN'] = $('meta[name="token"]').attr('value')
// --------------
//	Store
// -------------

class LightboxStore {

	constructor() {
		this.state = {
			medias: [],
			index: false
		}
	}

	addMedia(url) {
		return this.state.medias.push(url)
	}

	load(i) {
		this.state.index = i
	}

	remove(m) {
		this.state.medias = this.state.images.filter(medium => medium  !== m)
	}

	close() {
		this.state.index = false
	}
}



let store = new LightboxStore()


// --------------
//	lightbox component
// -------------

let media = {
	data() {
		return {
			loading: true,
			src: false,
			style: {}
		}
	},
	props: {
		medium: String
	},
	mounted() {
		let m = new window.Image()
		this.resizeEvent = () =>  this.resize(m)

		m.onload = () => {
			this.loading = false
			this.src = m.src
			this.resize(m)
		}
  
		this.$http.get(this.medium).then(response => {
			m.src = response.body.file.url
  		}, response => console.log(response)
  		)
		window.addEventListener('resize', this.resizeEvent)
	},
	destroyed() {
		window.removeEventListener('resize', this.resizeEvent)
	},
	methods: {
		resize(m) {
			let width = m.width
			let height = m.height
			if(width > window.innerWidth || height >  window.innerHeight) {
				let ratioWindow = window.innerWidth / window.innerHeight
				let ratioMedium = width / height
				if(ratioMedium > ratioWindow) {
					width = window.innerWidth
					height = width / ratioMedium
				}
				else {
					height = window.innerHeight
					width = height * ratioMedium
				}
			}
			this.style = {
				width: width + 'px',
				height: height + 'px',
				top: ((window.innerHeight - height) * 0.5)  + 'px',
				left: ((window.innerWidth - width) * 0.5)  + 'px'
			}
		}
	},

	template: `

	<div @click.stop >
		<div v-show="loading" class="loading" id="loading"></div>
		<transition name="lightbox-fade">
			<img :src="src" :style="style" :key="src">
		</transition>
	</div>
	`
}


let lightbox = {
	data() {
		return {
			state: store.state,
			dir: 'next'
		}
	},
	computed: {
		medium() {
			if(this.state.index !== false) 
				return this.state.medias[this.state.index]
			else
				return undefined
		},
		direction() {
			return 'lightbox-' + this.dir
		}

	},
	mounted() {
		document.onkeydown = (e) => {
			if(e.keyCode == 27)
				this.close()
			if(e.keyCode == 37)
				this.prev()
			if(e.keyCode == 39)
				this.next()
		}
	},
	methods: {
		close() {
			store.close()
		},
		next() {
			if(this.medium) {
				this.state.index = (this.state.index == this.state.medias.length - 1) ? 0 : this.state.index + 1
				this.dir = 'next'
			}
		},
		prev() {
			if(this.medium) {
				this.dir = 'previous'
				this.state.index = (this.state.index == 0) ? this.state.medias.length - 1 : this.state.index - 1			
			}
		}
	},
	template: `
	<div v-if="medium" @click="close">
		<div class="lightbox-button" id="previous" @click.prevent.stop="prev">&lt;</div>
		<div id="next" class="lightbox-button" @click.prevent.stop="next">&gt;</div>
		<div id="close" class="lightbox-button" @click.prevent.stop="close">X</div>
		<lightbox-media :medium="medium" :key="medium"></lightbox-media>
	</div>
	`
}



Vue.component('lightbox', lightbox);
Vue.component('lightbox-media', media);


// --------------
//	lightbox directive
// -------------
Vue.directive('lightbox', {
	bind(el, binding) {
		//let index = store.addMedia(el.children[0].children[0].getAttribute('src'))
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

var vm = new Vue({
	el: '#app'
})
