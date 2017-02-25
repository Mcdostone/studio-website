<template>
	<div>
		<div class="lightbox-button" id="previous" @click.prevent.stop="previous">&lt;</div>
		<div id="next" class="lightbox-button" @click.prevent.stop="next">&gt;</div>
		<div id="close" class="lightbox-button" @click.prevent.stop="close">X</div>
	</div>
</template>

<script>

import store from '../lightboxStore'

export default {
	data: function() {
			return {
				store: store
			}
	},
	mounted() {
		document.onkeydown = (e) => {
			if(e.keyCode == 27)
				this.close()
			if(e.keyCode == 37)
				this.previous()
			if(e.keyCode == 39)
				this.next()
		}
	},
	methods: {
		close() {
			this.store.close()
		},
		next() {
			this.store.next()
		},
		previous() {
			this.store.previous()
		}
	}
}
</script>
