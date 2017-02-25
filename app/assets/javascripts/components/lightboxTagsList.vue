<template>
	<div>
	<a :href="'/tags/' + t.id" v-for="t in tags">
		<div class="chip">
			{{t.name}}
		</div>
		</a>
	</div>
</template>

<script>
export default {
	data() {
		return {}
	},
	props: {
		tags: ''
	}
}
</script>
