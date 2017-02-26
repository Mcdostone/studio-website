<template>
	<div class="container" @click.stop.prevent="toggleTagguer">
		<div class="row">
			<div class="col s12 m12 l12">
				<div @click.stop.prevent class="chips chips-placeholder"></div>
			</div>
		</div>
	</div>
</template>

<script>
require('materialize-css')

export default {
	data() {
		return {}
	},
	props: {
		medium: undefined
	},
	methods: {
		toggleTagguer() {
			this.$emit('toggle-tagguer')
		}
	},
	mounted() {
		$('.chips-placeholder').material_chip({
			placeholder: 'Enter a tag',
			secondaryPlaceholder: '+Tag',
		})
		$('.chips').on('chip.add', (e, chip) => {
			this.$emit('new-tag', chip)
		})
		$('.chips input').trigger('focus')
	}
}
</script>
