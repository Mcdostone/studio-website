<template>
	<div @click.stop.prevent>
		<div class="tool" @click.stop.prevent="like" :class="{'lightbox-active': user.liked == true}">
			<i class="fa fa-thumbs-o-up" aria-hidden="true" style="margin-right: 5px;"></i>
			{{likes()}}
		</div>

		<div @click.stop.prevent="tags" :class="{'lightbox-active': tagsVisible == true}" class="tool">
			Tags
		</div>
		<div @click.stop.prevent="tagguer" class="tool" >
			Tagger
		</div>
			<a @click.stop :href="urlReport()" class="tool">
				Signaler
			</a>
		</div>
	</div>
</template>

<script>
export default {
	data() {
		return {
			tagsVisible: false
		}
	},
	props: {
		medium: undefined,
		user: undefined
	},
	methods: {
		tags() {
			this.$emit('toggle-tags')
			this.tagsVisible = !this.tagsVisible
		},
		tagguer() {  this.$emit('toggle-tagguer') },

		urlReport() {
			if(this.medium)
				return '/media/' + this.medium.id + '/report'
			else
				return '#'
		},
		like() {
			if(this.medium)
				this.$emit('like')
		},
		liked() {
			if(this.medium)
				return this.medium.liked
			return false
		},
		likes() {
			if(this.medium) {
				if(this.medium.count_likes == 0)
					return 'like'
				else
					return this.medium.count_likes + (this.medium.count_likes > 1 ? ' likes' : ' like')
			}
		}
	},
}
</script>
