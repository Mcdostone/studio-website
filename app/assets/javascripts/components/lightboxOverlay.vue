<template>
	<div>
		<lightbox-toolbar :medium="medium" v-on:toggle-tags="toggleTags" v-on:like="like" v-on:toggle-tagguer="toggleTagguer" :user="user" id="lightbox-toolbar"></lightbox-toolbar>
		<lightbox-controls></lightbox-controls>
		<lightbox-tags :tags="medium.tags" id="lightbox-tags" v-show="tags"></lightbox-tags>
		<lightbox-tags-input v-on:new-tag="newTag" v-on:toggle-tagguer="toggleTagguer" @click.stop.prevent="toggleTagguer" v-if="tagguer"></lightbox-tags-input>
	</div>
</template>

<script>

import store from '../lightboxStore'
import lightboxControls from './lightboxControls'
import lightboxToolbar from './lightboxToolbar'
import lightboxTags from './lightboxTags'
import lightboxTagsInput from './lightboxTagsInput'

export default {
	data: function() {
			return {
				tags: false,
				tagguer: false,
				timer: undefined
			}
	},
	props: {
		medium: undefined,
		user: undefined
	},
	components: {
		lightboxControls,
		lightboxToolbar,
		lightboxTags,
		lightboxTagsInput
	},
	mounted() {
		this.listener = (e) => {
			if(this.timer) {
				clearTimeout(this.timer)
				this.timer = 0
			}
			$('#lightbox-overlay').fadeIn()
			this.timer = setTimeout(() => {
				if(this.tagguer == false)
					$('#lightbox-overlay').fadeOut()
			}, 2000)
		}
		window.addEventListener('mousemove', this.listener)
	},
	destroyed() {
		window.removeEventListener('mousemove', this.listener)
	},
	methods: {
		toggleTags() { this.tags = !this.tags },

		toggleTagguer() {
			this.tagguer = !this.tagguer
		},

		newTag(tag) {
			this.$emit('new-tag', tag)
			this.tagguer = false
	 	},

		like() {  this.$emit('like')  },
	},
	animateOverlay(e) {
		e.preventDefault()
		clearTimeout(this.timer);
		$('#lightbox-overlay').fadeIn()
		this.timer = setTimeout(function() {
			$('#lightbox-overlay').fadeOut()
		}, 4000)
	}
}
</script>
