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
			style: {},
			loadingIcon: 'loading1'
		}
	},
	props: {
		medium: ''
	},
	mounted() {
		let m = new window.Image()
		this.resizeEvent = () =>  this.resize(m)

		this.loadingIcon = 'loading' + Math.floor((Math.random() * 3) + 1)

		m.onload = () => {
			this.loading = false
			this.src = m.src
			this.resize(m)
		}
		m.src = this.medium.file.url
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
			//$('#lightbox .tags').css('width', this.style.left)
		}
	},

	template: `

	<div @click.stop >
		<div v-show="loading" class="loading" v-bind:id="loadingIcon"></div>
		<transition name="lightbox-fade">
			<img :src="src" :style="style" :key="src">
		</transition>
	</div>
	`
}

let tags = {
	data() {
		return {}
	},
	props: {
		tags: ''
	},
	mounted() {
	/*	var tagListArray = ["Apple", "Orange", "Mango"]; //Some new data here
		var data = []
		var index;
		for(index = 0; index < tags.length; index++) {
			data.push({  tag: tags[index]  });
		};
		$('.chips-initial').material_chip({data: data})
		*/
	},
	template: `
		<div>
			<div class="chip" v-for="t in tags">
				{{t.name}}
			</div>
		</div>
	`
}


let toolbar = {
	data() {
		return {}
	},
	props: {
		options: ''
	},
	mounted() {
	},
	methods: {
		tags() {
			this.$emit('tags')
		}
	},
	template: `
	<div>
		<div class="tool" @click.stop.prevent="like">
			Like
			<i class="fa fa-thumbs-o-up" aria-hidden="true"></i>
		</div>
		<div class="tool" :class="{'lightbox-active': options.tags}" @click.stop.prevent="tags">
			Tags
		</div>
		<div class="tool" @click.stop.prevent="tagguer">
			Tagger
		</div>
	</div>
	`
}


let lightbox = {
	data() {
		return {
			state: store.state,
			dir: 'next',
			medium: undefined,
			options: {
				tags: false
			}
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
	computed: {
		loaded() {
			return this.medium !== undefined
		},

		url() {
			if(this.state.index !== false) {
				let url = this.state.medias[this.state.index]
				this.fetch(url)
				return url
			}
			else
				return undefined
		}
	},
	methods: {
		fetch(url) {
			if(url) {
			this.$http.get(url).then(response => {
				this.medium = response.body
				console.log(this.medium)
				}, response => console.log(response)
			)
		}
		else
			return undefined
		},

		direction() {
			return 'lightbox-' + this.dir
		},

		toggleTags() {
			this.options.tags = !this.options.tags
		},

		close() {
			store.close()
			this.medium = undefined
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
	<div v-if="url" @click="close">
		<div>
			<lightbox-toolbar v-on:tags="toggleTags" id="lightbox-toolbar" :options="options"></lightbox-toolbar>
			<div class="lightbox-button" id="previous" @click.prevent.stop="prev">&lt;</div>
			<div id="next" class="lightbox-button" @click.prevent.stop="next">&gt;</div>
			<div id="close" class="lightbox-button" @click.prevent.stop="close">X</div>
			<lightbox-media v-if="loaded" :medium="medium" :key="medium"></lightbox-media>
			<lightbox-tags id="lightbox-tags" v-if="options.tags && loaded" :tags="medium.tags"></lightbox-tags>
		</div>
	</div>
	`
}

Vue.component('lightbox', lightbox)
Vue.component('lightbox-media', media)
Vue.component('lightbox-tags', tags)
Vue.component('lightbox-toolbar', toolbar)

// --------------
//	lightbox directive
// -------------
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

var vm = new Vue({
	el: '#root-container'
})
