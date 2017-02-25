<template>
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
	</template>

<script>
export default {
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
	}
}
</script>
