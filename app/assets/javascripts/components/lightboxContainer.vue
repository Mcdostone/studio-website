<template>
	<div v-if="url" @click="close">
			<lightbox-media @click.stop.prevent v-if="loaded" :medium="medium" :key="medium"></lightbox-media>
			<lightbox-overlay id="lightbox-overlay" v-on:like="like" v-on:new-tag="addTag" :medium="medium" v-if="loaded"></lightbox-overlay>
	</div>
</template>

<script>
import Vue from 'vue'
import store from '../lightboxStore'
import lightboxMedia from './lightboxMedia'
import lightboxOverlay from './lightboxOverlay'
import infiniteScroll from 'vue-infinite-scroll'
Vue.use(infiniteScroll)

export default {
	data() {
		return {
			store: store,
			medium: undefined,
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
			else
				this.medium = undefined
		}
	},
	methods: {
		fetch(url) {
			if(url) {
				this.$http.get(url).then(response => {
					console.log(response)
					this.medium = response.body
				}, response => console.log(response))
			}
		},
		addTag(tag) {
			if(this.store.state.index !== false) {
				let url = this.store.state.medias[this.store.state.index]
				this.$http.post(url + '/tag', {tag: {name: tag.tag}}).then(response => {
					this.medium.tags = response.body.tags
					console.log(response)
				}, response => console.log(response))
			}
		},
		like() {
			if(this.store.state.index !== false) {
				let url = this.store.state.medias[this.store.state.index]
				this.$http.post(url + '/like', {}).then(response => {
					this.medium.likes = response.body.likes
					this.medium.liked = response.body.liked
				}, response => console.log(response))
			}
		},
		close() {
			this.medium = undefined
			this.store.close()
		}
	}
}
</script>
