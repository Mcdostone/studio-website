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
				tagguer: false
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
	methods: {
		toggleTags() { this.tags = !this.tags },
		toggleTagguer() {
			this.tagguer = !this.tagguer
		},
		newTag(tag) {
			this.$emit('new-tag', tag)
			this.tagguer = false
	 	},
		like() {  this.$emit('like')  }
	}
}
</script>
