<template>
	<div  @click.stop.prevent>
	<a :href="'/tags/' + t.id" v-for="t in tags"  @click.stop>
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
		tags: undefined
	}
}
</script>
