<template>
	<div @click.stop.prevent>
		<div class="tool" @click.stop.prevent="like" :class="{'lightbox-active': medium.liked == true}">
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
			<a @click.stop v-if="isAdmin()" :href="urlAdmin()" class="tool">
				Admin
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
		medium: undefined
	},
	methods: {
		tags() {
			this.$emit('toggle-tags')
			this.tagsVisible = !this.tagsVisible
		},
		tagguer() {  this.$emit('toggle-tagguer') },

		urlAdmin() {
			if(this.medium)
				return '/admin/media/' + this.medium.id + '/edit'
			else
				return '#'
		},

		urlReport() {
			if(this.medium)
				return '/api/media/' + this.medium.id + '/report'
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
		isAdmin() {
			if(this.medium)
				return this.medium.admin
			return false
		},
		likes() {
			if(this.medium) {
				if(this.medium.likes == 0)
					return 'like'
				else
					return this.medium.likes + (this.medium.likes > 1 ? ' likes' : ' like')
			}
		}
	},
}
</script>
