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
		}
	},

	template: `

	<div @click.stop >
		<div v-show="loading" class="loading" :id="loadingIcon"></div>
		<transition name="lightbox-fade">
			<img :src="src" :style="style" :key="src">
		</transition>
	</div>
	`
}

let tagsInput = {
	data() {
		return {}
	},
	props: {
		medium: '',
		options: ''
	},
	mounted() {
		$('.chips-placeholder').material_chip({
			placeholder: 'Enter a tag',
			secondaryPlaceholder: '+Tag',
		})

		$('.chips').on('chip.add', (e, chip) => {
			this.$emit('tag', chip.tag)
			this.options.tagguer = false
		})
		$('.chips input').trigger('focus')

	},
	template: `
		<div class="container">
			<div class="row">
				<div class="col s12 m12 l12" @click.stop.prevent>
					<div class="chips chips-placeholder"></div>
				</div>
			</div>
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
	},
	template: `
		<div>
		<a :href="'/tags/' + t.id" v-for="t in tags">
			<div class="chip">
				{{t.name}}
			</div>
			</a>
		</div>
	`
}


let toolbar = {
	data() {
		return {}
	},
	props: {
		options: '',
		medium: '',
		user: ''
	},
	methods: {
		tags() {
			this.$emit('tags')
		},
		tagguer() {
			this.$emit('tagguer')
		},
		urlReport() {
			if(this.medium)
				return '/media/' + this.medium.id + '/report'
			else
				return '#'
		},
		like() {
			this.$emit('like')
		},
		liked() {
			if(this.medium)
				return this.medium.liked
			return false
		},
		likes() {
			if(this.medium) {
				if(this.medium.count_likes !== 0)
					return this.medium.count_likes
			}
			return ''
		}
	},
	template: `
	<div>
		<div class="tool" :class="{'lightbox-active': this.user.liked == true}" @click.stop.prevent="like">
			<i class="fa fa-thumbs-o-up" aria-hidden="true"></i>
			{{likes()}} Like
		</div>
		<div class="tool" :class="{'lightbox-active': options.tags}" @click.stop.prevent="tags">
			Tags
		</div>
		<div class="tool" @click.stop.prevent="tagguer" :class="{'lightbox-active': options.tagguer}">
			Tagger
		</div>
			<a :href="urlReport()" class="tool">
				Signaler
			</a>
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
			user: {},
			lastTimeMouseMoved: undefined,
			options: {
				tags: false,
				tagguer: false
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
			return this.medium !== undefined && this.medium !== ''
		},

		url() {
			if(this.state.index !== false) {
				let url = this.state.medias[this.state.index]
				this.fetch(url)
				return url
			}
			else
				return undefined
		},
	},
	methods: {
		fetch(url) {
			if(url) {
				this.$http.get(url).then(response => {
					this.medium = response.body.medium
					this.user.liked = response.body.liked
					this.loaded = true
					}, response => console.log(response)
				)
			}
			else
				return undefined
		},

		addTag(tagName) {
			if(this.state.index !== false) {
				let url = this.state.medias[this.state.index]
				this.$http.post(url + '/tag', {tag: {name: tagName}}).then(response => {
					this.medium.tags = response.body.tags
					}, response => console.log(response)
				)
			}
		},

		direction() {
			return 'lightbox-' + this.dir
		},

		toggleTags() {
			this.options.tags = !this.options.tags
		},

		closeTagguer() {
			this.options.tagguer = false
		},
		sendLike() {
			if(this.state.index !== false) {
				this.medium.count_likes = (this.user.liked == true) ? this.medium.count_likes - 1 : this.medium.count_likes + 1
				this.user.liked = !this.user.liked
				let url = this.state.medias[this.state.index]
				this.$http.post(url + '/like').then(response => {
					}, response => console.log(response)
				)
			}
		},

		toggleTagguer() {
			this.options.tagguer = !this.options.tagguer
			if(this.options.tagguer)
				$('.chips-placeholder').material_chip({
					placeholder: 'Enter a tag',
					secondaryPlaceholder: '+Tag',
				})
		},

		close() {
			if(this.options.tagguer)
				this.options.tagguer = false
			else {
				store.close()
				this.options.tagguer = false
				this.medium = undefined
			}
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
			<lightbox-toolbar v-on:like="sendLike" v-on:tags="toggleTags" v-on:tagguer="toggleTagguer" id="lightbox-toolbar" :medium="medium" :options="options" :user="user"></lightbox-toolbar>
			<div class="lightbox-button" id="previous" @click.prevent.stop="prev">&lt;</div>
			<div id="next" class="lightbox-button" @click.prevent.stop="next">&gt;</div>
			<div id="close" class="lightbox-button" @click.prevent.stop="close">X</div>
			<lightbox-media v-if="loaded" :medium="medium" :key="medium"></lightbox-media>
			<lightbox-tags  id="lightbox-tags" v-if="options.tags && loaded" :tags="medium.tags"></lightbox-tags>
			<lightbox-tags-input v-on:tag="addTag" @click.stop="closeTagguer" class="lightbox-tags-input" :options="options" :medium="medium" v-if="loaded && options.tagguer"></lightbox-tags-input>
		</div>
	</div>
	`
}

Vue.component('lightbox', lightbox)
Vue.component('lightbox-media', media)
Vue.component('lightbox-tags', tags)
Vue.component('lightbox-toolbar', toolbar)
Vue.component('lightbox-tags-input', tagsInput)


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
;
