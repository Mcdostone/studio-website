<template>
	<div v-if="url" @click="close">
			<lightbox-media @click.stop.prevent v-if="loaded" :medium="medium" :key="medium"></lightbox-media>
			<lightbox-overlay v-on:like="like" v-on:new-tag="addTag" :medium="medium" :user="user" v-if="loaded"></lightbox-overlay>
	</div>
	</template>

<script>
import store from '../lightboxStore'
import lightboxMedia from './lightboxMedia'
import lightboxOverlay from './lightboxOverlay'


export default {
	data() {
		return {
			store: store,
			medium: undefined,
			user: {liked: false},
		}
	},
	components: {
		lightboxMedia,
		lightboxOverlay
	},

	computed: {
		loaded() {
			return this.medium !== undefined && this.medium !== ''
		},

		url() {
			if(this.store.state.index !== false) {
				let url = this.store.state.medias[this.store.state.index]
				this.fetch(url)
				return url
			}
			else {
				this.medium = undefined
				return undefined
			}
		},
	},
	methods: {
		fetch(url) {
			if(url) {
				this.$http.get(url).then(response => {
					this.medium = response.body.medium
					this.user.liked = response.body.liked
					}, response => console.log(response)
				)
			}
			else
				return undefined
		},
		
		addTag(tag) {
			if(this.store.state.index !== false) {
				let url = this.store.state.medias[this.store.state.index]
				this.$http.post(url + '/tag', {tag: {name: tag.tag}}).then(response => {
					this.medium.tags = response.body.tags
				}, response => console.log(response))
			}
		},

		like() {
			if(this.store.state.index !== false) {
				let url = this.store.state.medias[this.store.state.index]
				this.$http.post(url + '/like').then(response => {
					this.user.liked = response.body.liked
					this.medium.count_likes = this.user.liked ? this.medium.count_likes + 1 : this.medium.count_likes - 1
				}, response => console.log(response))
			}
		},

		close() {
			this.store.close()
		}
	}
}
</script>
