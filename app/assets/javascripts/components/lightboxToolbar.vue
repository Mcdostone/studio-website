<template>
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
</template>

<script>
export default {
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

}
</script>
