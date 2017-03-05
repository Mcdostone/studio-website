<template>
	<div @click.stop >
		<div v-show="false" class="loading" :id="loadingIcon"></div>
		<lightbox-image :image="medium"></lightbox-image>
	</div>
</template>


<script>
import lightboxImage from './lightboxImage'

export default {
	data() {
		return {
			loading: true,
			loadingIcon: 'loading1'
		}
	},
	props: {
		medium: '',
		next: ''
	},
	components: {
		lightboxImage
	},
}
</script>
