
<template>
	<div>
		<div class="tool" @click.stop.prevent="like" :class="{'lightbox-active': this.user.liked == true}">
			<i class="fa fa-thumbs-o-up" aria-hidden="true" style="margin-right: 5px;"></i>
			{{likes()}} Like
		</div>

		<div @click.stop.prevent="tags" class="tool">
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
		return {}
	},
	props: {
		medium: '',
		user: ''
	},
	methods: {
		tags() {  this.$emit('toggle-tags') },
		tagguer() {  this.$emit('toggle-tagguer') },

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
			return this.medium.count_likes
		}
	},

}

/**

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


sendLike() {
	if(this.state.index !== false) {
		this.medium.count_likes = (this.user.liked == true) ? this.medium.count_likes - 1 : this.medium.count_likes + 1
		this.user.liked = !this.user.liked
		let url = this.state.medias[this.state.index]
		this.$http.post(url + '/like').then(response => {
			}, response => console.log(response)
		)
	}
},
*/
</script>
