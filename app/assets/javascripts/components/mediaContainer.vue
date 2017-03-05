<template>
<div class="grid" id="container-masonry">
	<lightbox id="lightbox"></lightbox>

	<a :href="'/api/media/' + m.id" v-lightbox v-for="m in media" v-if="m.file.thumb.url != undefined" class="item item-medium item-overlay">
		<img :src="m.file.thumb.url" alt="">
	</a>

	<div id="trigger-loading" infinite-scroll-distance="50" infinite-scroll-listen-for-event v-infinite-scroll="loadMore"></div>
</div>

</template>

<script>
import lightbox from './lightboxContainer'

export default {
	data() {
		return {
			media: [],
			page: 1,
			lastPage: 1,
			fetchData: false,
			gridalicious: undefined
		}
	},
	components: {
		lightbox
	},
	methods: {
		loadMore() {
			if(this.fetchData == false && this.page != -1) {
				this.fetchData = true
				let url = '/api' + window.location.pathname + '?page=' + this.page
				console.log('want more -> ' + url)
				this.$http.get(url).then(response => {
					if(response.body.length === 0)
						this.page = -1
					else {
						this.media = this.media.concat(response.body)
						this.page++
						this.fetchData = false
					}
				}, response => console.log(response)
				)
			}
		}
	}
}
</script>
