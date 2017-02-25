<template>
	<div class="container">
		<div class="row">
			<div class="col s12 m12 l12" @click.stop.prevent>
				<div class="chips chips-placeholder"></div>
			</div>
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
		options: ''
	},
	mounted() {
		$('.chips-placeholder').material_chip({
			placeholder: 'Enter a tag',
			secondaryPlaceholder: '+Tag',
		})

		$('.chips').on('chip.add', (e, chip) => {
			this.$emit('tag', chip.tag)
			this.options.tagguer = false
		})
		$('.chips input').trigger('focus')
	}
}
</script>
